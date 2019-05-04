//
//  ModalViewController.swift
//  hack
//
//  Created by 紫瑶 程 on 4/20/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    var addTextLabel: UILabel!
    var nameLabel: UILabel!
    var nameTextField: UITextField!
    var phoneNumberLabel: UILabel!
    var phoneNumberTextField: UITextField!
    var labelHeight: CGFloat = 50
    var labelWidth: CGFloat = 150
    var textFieldHeight: CGFloat = 35
    var textFieldWidth: CGFloat = 200
    var saveButton: UIButton!
    var cancelButton: UIButton!
    var buttonHeight: CGFloat = 35
    var buttonWidth: CGFloat = 65
    var row:Int!
    var imageUploadLabel: UIButton!
    weak var delegate: addContactDelegate?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .white
            
            addTextLabel = UILabel()
            addTextLabel.translatesAutoresizingMaskIntoConstraints = false
            addTextLabel.text = "Add someone you know!"
            addTextLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            addTextLabel.textAlignment = .center
            addTextLabel.textColor = .black
            addTextLabel.layer.cornerRadius = 10
            view.addSubview(addTextLabel)
            
            nameLabel = UILabel()
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.text = "Name: "
            nameLabel.textAlignment = .right
            nameLabel.textColor = .black
            view.addSubview(nameLabel)
            
            nameTextField = UITextField()
            nameTextField.translatesAutoresizingMaskIntoConstraints = false
            nameTextField.text = "Enter a name"
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
            saveButton.setTitle("Save", for: .normal)
            saveButton.backgroundColor = .green
            saveButton.layer.cornerRadius = 10
            saveButton.addTarget(self, action: #selector(dismissAndSaveContact), for: .touchUpInside)
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
    
    func addFriend(email: String) {
        NetworkManager.addFriend(user: MyVariables.user_id ?? -1, email: email){ user in
            if email != nil {
                print("User wants to add friend")
                self.dismissAndSaveContact()
            } else {
                let alert = UIAlertController(title: "Alert", message: "Invalid Login Information", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
        
        @objc func dismissAndSaveContact(){
            if nameTextField.text != "Enter a name"{
                if let nametext = nameTextField.text, nametext != "" {
                    delegate!.addContact(to: nametext, email: "000", image:"first")
                    _ = navigationController?.popViewController(animated: true)
                }
            }
            
            if nameTextField.text?.isEmpty == true || phoneNumberTextField.text?.isEmpty == true {
                let alert = UIAlertController(title: "Alert", message: "You can't enter empty contact information!", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            }
            dismiss(animated: true, completion: nil)
        }
        
        @objc func dismissMVC() {
            dismiss(animated: true, completion: nil)
        }
        
        func setupConstraints() {
            NSLayoutConstraint.activate([
                addTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                addTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -labelHeight*2),
                addTextLabel.heightAnchor.constraint(equalToConstant: labelHeight),
                addTextLabel.widthAnchor.constraint(equalToConstant: view.bounds.width)
                ])
            NSLayoutConstraint.activate([
                nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -labelWidth*0.8),
                nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -labelHeight),
                nameLabel.heightAnchor.constraint(equalToConstant: labelHeight),
                nameLabel.widthAnchor.constraint(equalToConstant: labelWidth)
                ])
            NSLayoutConstraint.activate([
                nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
                nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: labelHeight/5),
                nameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
                nameTextField.widthAnchor.constraint(equalToConstant: textFieldWidth)
                ])
            NSLayoutConstraint.activate([
                phoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -labelWidth*0.8),
                phoneNumberLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                phoneNumberLabel.heightAnchor.constraint(equalToConstant: labelHeight),
                phoneNumberLabel.widthAnchor.constraint(equalToConstant: labelWidth)
                ])
            NSLayoutConstraint.activate([
                phoneNumberTextField.leadingAnchor.constraint(equalTo: phoneNumberLabel.trailingAnchor),
                phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.topAnchor, constant: labelHeight/5),
                phoneNumberTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
                phoneNumberTextField.widthAnchor.constraint(equalToConstant: textFieldWidth)
                ])
            NSLayoutConstraint.activate([
                saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -buttonWidth*0.8),
                saveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: buttonHeight*1.5),
                saveButton.heightAnchor.constraint(equalToConstant: buttonHeight),
                saveButton.widthAnchor.constraint(equalToConstant: buttonWidth)
                ])
            NSLayoutConstraint.activate([
                cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: buttonWidth*0.8),
                cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: buttonHeight*1.5),
                cancelButton.heightAnchor.constraint(equalToConstant: buttonHeight),
                cancelButton.widthAnchor.constraint(equalToConstant: buttonWidth)
                ])
        }
    }



