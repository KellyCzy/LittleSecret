//
//  RegisterMVC.swift
//  hack
//
//  Created by 紫瑶 程 on 5/2/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//


import UIKit

class RegisterMVC: UIViewController {
    
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    var passwordLabel: UILabel!
    var passwordTextField: UITextField!
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
        
        emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.text = "Email: "
        emailLabel.textAlignment = .right
        emailLabel.textColor = .black
        view.addSubview(emailLabel)
        
        emailTextField = UITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.text = "Enter your email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocapitalizationType = .none
        emailTextField.backgroundColor = .white
        emailTextField.textAlignment = .center
        emailTextField.textColor = .gray
        emailTextField.clearsOnBeginEditing = true
        view.addSubview(emailTextField)
        
        passwordLabel = UILabel()
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Password: "
        passwordLabel.textAlignment = .right
        passwordLabel.textColor = .black
        view.addSubview(passwordLabel)
        
        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.text = "Enter your password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = .white
        passwordTextField.textAlignment = .center
        passwordTextField.textColor = .gray
        passwordTextField.clearsOnBeginEditing = true
        view.addSubview(passwordTextField)
        
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
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -labelWidth*0.8),
            emailLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: labelHeight * 0.3),
            emailLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            emailLabel.widthAnchor.constraint(equalToConstant: labelWidth)
            ])
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant:4),
            emailTextField.topAnchor.constraint(equalTo: emailLabel.topAnchor, constant: labelHeight/5),
            emailTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            emailTextField.widthAnchor.constraint(equalToConstant: textFieldWidth)
            ])
        NSLayoutConstraint.activate([
            passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -labelWidth*0.8),
            passwordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: labelHeight * 1.3),
            passwordLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            passwordLabel.widthAnchor.constraint(equalToConstant: labelWidth)
            ])
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.trailingAnchor, constant:4),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.topAnchor, constant: labelHeight/5),
            passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            passwordTextField.widthAnchor.constraint(equalToConstant: textFieldWidth)
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
    
    func register(email: String, password: String) {
        NetworkManager.register(email: email, password: password) { user in
            if user != nil {
                print("User with user_id \(user!.user_id) registered!")
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func dismissMVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissAndRegister(){
        if emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
            let alert = UIAlertController(title: "Alert", message: "Register information can't be empty", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
        if let email = emailTextField.text, let password = passwordTextField.text {
            register(email: email, password: password)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}
