//
//  CounterUtil.swift
//  NMWedding
//
//  Created by AmmalesPSC91 on 1/28/2559 BE.
//  Copyright © 2559 dev.com. All rights reserved.
//

import UIKit

class CounterUtil: NSObject {
    
    static let sharedInstance = CounterUtil()
    
    let INCREMENT_TIMER_INTERVAL:NSTimeInterval = 1
    var timer:NSTimer!
    var targetStringDate:NSString = "2017-01-29 16:17:00"
    var timeHandlerClosure: ((remainTimeComponent:NSDateComponents) -> (Void))!
    var completedClosure: (() -> (Void))!
    
    var now:NSDate = NSDate()
    var targetDate:NSDate!
    
    override init(){
        super.init()
    }
    func start(timeHandler: (remainTimeComponent:NSDateComponents) -> Void, completed:()->Void){
        targetDate = self.dateFormater().dateFromString(targetStringDate as String)
        timer = NSTimer.scheduledTimerWithTimeInterval(INCREMENT_TIMER_INTERVAL,
            target:self,
            selector: Selector("timeHandler"),
            userInfo: nil, repeats: true)
        
        self.timeHandlerClosure = timeHandler
        self.completedClosure = completed
    }
    
    func timeHandler(){
        now = NSDate()
        print(now)

        let calendar = NSCalendar.currentCalendar()
        let componentDate:NSDateComponents = calendar.components([.Year, .Month, .Day , .Hour, .Minute, .Second], fromDate: now, toDate: targetDate, options: NSCalendarOptions.WrapComponents)
        
        if(componentDate.month  <= 0 &&
            componentDate.day  <= 0 &&
            componentDate.hour  <= 0 &&
            componentDate.minute  <= 0 &&
            componentDate.second  <= 0)
        {
            self.completedClosure()
            self.timer.invalidate()
        }else{
            self.timeHandlerClosure(remainTimeComponent: componentDate)
        }
    }
    func dateFormater()->NSDateFormatter{
        let format:NSDateFormatter = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return format;
    }
    
    
}
