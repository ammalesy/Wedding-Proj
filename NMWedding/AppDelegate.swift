//
//  AppDelegate.swift
//  NMWedding
//
//  Created by AmmalesPSC91 on 1/28/2559 BE.
//  Copyright © 2559 dev.com. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let calendar:NSCalendar = NSCalendar.autoupdatingCurrentCalendar()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        let types:UIUserNotificationType = [UIUserNotificationType.Badge,UIUserNotificationType.Sound,UIUserNotificationType.Alert]
        let settings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
        let notis = NSUserDefaults.standardUserDefaults().objectForKey("noti")
        
        if((notis) == nil){
            
            self.localnotification(2, detail: "Nut&Mam wedding remain 2 day")
            self.localnotification(1, detail: "Nut&Mam wedding remain 1 day")
            self.localnotification(0, detail: "Nut&Mam Wedding time!")
            
            NSUserDefaults.standardUserDefaults().setObject("REGISTED", forKey: "noti")
            NSUserDefaults.standardUserDefaults().synchronize()
        }

        let img = UIImage()
        
        UITabBar.appearance().shadowImage = img

        return true
    }
    func localnotification(beforeDay:Int, detail:String){

        let dateComp:NSDateComponents = NSDateComponents()
        dateComp.day = 21 - beforeDay
        dateComp.month = 2
        if(self.calendar.calendarIdentifier == "buddhist"){
            dateComp.year = 2559
        }else{
            dateComp.year = 2016
        }
        dateComp.hour = 8
        dateComp.minute = 0
        let itemDate = calendar.dateFromComponents(dateComp)
        let localNotif:UILocalNotification = UILocalNotification()
        localNotif.fireDate = itemDate
        localNotif.timeZone = NSTimeZone.defaultTimeZone();
        localNotif.alertAction = "Action"
        if #available(iOS 8.2, *) {
            localNotif.alertTitle = "Detail"
        } else {
            // Fallback on earlier versions
        }
        localNotif.alertBody = detail
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        localNotif.applicationIconBadgeNumber = localNotif.applicationIconBadgeNumber + 1;
        
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotif)
    }
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.dev.NMWedding" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("NMWedding", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}



