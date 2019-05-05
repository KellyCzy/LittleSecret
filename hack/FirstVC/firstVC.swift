//
//  firstVC.swift
//  hack
//
//  Created by 紫瑶 程 on 4/19/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import UIKit

protocol addContactDelegate: class {
    func addContact(to id: Int, email: String)
}

class firstVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ContactTableViewCell
        let friend = persons[indexPath.row]
        cell.configure(for: friend)
        cell.setNeedsUpdateConstraints()
        cell.selectionStyle = .gray
        return cell
    }
    

    var rightBarButton: UIBarButtonItem!
    var labelHeight: CGFloat = 50

    var tableView: UITableView!
    var persons: [Friend] = []
    
    let reuseIdentifier = "personCellReuse"
    let cellHeight: CGFloat = 90

    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tabBarController?.navigationItem.title = "Contacts"
//
//        rightBarButton = UIBarButtonItem()
//        rightBarButton.title = "Add"
//        rightBarButton.target = self
//        rightBarButton.style = .plain
//        rightBarButton.action = #selector(presentMVC)
//        self.navigationController?.navigationItem.rightBarButtonItem = rightBarButton
//        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
//        let A = Person(name: "Kelly", email: "301", image: "Kelly")
//        let B = Person(name: "Chengyin", email: "111", image: "friend")
//        let C = Person(name: "Wenyi",email: "11w", image: "second")
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        if let id = MyVariables.user_id {
            getFriends(user_id: id)
        }
        
        self.tabBarController?.navigationItem.title = "Contacts"
        
        rightBarButton = UIBarButtonItem()
        rightBarButton.title = "Add"
        rightBarButton.target = self
        rightBarButton.style = .plain
        rightBarButton.action = #selector(presentMVC)
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        setupConstraints()
    }
    
    func getFriends(user_id: Int) {
        NetworkManager.getFriendList(user_id: user_id) { (Friends) in
            self.persons = Friends.friends
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print(Friends)
        }
    }
    
    @objc func presentMVC() {
        let modalViewController = ModalViewController()
        modalViewController.delegate = self
        present(modalViewController, animated: true, completion: nil)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
            ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func pushDetailViewController(name:String, row:Int){
        let navViewController = DetailViewController(name: name,row:row)
        navigationController?.pushViewController(navViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            persons.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
}
    
    //Problem
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        pushDetailViewController(name: persons[indexPath.row].email, row: indexPath.row)
    }
}



extension firstVC: addContactDelegate {
    func addContact(to id: Int, email:String) {
        let new_person = Friend(id: id,email: email)
        persons.append(new_person)
        tableView.reloadData()
    }
    
}

