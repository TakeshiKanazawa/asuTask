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

class SettingViewController: UIViewController {

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
            //タスク通知のdatepickerを無効化
            dailyTaskNotificationDatePicker.isEnabled = false
            //datepickerの入力値を空にする

            //タスク通知のdatepickerを有効化
        case 1: dailyTaskNotificationDatePicker.isEnabled = true

        default:
            dailyTaskNotificationDatePicker.isEnabled = false
            break
        }
    }

    //セッティング画面終了ボタン
    @IBAction func doneSetting(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


    //お問い合わせメーラー起動ボタン
    @IBAction func contact(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
            mail.setToRecipients(["oseans@hotmail.co.jp"]) //宛先アドレス
            mail.setSubject("お問い合わせ") //件名
            mail.setMessageBody("ここに本文が入ります。", isHTML: false) //本文
            present(mail,animated: true, completion: nil)
        }else {
            print("送信できません")
        }
    }
    
    // アプリのレビュー画面へ遷移ボタン
    @IBAction func review(_ sender: Any) {
        //レビューページへ遷移
        if #available(iOS 10.3, *) { SKStoreReviewController.requestReview()
        }
            // ios 10.3未満の処理
        else {
            if let url = URL (string: "itms-apps:itunes.apple.com/app/id1274048262?action=write-review") {
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:])
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
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

