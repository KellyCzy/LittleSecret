//
//  firstVC.swift
//  hack
//
//  Created by 紫瑶 程 on 4/19/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import UIKit

protocol addContactDelegate: class {
    func addContact(to name:String, email:String, image:String)
}

class firstVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ContactTableViewCell
        let person = persons[indexPath.row]
        cell.configure(for: person)
        cell.setNeedsUpdateConstraints()
        cell.selectionStyle = .gray
        return cell
    }
    

    var rightBarButton: UIBarButtonItem!
    var labelHeight: CGFloat = 50

    var tableView: UITableView!
    var persons: [Person]!
    
    let reuseIdentifier = "personCellReuse"
    let cellHeight: CGFloat = 90

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Contacts"
        
        rightBarButton = UIBarButtonItem()
        rightBarButton.title = "Add"
        rightBarButton.target = self
        rightBarButton.style = .plain
        rightBarButton.action = #selector(presentMVC)
        self.tabBarController?.navigationItem.rightBarButtonItem = rightBarButton
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let A = Person(name: "Kelly", email: "301", image: "Kelly")
        let B = Person(name: "Chengyin", email: "111", image: "f1")
        let C = Person(name: "Wenyi",email: "11w", image: "friend")
        let D = Person(name: "Qiaohan", email: "hq24", image:"f2")
        persons = [A, B, C, D]
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        setupConstraints()
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
        pushDetailViewController(name: persons[indexPath.row].name, row: indexPath.row)
    }
}



extension firstVC: addContactDelegate {
    func addContact(to name: String, email:String, image:String) {
        let new_person = Person(name: name,email: email, image:image)
        persons.append(new_person)
        tableView.reloadData()
    }
    
}

