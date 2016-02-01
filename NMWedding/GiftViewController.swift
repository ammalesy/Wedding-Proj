//
//  GiftViewController.swift
//  NMWedding
//
//  Created by Apple on 1/31/16.
//  Copyright © 2016 dev.com. All rights reserved.
//

import UIKit


class GiftViewController: UIViewController,UIAlertViewDelegate {

    let MyKeychainWrapper = KeychainWrapper()
    let userDefault = NSUserDefaults.standardUserDefaults()
    var gift_box_clicked:Bool = false
    var pathImage:String = ""
    var blocking:Bool = false
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var subTitleLb: UILabel!
    @IBOutlet weak var button: UIButton!
    var viewOverlay:UIView!
    
    
    let animationImages = [UIImage(named: "gift_promo")!,UIImage(named: "gift_promo_left")!,UIImage(named: "gift_promo")!,UIImage(named: "gift_promo_right")!]
    
    @IBAction func clickGiftBoxAction(sender: AnyObject) {
        

        if(self.gift_box_clicked == false)
        {
            self.animatingGiftBox()
            self.titleLb.text = "Please wait.."
            self.subTitleLb.text = "Good luck!"
            
            if(self.blocking == false){
                
                self.blocking = true
                
                let url : String = String(format: "http://www.reallifefootball.com/wedding_api/")
                let url1: NSURL = NSURL(string: url)!
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithURL(url1, completionHandler: {
                    (data, response, error) -> Void in
                    do {
                        if data == nil {
                            let alert:UIAlertView = UIAlertView(title: "Technical error", message: "please touch giftbox again.", delegate: nil, cancelButtonTitle: "OK")
                            alert.show()
                        }
                        else
                        {
                            
                            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.imageView.stopAnimating()
                                self.imageView.image = UIImage(named: "gift_promo_loading")!
                            })
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.userDefault.setObject(jsonData["titleLb"], forKey: "titleLB")
                                self.userDefault.setObject(jsonData["subTitleLb"], forKey: "subTitleLb")
                                self.userDefault.setObject(jsonData["pathImage"], forKey: "pathImage")
                                self.userDefault.synchronize()
                                
                                self.titleLb.text = jsonData["titleLb"] as? String
                                self.subTitleLb.text = jsonData["subTitleLb"] as? String
                                self.pathImage = jsonData["pathImage"] as! String
                                
                                
                                self.MyKeychainWrapper.mySetObject(jsonData["id"], forKey:kSecValueData)
                                self.MyKeychainWrapper.writeToKeychain()
                                self.gift_box_clicked = true
                                self.blocking = false
                                
                                self.setGiftImageToViewIfHasIt()
                            })
                            
                            
                        }
                        
                    } catch {
                        
                    }
                    
                })
                
                task.resume()
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let val = MyKeychainWrapper.myObjectForKey(kSecValueData)
        if(String(val) == "password")
        {
            self.button.enabled = true
            self.gift_box_clicked = false
        }
        else
        {
            self.button.enabled = false
            self.gift_box_clicked = true
            self.syncData({ () -> Void in
                
                self.titleLb.text = self.userDefault.objectForKey("titleLB") as? String
                self.subTitleLb.text = self.userDefault.objectForKey("subTitleLb") as? String
                self.pathImage = (self.userDefault.objectForKey("pathImage") as? String)!
                self.setGiftImageToViewIfHasIt()
                
            }, fail: {() -> Void in
            
            })
        }
    }
    @IBAction func resetAction(sender: AnyObject) {
        
        let alert:UIAlertView = UIAlertView(title: "Validate permission", message: "message: Enter secure code", delegate: self, cancelButtonTitle: "OK")
        alert.alertViewStyle = UIAlertViewStyle.SecureTextInput
        alert.show()
        
        
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        let password:UITextField = alertView.textFieldAtIndex(0)!
        if(password.text == "WEDDINGEVENT")
        {
            let alert:UIAlertView = UIAlertView(title: "Reset success", message: "Please kill application and open again.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            self.resetGiftBox()
        }
        else
        {
            let alert:UIAlertView = UIAlertView(title: "Reset fail", message: "Invalid password", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    func resetGiftBox(){
        let val = MyKeychainWrapper.myObjectForKey(kSecValueData)
        if(String(val) != "password")
        {
            MyKeychainWrapper.resetKeychainItem()
        }
    }
    func animatingGiftBox(){
        self.imageView.animationImages = animationImages
        self.imageView.animationDuration = 1
        self.imageView.animationRepeatCount = 0
        self.imageView.startAnimating()
    }
    func setGiftImageToViewIfHasIt(){
        if(self.pathImage != ""){
            let url:NSURL = NSURL(string: self.pathImage)!
            self.imageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "gift_promo_loading")!, options: SDWebImageOptions.RefreshCached)
        }
        self.imageView.stopAnimating()
    }
    func syncData(completed:()->Void, fail:()->Void){
        if(self.blocking == false){
            
            let validate = userDefault.objectForKey("titleLB") as? String
            if(validate == nil){
                self.blocking = true
                let val = MyKeychainWrapper.myObjectForKey(kSecValueData)
                let url : String = String(format: "http://www.reallifefootball.com/wedding_api/sync.php?id=\(val)")
                let url1: NSURL = NSURL(string: url)!
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithURL(url1, completionHandler: {
                    (data, response, error) -> Void in
                    do {
                        if data == nil {
                            let alert:UIAlertView = UIAlertView(title: "Technical error", message: "Please kill application and open again.", delegate: nil, cancelButtonTitle: "OK")
                            alert.show()
                            fail()
                            self.removeOverlayView()
                        }
                        else
                        {
                            
                            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                            
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.userDefault.setObject(jsonData["titleLb"], forKey: "titleLB")
                                self.userDefault.setObject(jsonData["subTitleLb"], forKey: "subTitleLb")
                                self.userDefault.setObject(jsonData["pathImage"], forKey: "pathImage")
                                self.userDefault.synchronize()
              
                                self.blocking = false
                                completed()
                                self.removeOverlayView()
                          
                            })
                            
                            
                        }
                        
                    } catch {
                        fail()
                        self.removeOverlayView()
                    }
                    
                })
                
                task.resume()
                self.showOverlayView()
            }else{
                completed()
                self.blocking = false
            }
            
        }
    }
    func showOverlayView(){
        
        
        viewOverlay = UIView(frame: CGRectMake(0, 0, (self.tabBarController!.view.frame.width), (self.tabBarController!.view.frame.height)))
        viewOverlay.backgroundColor = UIColor.blackColor()
        viewOverlay.alpha = 0.6
        
        let loading:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        loading.frame = CGRectMake((viewOverlay.frame.size.width / 2) - (40.0 / 2.0), (viewOverlay.frame.size.height / 2)-(40.0 / 2.0), 40, 40)
        loading.hidesWhenStopped = true
        loading.startAnimating()
        
        viewOverlay.addSubview(loading)
        
        viewOverlay.setNeedsDisplay()
        loading.setNeedsDisplay()
        
        viewOverlay.userInteractionEnabled = false
        
        self.tabBarController?.view.addSubview(viewOverlay)
        
        
    }
    func removeOverlayView(){
        viewOverlay.removeFromSuperview()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
