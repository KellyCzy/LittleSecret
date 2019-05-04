//
//  thirdVC.swift
//  hack
//
//  Created by Chengyin Tan on 4/19/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import UIKit

class thirdVC: UIViewController {

    var nameLabel:UILabel!
    var emailLable:UILabel!
    var imageUpload:UIButton!
    var signOut:UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Information"
        
        signOut = UIBarButtonItem()
        signOut.title = "Sign Out"
        signOut.target = self
        signOut.style = .plain
        signOut.action = #selector(popToRootViewController)
        self.tabBarController?.navigationItem.rightBarButtonItem = signOut
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: true)
        
        imageUpload = UIButton()
        imageUpload.translatesAutoresizingMaskIntoConstraints = false
        imageUpload.setTitle("upload Image", for: .normal)
        imageUpload.backgroundColor = .gray
        imageUpload.addTarget(self, action: #selector(touchesBegan), for: .touchUpInside)
        view.addSubview(imageUpload)
        
        
    }
    
    @objc func popToRootViewController(){
        navigationController?.popToRootViewController(animated: true)
        //view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
