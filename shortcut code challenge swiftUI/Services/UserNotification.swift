//
//  UserNotification.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import UserNotifications

public final class UserNotification {
    
    public static var shared: UserNotification = UserNotification()
    
    private init() { }
    
    func askForPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { sucess, error in
            if sucess {
                print("configuraions set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }//: UNUserNotificationCenter
    }
}
