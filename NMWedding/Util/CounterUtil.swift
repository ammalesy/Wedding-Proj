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
    var calendar:NSCalendar!
    let dateFormater:NSDateFormatter = NSDateFormatter()
    
    var timer:NSTimer!
    var targetStringDate:String!
    var timeHandlerClosure: ((remainTimeComponent:NSDateComponents) -> (Void))!
    var completedClosure: (() -> (Void))!
    
    var now:NSDate = NSDate()
    var targetDate:NSDate!
    
    override init(){
        super.init()
        self.calendar = NSLocale.currentLocale().objectForKey(NSLocaleCalendar) as! NSCalendar
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormater.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        //dateFormater.calendar = calendar
    }
    func start(timeHandler: (remainTimeComponent:NSDateComponents) -> Void, completed:()->Void){
        targetDate = self.dateFormater.dateFromString(targetStringDate)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(INCREMENT_TIMER_INTERVAL,
            target:self,
            selector: Selector("timeHandler"),
            userInfo: nil, repeats: true)
        
        self.timeHandlerClosure = timeHandler
        self.completedClosure = completed
    }
    
    func timeHandler(){
        let nowStr = self.dateFormater.stringFromDate(NSDate())
        now = self.dateFormater.dateFromString(nowStr)!
        
//        print(nowStr)
//        print(targetStringDate)
//        
//        print(now)
//        
//        print(targetDate)

        
        let componentDate:NSDateComponents = calendar.components([.Year, .Month, .Day , .Hour, .Minute, .Second], fromDate: now, toDate: targetDate, options: NSCalendarOptions.WrapComponents)
        
        //print(componentDate)
        //if(  ) {
        let result:NSComparisonResult = now.compare(targetDate)
  
        
        if(result == NSComparisonResult.OrderedDescending)
        {
            self.completedClosure()
            self.timer.invalidate()
        }else{
            self.timeHandlerClosure(remainTimeComponent: componentDate)
        }
    }
}
