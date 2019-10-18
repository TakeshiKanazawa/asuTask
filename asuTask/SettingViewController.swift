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

class SettingViewController: UIViewController, MFMailComposeViewControllerDelegate {

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

