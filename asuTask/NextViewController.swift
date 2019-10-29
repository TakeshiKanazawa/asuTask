//
//  NextViewController.swift
//  asuTask
//
//  Created by 金澤武士 on 2019/09/28.
//  Copyright © 2019 tk. All rights reserved.


import UIKit

protocol ReloadProtocol {
    //規則をきめる
    func reloadSystemData(checkCount: Int)
}

protocol DateProtocol {
    //規則を決める
    func setDateSystem(date: Date)
}

class NextViewController: UIViewController {

    var reloadData: ReloadProtocol?
    var dateProtol: DateProtocol?

    //タスク名のテキストフィールド
    var taskNameString = String()
    @IBOutlet weak var taskNameTextField: UITextField!

    //タスク通知日時のDatePicker


    @IBOutlet weak var taskDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        taskNameTextField.text = taskNameString
        //Datepicker無効果
        taskDatePicker.isEnabled = false

        //デートピッカーの値を取得
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "HH:mm"
        //動作確認用コード
        print("\(formatter.string(from: taskDatePicker.date))")
    }


    //タスク通知セグメント設定
    @IBAction func taskSegment(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            //タスク通知のdatepickerを無効化する処理
            taskDatePicker.isEnabled = false
            //datepickerの入力値を空にする


            //タスク通知のdatepickerを有効化する処理
        case 1: taskDatePicker.isEnabled = true

        default:
            taskDatePicker.isEnabled = false
            break
        }
    }

    //戻るボタン
    @IBAction func back(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }

    //完了ボタン
    @IBAction func done(_ sender: Any) {
        dateProtol!.setDateSystem(date: taskDatePicker!.date)

        reloadData?.reloadSystemData(checkCount: 1)
        dismiss(animated: true, completion: nil)
    }
    
    }





