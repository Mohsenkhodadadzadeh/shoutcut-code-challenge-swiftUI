//
//  shortcut_code_challenge_swiftUIApp.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import SwiftUI
import BackgroundTasks

@main
struct shortcut_code_challenge_swiftUIApp: App {
  
    init() {
        setBackgroundTask()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
    
    
    
    
    private func setBackgroundTask() {
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.mohsen.shortcut-code-challenge-swiftui.fetch", using: nil) { task in
            //Logger.shared.info("[BGTASK] Perform bg fetch bgtask")
            receiveDataBackground()
            task.setTaskCompleted(success: true)
            self.scheduleAppRefresh()
        }
    }
    
    func receiveDataBackground() {
        
        let defaults = UserDefaults.standard
        let lastComicId = defaults.integer(forKey: publicNamesEnum.lastComicId.rawValue)
        
        let receiveLastComic = Task { () -> ComicModel in
            let url = Services.urlGenerator()!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(ComicModel.self, from: data)
        }
        
        Task.init {
            do {
                
                let response = try await receiveLastComic.value
                
                
                if response.num > lastComicId {
                    
                    
                    preparePushNotification()
                    
                }
            } catch {
                print("Invalid data")
            }
        }
    }
    
    func preparePushNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "New Comic".uppercased()
        content.subtitle = "new comic is published for you"
        content.badge = NSNumber(value: 3)
        content.sound = UNNotificationSound.default
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.mohsenkh.shortcut-code-challenge-UIKit.fetch")
        
        request.earliestBeginDate = Date(timeIntervalSinceNow: 5 * 60) // Refresh after 5 minutes.
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh task \(error.localizedDescription)")
        }
    }
}
