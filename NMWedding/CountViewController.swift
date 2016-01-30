//
//  ViewController.swift
//  NMWedding
//
//  Created by AmmalesPSC91 on 1/28/2559 BE.
//  Copyright © 2559 dev.com. All rights reserved.
//

import UIKit

class CountViewController: UIViewController {
    @IBOutlet weak var countingLb: UILabel!
    @IBOutlet weak var borderImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
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
        imageView.layer.cornerRadius = 200 / 2
        imageView.layer.masksToBounds = true
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.whiteColor().CGColor, UIColor.darkGrayColor().CGColor]

        borderImageView.layer.insertSublayer(gradient, atIndex: 0)
        borderImageView.layer.cornerRadius = 230 / 2
        borderImageView.layer.masksToBounds = true
    }
    func startCoutDown(){
        let counterObj:CounterUtil =  CounterUtil.sharedInstance;
        counterObj.targetStringDate = "2017-01-29 17:30:00"
        counterObj.start({ (component:NSDateComponents) -> Void in
            
            let display:String = "\(component.day) Days \(component.hour) Hours \(component.minute) Mins (\(component.second))"
            self.displayClock(display)
            
            }) { () -> Void in
                
                self.displayClock("แต่งแล้ว")
        }
    }
    func displayClock(time:String){
        self.countingLb.text = time;
        self.countingLb.setNeedsDisplay()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

