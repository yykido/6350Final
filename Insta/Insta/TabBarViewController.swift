//
//  TabBarViewController.swift
//  Insta
//
//  Created by yy on 2023/4/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeViewController = viewControllers?[0] as! HomeViewController
        let uploadPicVC = viewControllers?[1] as! UploadImageViewController
        uploadPicVC.uploadProtocol = homeViewController.self
    }
    

}
