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
    var targetStringDate:NSString = "2016-01-28 05:04"//NOW
    var timeHandlerClosure: ((time:NSString) -> (Void))!
    
    var now:NSDate = NSDate()
    var targetDate:NSDate!
    
    override init(){
        super.init()
        
        targetDate = self.dateFormater().dateFromString(targetStringDate as String)
        
    }
    func start(timeHandler: (time:NSString) -> Void){
        timer = NSTimer.scheduledTimerWithTimeInterval(INCREMENT_TIMER_INTERVAL,
            target:self,
            selector: Selector("timeHandler"),
            userInfo: nil, repeats: true)
        
        self.timeHandlerClosure = timeHandler
    }
    
    func timeHandler(){
        /*NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
        fromDate:startDate
        toDate:endDate
        options:NSCalendarWrapComponents];*/
        
        let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let component:NSDateComponents = (gregorianCalendar?.components(NSCalendarUnit.Day, fromDate: now, toDate: targetDate, options: NSCalendarOptions.WrapComponents))!
        
        let result = "เหลือเวลาอีก : \(component.day) วัน \(component.minute) นาที"
        self.timeHandlerClosure(time: result)
    }
    
    func dateFormater()->NSDateFormatter{
        let format:NSDateFormatter = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm"
        return format;
    }
    
    
}
