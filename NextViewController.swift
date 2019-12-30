//
//  NextViewController.swift
//  asuTask
//
//  Created by 金澤武士 on 2019/09/28.
//  Copyright © 2019 tk. All rights reserved.


import UIKit

protocol ReloadProtocol {
    func reloadSystemData(checkCount: Int)
}

protocol setidProtocol {
    func setId(id:String)
}

protocol DateProtocol {
    func setDateSystem(date: Date)
}

protocol setTimeProtocol {
    func setTaskTime(time: String)
}

protocol setPriorityProtocol {
    func setTaskPriority(priority: String)
}

class NextViewController: UIViewController {
    

    var reloadData: ReloadProtocol?
    var dateProtol: DateProtocol?
    var setId:setidProtocol?
    var setTime:setTimeProtocol?
    var setPriority:setPriorityProtocol?
    
    //タスク通知フラグ
    var taskNotification = false
    //アラートコントローラー
    var alertController: UIAlertController!
    //タスク優先度
    var taskPriority = "設定なし"
    //タスク名のテキストフィールド
    var taskNameString = String()
    @IBOutlet weak var taskNameTextField: UITextField!

    //タスク通知日時のDatePicker
    
    @IBOutlet weak var taskDatePicker: UIDatePicker!


    override func viewDidLoad() {
        super.viewDidLoad()
        taskNotification = false

        taskNameTextField.text = taskNameString
        //Datepicker無効化
        taskDatePicker.isEnabled = false
        //最小日時を現在時刻に設定
        taskDatePicker.minimumDate = NSDate() as Date

    }


    //タスク通知セグメント設定
    @IBAction func taskSegment(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            //タスク通知のdatepickerを無効化する処理(タスク通知しない)
            taskDatePicker.isEnabled = false
            taskNotification = false

            //タスク通知のdatepickerを有効化する処理(タスク通知する)
        case 1: taskDatePicker.isEnabled = true
            taskNotification = true

        default:
            taskDatePicker.isEnabled = false
            break
        }
    }

    //キャンセルボタン
    @IBAction func back(_ sender: Any) {

        dismiss(animated: true, completion: nil)
        
    }
    //タスク優先度ボタン
    
    @IBAction func taskPriority(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
            //タスク優先度設定：無し
        case 0:
            taskPriority = "設定なし"
            print(taskPriority)
           //タスク優先度設定：できたらやる
        case 1:
            taskPriority = "できたらやる"
             print(taskPriority)
        //タスク優先度設定：絶対やる
        case 2:
            taskPriority = "絶対やる"
             print(taskPriority)
        default:
            taskPriority = "設定なし"
             print(taskPriority)
            break
        
        }
    }
    //タスクスヌーズボタン
    @IBAction func taskSnooze(_ sender: Any) {
    }
    //完了ボタン
    @IBAction func done(_ sender: Any) {
        //タスク通知する場合⇨登録時刻が未来の日付なら処理を継続
        if taskNotification == true && checkTime() {
        dateProtol!.setDateSystem(date: taskDatePicker!.date)
            reloadData?.reloadSystemData(checkCount: 1)
        //変数taskTimeにDatePickerの時刻を代入
            let taskTime = format(date: taskDatePicker!.date)
            print(taskTime)
            setTime?.setTaskTime(time: taskTime)
            setPriority?.setTaskPriority(priority: taskPriority)
            dismiss(animated: true, completion: nil)
            //もしタスク通知がfalseなら。Viewコントローラーのtextarrayに仮値をappend
        }else if taskNotification == false {
            setId?.setId(id: "no ID")
             let taskTime = "設定なし"
            setTime?.setTaskTime(time: taskTime)
            setPriority?.setTaskPriority(priority: taskPriority)
            reloadData?.reloadSystemData(checkCount: 1)
             dismiss(animated: true, completion: nil)
        
        }
     
        }
        

    //時刻チェックを行うメソッド
    func checkTime() -> Bool {
        let currentDate = NSDate() as Date
                //過去の日付じゃなければ処理を継続
        let taskDatePickerSettedDate = taskDatePicker.date
            //時刻を比較。過去の日付なら処理を終了
        if currentDate >= taskDatePickerSettedDate {
                alert(title: "登録できません",
                      message: "未来の日付を指定してください。")
            print("登録日時エラーの為処理終了")
                  return false
        } else {
            print("日時チェックOK.処理継続")
              return true
        }
      
    }
    
    //アラート表示用メソッド
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "了解！",
                                       style: .default,
                                       handler: nil))
        present(alertController, animated: true)
    }
    
    //文字列時刻取得用メソッド
    func format(date:Date)->String{
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy年MM月dd日HH時mm分"
        let strDate = dateformatter.string(from: date)
        
        return strDate
        
    }
    
    }





