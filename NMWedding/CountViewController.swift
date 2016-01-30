//
//  ViewController.swift
//  NMWedding
//
//  Created by AmmalesPSC91 on 1/28/2559 BE.
//  Copyright © 2559 dev.com. All rights reserved.
//

import UIKit

class CountViewController: UIViewController {
    
    private let photos = PhotosProvider().photos

    @IBOutlet weak var secLb: UILabel!
    @IBOutlet weak var minuteLb: UILabel!
    @IBOutlet weak var dayLb: UILabel!
    @IBOutlet weak var hourLb: UILabel!
    @IBOutlet weak var borderImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dayCaptionLb: UILabel!
    @IBOutlet weak var hourCaptionLb: UILabel!
    @IBOutlet weak var minCaptionLb: UILabel!
    
    @IBOutlet weak var width_hourLb_const: NSLayoutConstraint!
    var count:Int = 0
    var countCover:Int = 0
    let animationImages = [UIImage(named: "1")!,UIImage(named: "5")!,UIImage(named: "7")!,UIImage(named: "3")!]
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setImageViewStyle()
        self.startCoutDown()
        self.animateImages()
        self.animateCoverImages()


    }
    @IBAction func openFullScreenImage(sender: AnyObject) {
        
        self.openFullImages()
    }
    func openFullImages(){
        let photosViewController = NYTPhotosViewController(photos: self.photos)
        presentViewController(photosViewController, animated: true, completion: nil)
    }
    func animateCoverImages(){
        
        
        let image:UIImage = animationImages[(countCover % animationImages.count)]
        
        UIView.transitionWithView(self.coverImageView, duration: 4.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            
            self.coverImageView.image = image
            
            }) { (flag) -> Void in
                
                self.animateCoverImages()
                self.countCover++;
                
        }
        
    }
    func animateImages(){
    
        let image:UIImage = animationImages[(count % animationImages.count)]
        
        UIView.transitionWithView(self.imageView, duration: 4.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            
            self.imageView.image = image
            
            }) { (flag) -> Void in
                
                self.animateImages()
                self.count++;
                
        }
        
    }
    func setImageViewStyle(){
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.masksToBounds = true
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.whiteColor().CGColor, UIColor.darkGrayColor().CGColor]

        borderImageView.layer.insertSublayer(gradient, atIndex: 0)
        borderImageView.layer.cornerRadius = borderImageView.frame.size.width / 2
        borderImageView.layer.masksToBounds = true
    }
    func startCoutDown(){
        let counterObj:CounterUtil =  CounterUtil.sharedInstance;
        counterObj.targetStringDate = "2016-02-21 8:00:00"
        counterObj.start({ (component:NSDateComponents) -> Void in
            
            self.displayClock(component.day, hour: component.hour, minute: component.minute, sec: component.second)
            
            }) { () -> Void in
                
                self.dayLb.hidden = true
                self.minuteLb.hidden = true
                self.secLb.hidden = true
                self.dayCaptionLb.hidden = true
                self.hourCaptionLb.hidden = true
                self.minCaptionLb.hidden = true
                
                self.width_hourLb_const.constant = 200

                self.hourLb.textColor = self.navigationController?.navigationBar.barTintColor
                self.hourLb.text = "Wedding time!"
                self.hourLb.alpha = 0.7
                self.hourLb.setNeedsDisplay()
        }
    }
    func displayClock(day:Int, hour:Int, minute:Int, sec:Int){
        self.dayLb.text = String(day);
        self.hourLb.text = String(hour);
        self.minuteLb.text = String(minute);
        self.secLb.text = String("\(sec)s");
        self.dayLb.setNeedsDisplay()
        self.hourLb.setNeedsDisplay()
        self.minuteLb.setNeedsDisplay()
        self.secLb.setNeedsDisplay()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

