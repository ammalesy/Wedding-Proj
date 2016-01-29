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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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

