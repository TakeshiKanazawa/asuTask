//
//  ViewController.swift
//  asuTask
//
//  Created by 金澤武士 on 2019/09/28.
//  Copyright © 2019 tk. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ReloadProtocol, DateProtocol {

    var notificationGranted = true

    //タスク入力用テキストフィールド
    @IBOutlet weak var textField: UITextField!
    //テーブルビュー
    @IBOutlet weak var tableView: UITableView!
    //タスク件数表示用レベル
    @IBOutlet weak var todaysTaskMessageLabel: UILabel!

    var indexNumber = Int()


    //リターンキーが押されたかどうかを判定する
    var textFieldTouchReturnKey = false

    var textArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self

    }

    //viewが表示される直前の処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        todaysTaskMessageLabelChange()
        textField.text = ""

    }
    //本日のタスクの文言表示処理メソッド
    func todaysTaskMessageLabelChange() {
        //本日のタスクが１件以上なら「本日のタスクは〇〇件です」と表示
        if textArray.count >= 1 {
            todaysTaskMessageLabel.text = "本日のタスクは\(textArray.count)件です"
            //それ以外は本日のタスクはありません」と表示
        } else {
            todaysTaskMessageLabel.text = "本日のタスクはありません"
        }
    }

    func reloadSystemData(checkCount: Int) {
        if checkCount == 1 {
            tableView.reloadData()
        }
    }

    func setDate(date: Date) {

        //プッシュ通知認証許可フラグ
        var isFirst = true

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

            //通知許可を促すアラートを出す
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

            //通知日時の設定
            var notificationTime = DateComponents()
            var trigger: UNNotificationTrigger

            //ここにdatepickerで取得した値をset
            notificationTime = Calendar.current.dateComponents(in: TimeZone.current, from: date)

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
        //アプリがバックグラウンドの時の通知設定(アプリがBgになる直前に呼ばれる)
        func applicationDidEnterBackground(_ application: UIApplication) {
            setNotification()
        }
    }

    //セクションのセルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1

    }
    //セルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = textArray[indexPath.row]
//        cell.imageView?.image = UIImage(named:)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        textFieldTouchReturnKey = false
        indexNumber = indexPath.row


    }

    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return view.frame.size.height / 8

    }

    //値を次の画面へ渡す処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //セルがタップされた状態(タスク詳細画面の表示)

        if (segue.identifier == "next") &&
            textFieldTouchReturnKey == false {
            //タップした時にその配列の番号の中身を取り出して値を渡す
            let nextVC = segue.destination as! NextViewController

            //変数名.が持つ変数 =  渡したいものが入った変数
            nextVC.taskNameString = textArray[indexNumber]

        } else if (segue.identifier == "next") && textFieldTouchReturnKey == true {
            //タップした時にその配列の番号の中身を取り出して値を渡す

            let nextVC = segue.destination as! NextViewController

            nextVC.taskNameString = textField.text!
            nextVC.reloadData = self
        }
    }

    //returnキーが押された時に発動するメソッド
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {


        //リターンキーが押された
        textFieldTouchReturnKey = true
        textArray.append(textField.text!)
        textField.resignFirstResponder()
        //タスク作成画面へ遷移させる
        performSegue(withIdentifier: "next", sender: nil)

        return true

    }
}


