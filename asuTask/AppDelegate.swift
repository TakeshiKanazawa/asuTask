//
//  AppDelegate.swift
//  asuTask
//
//  Created by 金澤武士 on 2019/09/28.
//  Copyright © 2019 tk. All rights reserved.
//

import UIKit
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let hours = 19
    let minute = 00

    //プッシュ通知の許可()
    var notificationGranted = true

    var isFirst = true


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //通知許可を促すアラート
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in

            self.notificationGranted = granted

            if let error = error {
                print("エラーです")
            }
        }

        isFirst = false

        setNotification()

        return true
    }

    func setNotification() {

        var notificationTime = DateComponents()
        var trigger: UNNotificationTrigger

        notificationTime.hour = hours
        notificationTime.minute = minute
        trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)
        let content = UNMutableNotificationContent()
        content.title = "タスク実行時間です"
        content.body = "タスク「」を実行してください"
        content.sound = .default

        //通知スタイル
        let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)

        //通知をセット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        setNotification()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }


    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

