//
//  HomeViewController.swift
//  Advanced
//
//  Created by  cxy on 16/4/25.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userIsOn: UIImageView!
    @IBOutlet weak var machineIsOn: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        idLabel.text = String(UserAccount.readAccount()!.id)
        usernameLabel.text = UserAccount.readAccount()!.username
        userIsOn.image = UIImage(named: "sign-error-icon")
        machineIsOn.image = UIImage(named: "sign-check-icon")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        title = "主页"
    }
        
    lazy var menuButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "MainTagSubIcon"), forState: UIControlState.Normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(showMenu), forControlEvents: .TouchUpInside)
        return btn
    }()
    
    
    func showMenu(){
        slideMenuController()?.openLeft()
    }

}
