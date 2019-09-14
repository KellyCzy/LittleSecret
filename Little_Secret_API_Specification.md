# Little Secret API Specification
Endpoint: http://34.74.44.203/

## Data already created in databse
    user1 = User(id = 1, email='wg225@cornell.edu', password='1234')
    user2 = User(id = 2, email='hq45@cornell.edu', password='1234')
    user3 = User(id = 3, email='zc96@cornell.edu', password='5678')
    user4 = User(id = 4, email='cnt26@cornell.edu', password='5678')
    
    post1 = Post(text = "User 1 first post", user_id = 1)
    post2 = Post(text = "User 2 first post", user_id = 2)
    post3 = Post(text = "User 3 first post", user_id = 3)
    post4 = Post(text = "User 4 first post", user_id = 4)
    
    relation1 = Friendship(user_1_id=1, user_2_id=2, status =2, action_user=2)
    relation2 = Friendship(user_1_id=1, user_2_id=3, status =2, action_user=3)
    relation3 = Friendship(user_1_id=1, user_2_id=4, status =1, action_user=1)
    

User 1 sends friend request to user 2, user 3, and they accept and become friends. (relation.status = 2(‘accepted’))
User 1 sends a friend request to user 4 but user 4 is not responsed yet. (relation.status = 1(‘pending’))


1. The app can be tested  by logging in into user 1 account and see user 2 and user 3's posts. 
2. The app can then tested by logging in into user 4 account and see pending friend request from user 1.
3. Each user can see his/her own posts in personal information page.


## Home Page

*Request:* `GET` `/`
*Response:*

    {"message": "Hello, World!"}
    Register a user

*Request:* `POST` ```/register``/`
Post body:

    {
      "email": wg225@cornell.edu
      "password": 1234
    }

*Response:*

    {
      'session_token': user.session_token, # no need to iOS
      'session_expiration': str(user.session_expiration), # no need to iOS
      'update_token': user.update_token, # no need to iOS
      'user_id': user.id
    }
## User Login

*Request:* **`POST` ```/login``/`
Post body:

    {
      "email": wg225@cornell.edu
      "password": 1234
    }

*Response:*

    {
      'session_token': user.session_token, # no need to iOS
      'session_expiration': str(user.session_expiration), # no need to iOS
      'update_token': user.update_token, # no need to iOS
      'user_id': user.id
    }
## Send a friend request

*Request:* **`POST` ```/friend/request/<int:requester_id>/<requested_email>``/`
*Respons**e**:*

    {
      'requester': 1,
      'requested': 2,
      'action_user': 1,
      'status': 'pending'
    }
## Accept a friend request

*Request:* **`POST` ```/friend/accept/<int:requester_id>/<int:requested_id>``/`
*Response:*

    {
      'requester': 1,
      'requested': 2,
      'action_user': 2,
      'status': 'accepted'
    }
## Decline a friend request

*Request:* **`POST` ```/friend/decline/<int:requester_id>/<int:requested_id>``/`
*Response:*

    {
      'requester': 1,
      'requested': 2,
      'action_user': 2,
      'status': 'declined'
    }
## Get a user’s friend list

*Request:* **`GET` ```/friend/list/<int:user_id>``/`
*Response:*

    {
     'friends': [
        {'id': 1,
        'email': "wg225@cornell.edu"},
        {'id': 2,
        'email': "hq45@cornell.edu"},
      ]
    }
## Get a user’s request friend list

*Request:* **`GET` ```/friend/request/list/<int:user_id>``/`
*Response:*

    {
     'friends': [
        {'id': 1,
        'email': "wg225@cornell.edu"},
        {'id': 2,
        'email': "hq45@cornell.edu"},
      ]
    }
## Create a post

*Request:* **`POST` ```/posts/<int:user>``/`
Post body:

    {
      "text": "My post!"
    }

*Response:*

    {
      'success': True, 
      'data': {
        "id": 1, 
        "text": "user 1 first post", 
        "comments": []
      }
    }
## Delete a post

*Request:* **`DELETE` ```/posts/<int:post>``/`
*Response:*

    {
      'success': True, 
      'data': {
        "id": 1, 
        "text": "user 1 first post", 
        "comments": []
      }
    }
## Get a user’s posts

*Request:* **`GET` ```/posts/<int:user>``/`
*Response:*

    {
      'success': True, 
      'data': [{
          "id": 1, 
          "text": "user 1 first post", 
          "comments": [
            {"id": 1, "text": "user 2 first comment to post 1", "post_id": 1}, 
            {"id": 2, "text": "user 2 second comment to post 1", "post_id": 1}
          ]
      },{
          "id": 2, 
          "text": "user 1 second post", 
          "comments": []
      }
      ]
    }
## Get a user’s friends posts

*Request:* **`GET` ```/friend/posts/<int:user_id>``/`
*Response:*

    {
      'success': True, 
      'data': [{
          "id": 1, 
          "text": "user 1 first post", 
          "comments": [
            {"id": 1, "text": "user 2 first comment to post 1", "post_id": 1}, 
            {"id": 2, "text": "user 2 second comment to post 1", "post_id": 1}
          ]
      },{
          "id": 2, 
          "text": "user 2 first post", 
          "comments": []
      },{
          "id": 3, 
          "text": "user 3 first post", 
          "comments": []
      }]
    }
## Create a comment

*Request:* **`POST` ```/comment/<int:userid>/<int:postid>``/`
*Response:*

    {
      'success': True, 
      'data': {
        "id": 1, 
        "text": "user 1 first comment", 
        "liked": 0,
        "post_id": 1
      }
    }
## Like a comment

*Request:* **`POST` ```/comment/<int:comment_id>``/like``/`
*Response:*

    {
      'success': True, 
      'data': {
        "id": 1, 
        "text": "user 1 first comment", 
        "liked": 1,
        "post_id": 1
      }
    }
## Delete a comment

*Request:* **`DELETE` ```/comment/<int:comment_id>``/`
*Response:*

    {
      'success': True, 
      'data': {
        "id": 1, 
        "text": "user 1 first comment", 
        "liked": 0,
        "post_id": 1
      }
    }
## Get a user’s comments

*Request:* **`GET` ```/comments/<int:user>``/`
*Response:*

    {
      "success": true, 
      "data": [{
        "id": 1, 
        "text": "user 2 first comment to post 1",
        "liked": 0,
        "post_id": 1
      },{
        "id": 3, 
        "text": "user 2 first comment to post 2",
        "liked": 0,
        "post_id": 2
     }]
    }

