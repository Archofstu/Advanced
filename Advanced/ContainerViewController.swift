//
//  ContainerViewController.swift
//  Advanced
//
//  Created by  cxy on 16/4/25.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ContainerViewController: SlideMenuController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SlideMenuOptions.leftViewWidth = 180
        SlideMenuOptions.contentViewScale = 0.5
        SlideMenuOptions.hideStatusBar = false
    }
    
    override func awakeFromNib() {
        let menuVC = storyboard?.instantiateViewControllerWithIdentifier("menu") as! MenuViewController
        leftViewController = menuVC
        
        let homeVC = storyboard?.instantiateViewControllerWithIdentifier("home") as! HomeViewController
        let naviVC = UINavigationController(rootViewController: homeVC)
        mainViewController = naviVC
        naviVC.navigationBar.subviews.first?.alpha = 0.75
        super.awakeFromNib()
    }

}
