//
//  LoginViewController.swift
//  hack
//
//  Created by Chengyin Tan on 4/21/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var welcome: UIImageView!
    var welcomeWords: UIImageView!
    var usernameLabel: UILabel!
    var usernameTextField: UITextField!
    var passwordLabel: UILabel!
    var passwordTextField: UITextField!
    var registerButton: UIButton!
    var labelHeight: CGFloat = 50
    var labelWidth: CGFloat = 150
    var textFieldHeight: CGFloat = 35
    var textFieldWidth: CGFloat = 200
    var loginButton: UIButton!
    var buttonHeight: CGFloat = 35
    var buttonWidth: CGFloat = 80
    
    var tabBarVC: TabBarViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        welcome = UIImageView(frame:.zero)
        welcome.translatesAutoresizingMaskIntoConstraints = false
        welcome.contentMode = .scaleAspectFit
        welcome.image = UIImage(named: "lock")
        view.addSubview(welcome)
        
        welcomeWords = UIImageView(frame:.zero)
        welcomeWords.translatesAutoresizingMaskIntoConstraints = false
        welcomeWords.contentMode = .scaleAspectFit
        welcomeWords.image = UIImage(named: "words")
        view.addSubview(welcomeWords)
        
        registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = UIColor(red: (190/255), green:(182/255), blue: (255/255),alpha: 1)
        registerButton.addTarget(self, action: #selector(presentRegisterMVC), for: .touchUpInside)
        registerButton.layer.cornerRadius = 8
        view.addSubview(registerButton)
        
        usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "Username: "
        usernameLabel.textAlignment = .right
        usernameLabel.textColor = .black
        view.addSubview(usernameLabel)
        
        usernameTextField = UITextField()
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.text = "Enter your email address"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.textColor = .gray
        usernameTextField.autocapitalizationType = .none
        usernameTextField.backgroundColor = .white
        usernameTextField.textAlignment = .center
        usernameTextField.clearsOnBeginEditing = true
        view.addSubview(usernameTextField)
        
        passwordLabel = UILabel()
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Password: "
        passwordLabel.textAlignment = .right
        passwordLabel.textColor = .black
        view.addSubview(passwordLabel)
        
        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.text = "Enter your password"
        passwordTextField.textColor = .gray
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = .white
        passwordTextField.textAlignment = .center
        passwordTextField.clearsOnBeginEditing = true
        view.addSubview(passwordTextField)
        
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor(red: (255/255), green:(182/255), blue: (193/255),alpha: 1)
        loginButton.layer.cornerRadius = 8
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        view.addSubview(loginButton)
        
        setupConstraints()
    }
    
    @objc func presentRegisterMVC() {
        let modalViewController = RegisterMVC()
        present(modalViewController, animated: true, completion: nil)
    }
    
    func login(email: String, password: String, completion: @escaping () -> Void) {
        NetworkManager.login(email: email, password: password) { user in
            if user != nil {
                print("User with user_id \(user?.user_id ?? -1) logged in!")
                let tabBarViewController = TabBarViewController()
                self.tabBarVC = tabBarViewController
                self.navigationController?.pushViewController(tabBarViewController, animated: true)
                tabBarViewController.email = email
                tabBarViewController.password = password
                if let id = user?.user_id {
                    tabBarViewController.idNumber = String(id)
                    MyVariables.user_id = id
                    completion()
                    print("\(tabBarViewController.email ?? "email") and \(tabBarViewController.idNumber ?? "id")")
                }
            } else {
                let alert = UIAlertController(title: "Alert", message: "Invalid Login Information", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func loginButtonPressed(){
        if usernameTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
            let alert = UIAlertController(title: "Alert", message: "Login information can't be empty", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        }
        if let email = usernameTextField.text, let password = passwordTextField.text {
            login(email: email, password: password) {
                if let userID = MyVariables.user_id {
                    self.tabBarVC.firstViewController.getFriends(user_id: userID)
                }
            }
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            welcome.topAnchor.constraint(equalTo: usernameLabel.topAnchor, constant: -250),
            welcome.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcome.heightAnchor.constraint(equalToConstant: 200),
            welcome.widthAnchor.constraint(equalToConstant: 400)
            ])
        
        NSLayoutConstraint.activate([
            welcomeWords.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            welcomeWords.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeWords.heightAnchor.constraint(equalToConstant: 200),
            welcomeWords.widthAnchor.constraint(equalToConstant: 400)
            ])
        
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: buttonHeight*0.5),
            registerButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            registerButton.widthAnchor.constraint(equalToConstant: buttonWidth)
            ])
        
        NSLayoutConstraint.activate([
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -labelWidth*0.8),
            usernameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            usernameLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            usernameLabel.widthAnchor.constraint(equalToConstant: labelWidth)
            ])
       
        NSLayoutConstraint.activate([
            usernameTextField.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant :4),
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.topAnchor, constant: labelHeight/5),
            usernameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            usernameTextField.widthAnchor.constraint(equalToConstant: textFieldWidth)
            ])
        NSLayoutConstraint.activate([
            passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -labelWidth*0.8),
            passwordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
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
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: buttonHeight*4),
            loginButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            loginButton.widthAnchor.constraint(equalToConstant: buttonWidth)
            ])
    }
    
}

