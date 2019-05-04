//
//  secondVC.swift
//  hack
//
//  Created by Chengyin Tan on 4/19/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import UIKit

protocol addNewPostDelegate: class {
    func addNewpost(to content: String)
}

class secondVC: UIViewController {
    
    var secretCollectionView: UICollectionView!
    var postArray: [Post] = [Post(content: "I love you \n I hate you"), Post(content: "I hate you"), Post(content: "1 + 1 = 2"), Post(content: "I don't like this"), Post(content: "I don't want this")]
    var padding: CGFloat = 10
    var secretTextCellReuseIdentifier: String = "secretTextCellReuseIdentifier"
    var secondRightBarButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Secrets"
        
        secondRightBarButton = UIBarButtonItem()
        secondRightBarButton.title = "New Post"
        secondRightBarButton.target = self
        secondRightBarButton.style = .plain
        secondRightBarButton.action = #selector(presentSecnondMVC)
        self.tabBarController?.navigationItem.rightBarButtonItem = secondRightBarButton
    }
    
    @objc func presentSecnondMVC() {
        let secondModalViewController = SecondModalViewController()
        secondModalViewController.delegate = self
        present(secondModalViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postLayout = UICollectionViewFlowLayout()
        postLayout.scrollDirection = .vertical
        postLayout.minimumInteritemSpacing = padding
        postLayout.minimumLineSpacing = padding
        secretCollectionView = UICollectionView(frame: .zero, collectionViewLayout: postLayout)
        secretCollectionView.translatesAutoresizingMaskIntoConstraints = false
        secretCollectionView.backgroundColor = .white
        secretCollectionView.dataSource = self
        secretCollectionView.delegate = self
        secretCollectionView.register(SecretTextCollectionViewCell.self, forCellWithReuseIdentifier: secretTextCellReuseIdentifier)
        view.addSubview(secretCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            secretCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            secretCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            secretCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            secretCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
    }
    
}

extension secondVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let secretCell = collectionView.dequeueReusableCell(withReuseIdentifier: secretTextCellReuseIdentifier, for: indexPath) as! SecretTextCollectionViewCell
        let post = postArray[indexPath.section]
        secretCell.configure(for: post)
        return secretCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return postArray.count
    }
    
}

extension secondVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
      
    }
    
}

extension secondVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 3*collectionView.frame.width/4)
    }
}

extension secondVC: addNewPostDelegate {
    func addNewpost(to content: String) {
        let new_post = Post(content: content)
        postArray.insert(new_post, at: 0)
        secretCollectionView.reloadData()
    }
    
}

