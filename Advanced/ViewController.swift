//
//  ViewController.swift
//  Advanced
//
//  Created by  cxy on 16/4/23.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginViewCons: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showLoginView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    @IBAction func loginClick(sender: AnyObject) {
//        let userDic : [String:AnyObject] = ["username" : usernameTF.text ?? "", "password" : passwordTF.text ?? "", "id" : 1]
//        let userAcc = UserAccount(dic: userDic)
//        userAcc.saveAccount()
        view.endEditing(true)
        guard let userAccount = UserAccount.readAccount() else{
            showErrorMessage()
            return
        }
        
        if usernameTF.text == userAccount.username && passwordTF.text == userAccount.password {
            let containerVC = storyboard?.instantiateViewControllerWithIdentifier("container") as! ContainerViewController
            presentViewController(containerVC, animated: true, completion: nil)
            
        }
        else{
            showErrorMessage()
        }
    }
    
    func showErrorMessage(){
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.mode = .Text
        hud.labelText = "用户名或密码错误！"
        hud.hide(true, afterDelay: 2)

    }
    
    func showProcessing(){
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.mode = .DeterminateHorizontalBar
        hud.labelText = "test for MBP"
        hud.hide(true, afterDelay: 5)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func showLoginView(){
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.init(rawValue: 0), animations: {
            self.loginViewCons.constant = 100
            self.view.layoutIfNeeded()
            }, completion: nil)
    }

}

