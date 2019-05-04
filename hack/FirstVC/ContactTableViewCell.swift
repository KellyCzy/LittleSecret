//
//  ContactTableViewCell.swift
//  hack
//
//  Created by 紫瑶 程 on 4/20/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var Image:UIImageView!
    
    let padding: CGFloat = 8
    let labelHeight: CGFloat = 16
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize:16)
        contentView.addSubview(nameLabel)
        
        emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(emailLabel)
        
        Image = UIImageView(frame:.zero)
        Image.translatesAutoresizingMaskIntoConstraints = false
        Image.contentMode = .scaleAspectFit
        contentView.addSubview(Image)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            Image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            Image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            Image.heightAnchor.constraint(equalToConstant: 60),
            Image.widthAnchor.constraint(equalToConstant: 60)
            ])
        
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: Image.trailingAnchor, constant: padding * 1),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding * 2),
            nameLabel.heightAnchor.constraint(equalToConstant: 17)
            ])
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: Image.trailingAnchor, constant: padding ),
            emailLabel.heightAnchor.constraint(equalToConstant: 16),
            emailLabel.widthAnchor.constraint(equalToConstant: 60)
            ])
        
    }
    
    func configure(for person:Person){
        nameLabel.text = person.name
        Image.image = UIImage(named: person.image)
    }
}
