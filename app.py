import json
from db import db, User, Friendship, Post, Comment
from flask import Flask, request
import user_dao

db_filename = "little_secret.db"
app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

db.init_app(app)
with app.app_context():
    db.drop_all()
    db.create_all()
    user_dao.create_user('hq45@cornell.edu', '1234')
    user_dao.create_user('wg225@cornell.edu', '1234')


def extract_token(request):
    auth_header = request.headers.get('Authorization')
    if auth_header is None:
        return False, json.dumps({'error': 'Missing authorization header.'})

    bearer_token = auth_header.replace('Bearer ', '').strip()
    if not bearer_token:
        return False, json.dumps({'error': 'Invalid authorization header.'}) 

    return True, bearer_token

@app.route('/')
def hello_world():
    return json.dumps({'message': 'Hello, World!'})

@app.route('/register/', methods=['POST'])
def register_account():
    post_body = json.loads(request.data)
    email = post_body.get('email')
    password = post_body.get('password')

    if email is None or password is None:
        return json.dumps({'error': 'Invalid email or password'})
    
    created, user = user_dao.create_user(email, password)

    if not created:
        return json.dumps({'error': 'User already exists'})

    return json.dumps({
        'session_token': user.session_token,
        'session_expiration': str(user.session_expiration),
        'update_token': user.update_token,
        'user_id': user.id
    })

@app.route('/login/', methods=['POST'])
def login():
    post_body = json.loads(request.data)
    email = post_body.get('email')
    password = post_body.get('password')

    if email is None or password is None:
        return json.dumps({'error': 'Invalid email or password'})

    success, user = user_dao.verify_credentials(email, password)

    if not success:
        return json.dumps({'error': 'Incorrect email or password'}) 
    
    return json.dumps({
        'session_token': user.session_token,
        'session_expiration': str(user.session_expiration),
        'update_token': user.update_token,
        'user_id': user.id
    })

@app.route('/session/', methods=['POST'])
def update_session():
    success, update_token = extract_token(request)

    if not success:
        return update_token 

    try:
        user = user_dao.renew_session(update_token)
    except:
        return json.dumps({'error': 'Invalid update token'})

    return json.dumps({
        'session_token': user.session_token,
        'session_expiration': str(user.session_expiration),
        'update_token': user.update_token
    })

@app.route('/secret/', methods=['GET'])
def secret_message():
    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = user_dao.get_user_by_session_token(session_token)
    if not user or not user.verify_session_token(session_token):
        return json.dumps({'error': 'Invalid session token'})

    return json.dumps({'message': 'Logged in as ' + user.email })

@app.route('/friend/request/<int:requester_id>/<int:requested_id>/', methods=['POST'])
def friend_request(requester_id, requested_id):
    if (requester_id < requested_id):
        friendship = Friendship(
            user_1_id = requester_id,
            user_2_id = requested_id,
            status = 1,
            action_user = requester_id
        )
    else:
        friendship = Friendship(
            user_1_id = requested_id,
            user_2_id = requester_id,
            status = 1,
            action_user = requester_id
        )
    db.session.add(friendship)
    db.session.commit()

    return json.dumps({
        'requester': requester_id,
        'requested': requested_id,
        'action_user': friendship.action_user,
        'status': 'pending',
    })

@app.route('/friend/accept/<int:requester_id>/<int:requested_id>/', methods=['POST'])
def friend_accept(requester_id, requested_id):
    relation = user_dao.get_relationship(requester_id, requested_id)
    if relation is None:
        return json.dumps({'success': False, 'error': 'Friendship not found!'}),404
    relation.status = 2
    relation.action_user = requested_id
    db.session.commit()

    return json.dumps({
        'requester': requester_id,
        'requested': requested_id,
        'action_user': relation.action_user,
        'status': 'accepted'
    })

@app.route('/friend/decline/<int:requester_id>/<int:requested_id>/', methods=['POST'])
def friend_decline(requester_id, requested_id):
    relation = user_dao.get_relationship(requester_id, requested_id)
    if relation is None:
        return json.dumps({'success': False, 'error': 'Friendship not found!'}),404
    relation.status = 3
    relation.action_user = requested_id
    db.session.commit()
    return json.dumps({
        'requester': requester_id,
        'requested': requested_id,
        'action_user': relation.action_user,
        'status': 'declined'
    })  

@app.route('/friend/list/<int:user_id>/')
def get_friend_list(user_id):
    friend_list = user_dao.friend_list(user_id)
    return json.dumps({'friends_user_id': friend_list})

@app.route('/posts/<int:user>/', methods=['POST'])
def create_post(user):
    post_body = json.loads(request.data)
    try:
        post = Post(
            text=post_body.get('text'),
            user_id=user
        )
        db.session.add(post)
        db.session.commit()
  
        return json.dumps({'success': True, 'data': post.serialize()}), 201

    except KeyError as e:
        return json.dumps({'success': False, 'data': 'Invalid input'}), 404  

@app.route('/posts/<int:post>/', methods=['DELETE'])
def delete_post(post):
    post = Post.query.filter_by(id=post).first()
    if post is None:
        return json.dumps({'success': False, 'error': 'Post not found!'}), 404
    db.session.delete(post)
    db.session.commit()
    return json.dumps({'success': True, 'data': post.serialize()}), 200

@app.route('/posts/<int:user>/')
def get_user_posts(user):
    posts = Post.query.filter_by(user_id=user).all()
    if posts is None:
        return json.dumps({'success': False, 'error': 'Posts not found'}), 404
    return json.dumps({'success': True, 'data': [post.serialize() for post in posts]})

@app.route('/friend/posts/<int:user_id>/')
def get_friend_posts(user_id):
    posts = []
    friend_list = user_dao.friend_list(user_id)
    for i in friend_list:
        posts = Post.query.filter_by(user_id=i).all()
    return json.dumps({'success': True, 'data': [post.serialize() for post in posts]})


@app.route('/comment/<int:userid>/<int:postid>/', methods=['POST'])
def create_comment(userid, postid):
    post_body = json.loads(request.data)
    try:
        comment = Comment(
            text=post_body.get('text'),
            user_id=userid,
            post_id=postid
        )
        db.session.add(comment)
        db.session.commit()
  
        return json.dumps({'success': True, 'data': comment.serialize()}), 201

    except KeyError as e:
        return json.dumps({'success': False, 'data': 'Invalid input'}), 404  

@app.route('/comment/<int:comment_id>/', methods=['DELETE'])
def delete_comment(comment_id):
    comment = Comment.query.filter_by(id=comment_id).first()
    if comment is None:
        return json.dumps({'success': False, 'error': 'Comment not found!'}), 404
    db.session.delete(comment)
    db.session.commit()
    return json.dumps({'success': True, 'data': comment.serialize()}), 200

@app.route('/comments/<int:user>/')
def get_user_comments(user):
    comments = Comment.query.filter_by(user_id=user).all()
    if comments is None:
        return json.dumps({'success': False, 'error': 'Comments not found'}), 404
    return json.dumps({'success': True, 'data': [comment.serialize() for comment in comments]})

# like system

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
