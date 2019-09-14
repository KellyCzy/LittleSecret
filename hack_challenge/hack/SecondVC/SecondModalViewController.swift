//
//  SecondModalViewController.swift
//  hack
//
//  Created by Chengyin Tan on 4/28/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import UIKit

class SecondModalViewController: UIViewController {
    
    var addNewPostLabel: UILabel!
    var newPostTextView: UITextView!
    var labelHeight: CGFloat = 50
    var labelWidth: CGFloat = 150
    var textFieldHeight: CGFloat = UIScreen.main.bounds.height/5*3
    var textFieldWidth: CGFloat = UIScreen.main.bounds.width/5*4
    var saveButton: UIButton!
    var cancelButton: UIButton!
    var buttonHeight: CGFloat = 35
    var buttonWidth: CGFloat = 65
    var id: Int = -1
    weak var delegate: addNewPostDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        
        addNewPostLabel = UILabel()
        addNewPostLabel.translatesAutoresizingMaskIntoConstraints = false
        addNewPostLabel.text = "Share a new secret!"
        addNewPostLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        addNewPostLabel.textAlignment = .center
        addNewPostLabel.textColor = .white
        addNewPostLabel.layer.cornerRadius = 8
        view.addSubview(addNewPostLabel)
        
        newPostTextView = UITextView()
        newPostTextView.translatesAutoresizingMaskIntoConstraints = false
        newPostTextView.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        newPostTextView.textAlignment = .left
        newPostTextView.textColor = .white
        newPostTextView.font = UIFont.systemFont(ofSize: 19)
        newPostTextView.isEditable = true
        newPostTextView.layer.cornerRadius = 16
        view.addSubview(newPostTextView)
        
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = UIColor(red: 46/255, green: 150/255, blue: 87/255, alpha: 1)
        saveButton.addTarget(self, action: #selector(dismissAndSaveContent), for: .touchUpInside)
        saveButton.layer.cornerRadius = 8
        view.addSubview(saveButton)
        
        cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = UIColor(red:255/255, green: 127/255, blue:80/255, alpha: 1)
        cancelButton.addTarget(self, action: #selector(dismissSecondMVC), for: .touchUpInside)
        cancelButton.layer.cornerRadius = 8
        view.addSubview(cancelButton)
        
        
        
        setupConstraints()
    }
    
    @objc func dismissAndSaveContent(){
        if let postText = newPostTextView.text, postText != "" {
            delegate!.addNewpost(to: postText)
            NetworkManager.createPost(user: MyVariables.user_id!, text:postText) { user in
                if user != nil  {
                    //delegate!.addNewpost(to: PostBackend.data.text)
                    print("User just posted!")
                    let tabBarViewController = TabBarViewController()
                    self.navigationController?.pushViewController(tabBarViewController, animated: true)
                } else {
                    let alert = UIAlertController(title: "Alert", message: "Invalid Post Information", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
    
        
        if newPostTextView.text?.isEmpty == true {
            let alert = UIAlertController(title: "Alert", message: "You can't share empty secret!", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissSecondMVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            addNewPostLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addNewPostLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: labelHeight*1.5),
            addNewPostLabel.heightAnchor.constraint(equalToConstant: labelHeight*0.8),
            addNewPostLabel.widthAnchor.constraint(equalToConstant: view.bounds.width)
            ])
        NSLayoutConstraint.activate([
            newPostTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newPostTextView.topAnchor.constraint(equalTo: addNewPostLabel.bottomAnchor, constant: labelHeight/2),
            newPostTextView.heightAnchor.constraint(equalToConstant: textFieldHeight),
            newPostTextView.widthAnchor.constraint(equalToConstant: textFieldWidth)
            ])
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -buttonWidth*0.8),
            saveButton.topAnchor.constraint(equalTo: newPostTextView.bottomAnchor, constant: buttonHeight),
            saveButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            saveButton.widthAnchor.constraint(equalToConstant: buttonWidth)
            ])
        NSLayoutConstraint.activate([
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: buttonWidth*0.8),
            cancelButton.topAnchor.constraint(equalTo: newPostTextView.bottomAnchor, constant: buttonHeight),
            cancelButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            cancelButton.widthAnchor.constraint(equalToConstant: buttonWidth)
            ])
    }
}
