//
//  WelcomeViewController.swift
//  NMWedding
//
//  Created by AmmalesPSC91 on 1/29/2559 BE.
//  Copyright © 2559 dev.com. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var goCountView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goCountView.layer.cornerRadius = 10
        goCountView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    @IBAction func goCountViewAction(sender: AnyObject) {
        
        let countCtrl:UITabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("tabbarMenu") as! UITabBarController
        countCtrl.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        countCtrl.selectedIndex = 1
        
        let caTransition:CATransition = CATransition()
        caTransition.duration = 0.7
        self.view.window?.layer.addAnimation(caTransition, forKey: kCATransition)
        self.presentViewController(countCtrl, animated: true) { () -> Void in
            
        }
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
