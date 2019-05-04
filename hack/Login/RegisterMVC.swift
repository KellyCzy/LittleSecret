//
//  RegisterMVC.swift
//  hack
//
//  Created by 紫瑶 程 on 5/2/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//


import UIKit

class RegisterMVC: UIViewController {
    
    var nameLabel: UILabel!
    var nameTextField: UITextField!
    var phoneNumberLabel: UILabel!
    var phoneNumberTextField: UITextField!
    var saveButton: UIButton!
    var cancelButton: UIButton!
    var buttonHeight: CGFloat = 35
    var buttonWidth: CGFloat = 80
    var labelHeight: CGFloat = 50
    var labelWidth: CGFloat = 150
    var textFieldHeight: CGFloat = 35
    var textFieldWidth: CGFloat = 200
    var Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        Image = UIImageView(frame:.zero)
        Image.translatesAutoresizingMaskIntoConstraints = false
        Image.contentMode = .scaleAspectFit
        Image.image = UIImage(named: "download")
        view.addSubview(Image)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Name: "
        nameLabel.textAlignment = .right
        nameLabel.textColor = .black
        view.addSubview(nameLabel)
        
        nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.text = "Enter your name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.backgroundColor = .white
        nameTextField.textAlignment = .center
        nameTextField.textColor = .gray
        nameTextField.clearsOnBeginEditing = true
        view.addSubview(nameTextField)
        
        phoneNumberLabel = UILabel()
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.text = "Email Address "
        phoneNumberLabel.textAlignment = .right
        phoneNumberLabel.textColor = .black
        view.addSubview(phoneNumberLabel)
        
        phoneNumberTextField = UITextField()
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.text = "Enter an email address"
        phoneNumberTextField.borderStyle = .roundedRect
        phoneNumberTextField.backgroundColor = .white
        phoneNumberTextField.textAlignment = .center
        phoneNumberTextField.textColor = .gray
        phoneNumberTextField.clearsOnBeginEditing = true
        view.addSubview(phoneNumberTextField)
        
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Register", for: .normal)
        saveButton.backgroundColor = .green
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(dismissAndRegister), for: .touchUpInside)
        view.addSubview(saveButton)
        
        cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .red
        cancelButton.layer.cornerRadius = 10
        cancelButton.addTarget(self, action: #selector(dismissMVC), for: .touchUpInside)
        view.addSubview(cancelButton)
    
        setupConstraints()
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            Image.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            Image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Image.heightAnchor.constraint(equalToConstant: 150),
            Image.widthAnchor.constraint(equalToConstant: 150)
            ])
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -labelWidth*0.8),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: labelHeight * 0.3),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            nameLabel.widthAnchor.constraint(equalToConstant: labelWidth)
            ])
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant:4),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: labelHeight/5),
            nameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            nameTextField.widthAnchor.constraint(equalToConstant: textFieldWidth)
            ])
        NSLayoutConstraint.activate([
            phoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -labelWidth*0.8),
            phoneNumberLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: labelHeight * 1.3),
            phoneNumberLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            phoneNumberLabel.widthAnchor.constraint(equalToConstant: labelWidth)
            ])
        NSLayoutConstraint.activate([
            phoneNumberTextField.leadingAnchor.constraint(equalTo: phoneNumberLabel.trailingAnchor, constant:4),
            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.topAnchor, constant: labelHeight/5),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            phoneNumberTextField.widthAnchor.constraint(equalToConstant: textFieldWidth)
            ])
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -buttonWidth*0.8),
            saveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: buttonHeight*4),
            saveButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            saveButton.widthAnchor.constraint(equalToConstant: buttonWidth)
            ])
            saveButton.backgroundColor = UIColor(red: 46/255, green: 150/255, blue: 87/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: buttonWidth*0.8),
            cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: buttonHeight*4),
            cancelButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            cancelButton.widthAnchor.constraint(equalToConstant: buttonWidth)
            ])
            cancelButton.backgroundColor = UIColor(red:255/255, green: 127/255, blue:80/255, alpha: 1)
    }
    
    @objc func dismissMVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissAndRegister(){
        dismissMVC()
    }
    
    
}
