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

class NextViewController: UIViewController {

    var reloadData: ReloadProtocol?

    //タスク名のテキストフィールド
    var taskNameString = String()
    @IBOutlet weak var taskNameTextField: UITextField!

    //タスク通知日時のDatePicker
    @IBOutlet weak var taskDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        taskNameTextField.text = taskNameString
    }

    //タスク通知セグメント設定

    @IBAction func taskSegment(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            //タスク通知のdatepickerを無効化する処理
            taskDatePicker.isEnabled = true
            //datepickerの入力値を空にする

            //タスク通知のdatepickerを有効化する処理
        case 1: taskDatePicker.isEnabled = false

        default: //taskDatePicker.isHidden = false
            break
        }
    }

    //戻るボタン
    @IBAction func back(_ sender: Any) {
        reloadData?.reloadSystemData(checkCount: 1)
        dismiss(animated: true, completion: nil)
    }

}
