//
//  SettingViewController.swift
//  asuTask
//
//  Created by 金澤武士 on 2019/10/11.
//  Copyright © 2019 tk. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI
import UserNotifications

class SettingViewController: UIViewController, MFMailComposeViewControllerDelegate, UNUserNotificationCenterDelegate {
    
    //タスク通知フラグ
    var notificationFlg = false
    var notificationGranted = true

    //datepicker
    @IBOutlet weak var dailyTaskNotificationDatePicker: UIDatePicker!

    override func viewDidLoad() {
        //dailyTaskNotificationDatePicker無効化
        dailyTaskNotificationDatePicker.isEnabled = false
        super.viewDidLoad()

    }
    
    //タスク作成お忘れ防止通知セグメント
    @IBAction func dailyTaskNotificationSegment(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            notificationFlg = false
            //タスク通知のdatepickerを無効化
            dailyTaskNotificationDatePicker.isEnabled = false

            //タスク通知のdatepickerを有効化
        case 1:
            notificationFlg = true

            dailyTaskNotificationDatePicker.isEnabled = true
        default:
            dailyTaskNotificationDatePicker.isEnabled = false
            break
        }
    }

    //セッティング画面終了ボタン
    @IBAction func doneSetting(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        //通知セグメントが「通知する」の場合(notificationFlgがtrueの場合)
        if notificationFlg == true {
            //通知表示の許諾〜トリガー設定〜通知の表示内容の設定〜登録を行うメソッドを呼び出す
            setDairyTaskNotification()
        }

        else
        //通知セグメントが「通知しない」の場合
        {
            //タスクお知らせ通知が登録されていれば削除する
        }


    }


    //お問い合わせメーラー起動ボタン
    @IBAction func contact(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["oseans@hotmail.co.jp"]) //宛先アドレス
            mail.setSubject("アプリに関するお問い合わせ") //件名
            mail.setMessageBody("お問い合わせ内容の入力をお願いします。", isHTML: false) //本文
            present(mail, animated: true, completion: nil)
        } else {
            print("送信できません")
        }
    }

    // アプリのレビュー画面へ遷移ボタン
    @IBAction func review(_ sender: Any) {

        // TODO: app idが現在未登録のため仮番号。発行次第正しいものへ変更
        let MY_APP_ID = "1274048262"
        //レビュータブを開くためのURLを指定する
        // TODO: app idが現在未登録のため仮番号。発行次第正しいものへ変更
        let urlString =
            "itms-apps://itunes.apple.com/jp/app/id\(1274048262)?mt=8&action=write-review"
        if let url = URL(string: urlString) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    //通知表示の許諾〜トリガー設定〜通知の表示内容の設定〜登録を行うメソッド

    func setDairyTaskNotification() {
        
        //プッシュ通知認証許可フラグ
        var isFirst = true
        //デリゲートメソッドを設定
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            self.notificationGranted = granted

            if let error = error {
                print("エラーです")
            }
        }
        isFirst = false

        //通知日時の設定
        var trigger: UNNotificationTrigger
        //noticficationtimeにdatepickerで取得した値をset
        var forSetnotificationTime = DateComponents()
        
        let notificationTime = Calendar.current.dateComponents(in: TimeZone.current, from: dailyTaskNotificationDatePicker.date)
        
        var intNotificationHour : Int!
        var intNotificationMinute : Int!
        
        intNotificationHour = notificationTime.hour
        intNotificationMinute = notificationTime.minute

        forSetnotificationTime.hour = intNotificationHour
        forSetnotificationTime.minute = intNotificationMinute

        //triggerに現在時刻から〇〇秒後のタスク実行時間をset
        trigger = UNCalendarNotificationTrigger(dateMatching: forSetnotificationTime, repeats: false)
        //タスク通知内容の設定
        let content = UNMutableNotificationContent()
        content.title = "明日のタスクを確認しましょう"
        content.body = "明日やることはありませんか？"
        content.sound = .default
        print(notificationTime)
        //通知スタイルを指定
        let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
        //通知をセット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("キャンセル")
        case .saved:
            print("下書き保存")
        case .sent:
            print("送信成功")
        default:
            print("送信失敗")
        }
        dismiss(animated: true, completion: nil)
    }
}

