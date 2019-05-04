//
//  DetailViewController.swift
//  hack
//
//  Created by 紫瑶 程 on 4/20/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    var personLabel: UILabel!
    var backButton: UIBarButtonItem!
    var personText: String!
    var row:Int!
    
    //weak var delegate: addContactDelegate?
    
    init(name:String,row:Int) {
        self.personText = name
        self.row = row
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        personLabel = UILabel()
        personLabel.translatesAutoresizingMaskIntoConstraints = false
        //personLabel.text = "Song Name:"
        personLabel.text = personText
        personLabel.textColor = .black
        view.addSubview(personLabel)
        // Do any additional setup after loading the view.
        
        
        backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backHome))
        self.navigationItem.leftBarButtonItem = backButton
        
        setupConstraint()
    }
    
    func setupConstraint(){
        NSLayoutConstraint.activate([
            personLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            personLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            personLabel.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 600),
            personLabel.heightAnchor.constraint(equalToConstant: 30),
            personLabel.widthAnchor.constraint(equalToConstant: 600)
            ])
    }
    
    @objc func backHome(_ sender: UIBarButtonItem!) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}
