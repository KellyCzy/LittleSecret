//
//  TabBarViewController.swift
//  hack
//
//  Created by Chengyin Tan on 4/19/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import UIKit
import Foundation

class TabBarViewController: UITabBarController {
    
    var firstImage: UIImage!
    var secondImage: UIImage!
    var thirdImage: UIImage!
    var email: String?
    var idNumber: String?
    var password: String?
    var iconSize: CGSize = CGSize(width: 32, height: 32)
    
    var firstViewController: firstVC!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        firstViewController = firstVC()
        firstImage = UIImage(named: "first")
        firstImage = self.firstImage.resize(image: firstImage, targetSize: iconSize)
        
        
        firstViewController.tabBarItem = UITabBarItem(title: "Contacts", image: firstImage, selectedImage: firstImage)
        let firstNavVC = UINavigationController(rootViewController: firstViewController)
        
        let secondViewController = secondVC()
        secondImage = UIImage(named: "second")
        secondImage = self.secondImage.resize(image: secondImage, targetSize: iconSize)
        
        secondViewController.tabBarItem = UITabBarItem(title: "Secrets", image: secondImage, selectedImage: secondImage)
        let secondNavVC = UINavigationController(rootViewController: secondViewController)
        
        let thirdViewController = thirdVC()
        thirdImage = UIImage(named: "third")
        thirdImage = self.thirdImage.resize(image: thirdImage, targetSize: iconSize)
        
        thirdViewController.tabBarItem = UITabBarItem(title: "Personal", image: thirdImage, selectedImage: thirdImage)
        let thirdNavVC = UINavigationController(rootViewController: thirdViewController)
        
        let tabBarList = [firstNavVC, secondNavVC, thirdNavVC]
        
        viewControllers = tabBarList
        
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

extension UIImage {
    public func resize(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
