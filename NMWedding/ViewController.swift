//
//  ViewController.swift
//  NMWedding
//
//  Created by AmmalesPSC91 on 1/28/2559 BE.
//  Copyright © 2559 dev.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var countingLb: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let counterObj:CounterUtil =  CounterUtil.sharedInstance;
        counterObj.start { (time) -> Void in
            //print(time)
            self.countingLb.text = time as String;
            self.countingLb.setNeedsDisplay()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

