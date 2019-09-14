from db import db, User, Friendship, Post, Comment

def get_user_by_email(email):
    return User.query.filter(User.email == email).first()

def get_user_by_session_token(session_token):
    return User.query.filter(User.session_token == session_token).first()

def get_user_by_update_token(update_token):
    return User.query.filter(User.update_token == update_token).first()

def verify_credentials(email, password):
    optional_user = get_user_by_email(email)

    if optional_user is None:
        return False, None
    
    return optional_user.verify_password(password), optional_user

def create_user(email, password):
    optional_user = get_user_by_email(email)

    if optional_user is not None:
        return False, optional_user

    user = User(
        email=email,
        password=password
    )

    db.session.add(user)
    db.session.commit()
    return True, user

def renew_session(update_token):
    user = get_user_by_update_token(update_token)
    print(user)
    if user is None:
        raise Exception('Invalid update token')
    
    user.renew_session()
    db.session.commit()
    return user

def get_relationship(user1, user2):
    if (user1 < user2):
        return Friendship.query.filter(db.and_(Friendship.user_1_id==user1, Friendship.user_2_id==user2)).first()
    else:
        return Friendship.query.filter(db.and_(Friendship.user_1_id==user2, Friendship.user_2_id==user1)).first()

def check_friendship(first, second):
    relation = get_relationship(first, second)
    if (relation is not None and relation.status == 2):
        return True
    else:
        return False

def num_users():
    print(db.session.query(User).count())
    return db.session.query(User).count()

def friend_list(user_id):
    friend_list = []
    for i in range(0, num_users()+1):
        user = User.query.filter(User.id==i).first()
        if (check_friendship(i, user_id)):
            friend_list.append(user) # add the user to user_id's friendlist
    return friend_list

def request_friend_list(user_id):
    friend_list = []
    for i in range(0, num_users()+1):
        user = User.query.filter(User.id==i).first()
        relation = get_relationship(user_id, i)
        if relation is not None and relation.status == 1 and relation.action_user == i:
            friend_list.append(user)
    return friend_list

    
