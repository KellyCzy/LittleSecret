//
//  SecretTextCollectionViewCell.swift
//  hack
//
//  Created by Chengyin Tan on 4/27/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import UIKit

class SecretTextCollectionViewCell: UICollectionViewCell {
    var secretTextView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        secretTextView = UITextView()
        secretTextView.translatesAutoresizingMaskIntoConstraints = false
        secretTextView.font = UIFont.systemFont(ofSize: 16)
        secretTextView.isEditable = false
        secretTextView.backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1), green: CGFloat.random(in: 0.5...1), blue: CGFloat.random(in: 0.5...1), alpha: 1)
        secretTextView.textAlignment = .center
        secretTextView.layer.cornerRadius = 16
        contentView.addSubview(secretTextView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            secretTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            secretTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            secretTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            secretTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    
    func configure(for post: Post) {
        secretTextView.text = post.content
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


