//
//  thirdVC.swift
//  hack
//
//  Created by Chengyin Tan on 4/19/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import UIKit

class thirdVC: UIViewController {
    
    var emailLabel: UILabel!
    var emailTextLabel: UILabel!
    var idLabel: UILabel!
    var idTextLabel: UILabel!
    var imageUpload: UIButton!
    var signOut: UIBarButtonItem!
    var imageSize: CGFloat = 100
    var profileImage: UIImage!
    var padding: CGFloat = 10
    var labelHeight: CGFloat = 20
    var labelWidth: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Information"
        profileImage = UIImage(named: "placeholder")
        
        signOut = UIBarButtonItem()
        signOut.title = "Sign Out"
        signOut.target = self
        signOut.style = .plain
        signOut.action = #selector(popToRootViewController)
        self.navigationItem.rightBarButtonItem = signOut
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        imageUpload = UIButton()
        imageUpload.translatesAutoresizingMaskIntoConstraints = false
        imageUpload.setTitle("upload Image", for: .normal)
        imageUpload.backgroundColor = .gray
        imageUpload.setImage(profileImage, for: .normal)
        imageUpload.addTarget(self, action: #selector(changeProfileImage), for: .touchUpInside)
        view.addSubview(imageUpload)
        
        emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.text = "Email: "
        emailLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        emailLabel.textAlignment = .left
        emailLabel.textColor = .black
        view.addSubview(emailLabel)
        
        emailTextLabel = UILabel()
        emailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextLabel.text = "email"
        emailTextLabel.font = UIFont.systemFont(ofSize: 16)
        emailTextLabel.textAlignment = .left
        emailTextLabel.textColor = .gray
        view.addSubview(emailTextLabel)
        
        idLabel = UILabel()
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.text = "ID Number: "
        idLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        idLabel.textAlignment = .left
        idLabel.textColor = .black
        view.addSubview(idLabel)
        
        idTextLabel = UILabel()
        idTextLabel.translatesAutoresizingMaskIntoConstraints = false
        idTextLabel.text = "id"
        idTextLabel.font = UIFont.systemFont(ofSize: 16)
        idTextLabel.textAlignment = .left
        idTextLabel.textColor = .gray
        view.addSubview(idTextLabel)
        
        if let tbc = self.tabBarController as? TabBarViewController {
            if let email = tbc.email {
                emailTextLabel.text = email
            }
            if let id = tbc.idNumber {
                idTextLabel.text = id
            }
        }
        
        setupConstraints()

    }
    
    @objc func popToRootViewController(){
        self.tabBarController?.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func changeProfileImage(){
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageUpload.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageUpload.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding*2),
            imageUpload.heightAnchor.constraint(equalToConstant: imageSize),
            imageUpload.widthAnchor.constraint(equalToConstant: imageSize)
            ])
        NSLayoutConstraint.activate([
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailLabel.topAnchor.constraint(equalTo: imageUpload.bottomAnchor, constant: padding*2),
            emailLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            emailLabel.widthAnchor.constraint(equalToConstant: labelWidth)
            ])
        NSLayoutConstraint.activate([
            emailTextLabel.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: padding),
            emailTextLabel.topAnchor.constraint(equalTo: imageUpload.bottomAnchor, constant: padding*2),
            emailTextLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            emailTextLabel.widthAnchor.constraint(equalToConstant: labelWidth*4)
            ])
        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            idLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
            idLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            idLabel.widthAnchor.constraint(equalToConstant: labelWidth)
            ])
        NSLayoutConstraint.activate([
            idTextLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: padding),
            idTextLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
            idTextLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            idTextLabel.widthAnchor.constraint(equalToConstant: labelWidth*4)
            ])
    }
    
}
