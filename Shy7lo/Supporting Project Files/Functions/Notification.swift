//
//  Notification.swift
//  idol
//
//  Created by Sajjad Yousaf on 6/7/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationClass: NSObject {
    
    
    class func timedNotifications(forDate: DateComponents, photoid : String , completion: @escaping (_ Success: Bool) -> ()) {
        
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: forDate, repeats: false)
        
        //UNTimeIntervalNotificationTrigger(timeInterval: (30*60), repeats: false)
        
        print(forDate)
        
        //  let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let content = UNMutableNotificationContent()
        
        
        content.title = "Idillionaire"
        content.subtitle = "Schedule Notification"
       // content.body = "Schedule Notification"
        
        let request = UNNotificationRequest(identifier: photoid , content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                completion(false)
            }else {
                completion(true)
            }
        }
    }
    
    
    
    class func removeNotification(identifier : String)  {
        
        
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
            var identifiers: [String] = []
            
            for notification:UNNotificationRequest in notificationRequests {
                if notification.identifier == identifier {
                    identifiers.append(notification.identifier)
                }
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }

    

}
