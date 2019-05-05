//
//  RequestFriendsViewController.swift
//  hack
//
//  Created by Chengyin Tan on 5/5/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import UIKit

class RequestFriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var requestFriendTableView: UITableView!
    var persons: [Friend] = []
    let friendReuseIdentifier = "friendCellReuse"
    let cellHeight: CGFloat = 90
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestFriendTableView = UITableView(frame: .zero)
        requestFriendTableView.translatesAutoresizingMaskIntoConstraints = false
        requestFriendTableView.delegate = self
        requestFriendTableView.dataSource = self
        requestFriendTableView.register(ContactTableViewCell.self, forCellReuseIdentifier: friendReuseIdentifier)
        view.addSubview(requestFriendTableView)
        
        if let id = MyVariables.user_id {
            getRequestedFriends(user_id: id)
        }
        
        setupConstraints()
    }
    
    func getRequestedFriends(user_id: Int) {
        NetworkManager.getFriendRequestList(user_id: user_id) { (Friends) in
            self.persons = Friends.friends
            DispatchQueue.main.async {
                self.requestFriendTableView.reloadData()
            }
            print(Friends)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            requestFriendTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            requestFriendTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            requestFriendTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            requestFriendTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: friendReuseIdentifier, for: indexPath) as! ContactTableViewCell
        let friend = persons[indexPath.row]
        cell.configure(for: friend)
        cell.setNeedsUpdateConstraints()
        cell.selectionStyle = .gray
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = persons[indexPath.row]
        print(friend.id)
        let addFriendAlert = UIAlertController(title: "Adding Friend", message: "You want to add \(friend.email) as your friend", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            self.viewDidDisappear(true)
            self.acceptFriendRequest(user_id: MyVariables.user_id!, requester_id: friend.id)
        }
        
        addFriendAlert.addAction(OKAction)
        self.present(addFriendAlert, animated: true, completion: nil)
    }
    
    func acceptFriendRequest(user_id: Int, requester_id: Int) {
        NetworkManager.addFriend(user_id: user_id, requester_id: requester_id) { FriendRequest in
            DispatchQueue.main.async {
                self.requestFriendTableView.reloadData()
            }
        }

}
}
