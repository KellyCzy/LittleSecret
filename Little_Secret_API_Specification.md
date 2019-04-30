# Little Secret API Specification
Endpoint: http://34.74.44.203/

## Home Page

*Request:* `GET` `/`
*Response:*

    {"message": "Hello, World!"}
## Register a user

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

*Request:* **`POST` ```/friend/request/<int:requester_id>/<int:requested_id>``/`
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
     'friends_user_id': [1, 2, 3]
    }
## Create a post

*Request:* **`POST` ```/post/<int:user>``/`
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

*Request:* **`DELETE` ```/post/<int:post>``/`
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

