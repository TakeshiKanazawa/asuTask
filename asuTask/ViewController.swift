//
//  ViewController.swift
//  asuTask
//
//  Created by 金澤武士 on 2019/09/28.
//  Copyright © 2019 tk. All rights reserved.
//

import UIKit
import UserNotifications

extension Date {
    //引数で指定した日付からの秒数を返す
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ReloadProtocol, DateProtocol, UNUserNotificationCenterDelegate {

    var notificationGranted = true
    var dateTime = Date()

    //タスク入力用テキストフィールド
    @IBOutlet weak var textField: UITextField!
    //テーブルビュー
    @IBOutlet weak var tableView: UITableView!
    //タスク件数表示用ラベル
    @IBOutlet weak var todaysTaskMessageLabel: UILabel!

    var indexNumber = Int()
    var uuid = 0

    //リターンキーが押されたかどうかを判定する
    var textFieldTouchReturnKey = false

    //タスク名を入れる配列
    var textArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableview　⇨ viewcontroller へ処理を任せる
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self

        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController = self

    }
    

    //画面タッチでキーボード閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            textField.resignFirstResponder()
        }

    //フォアグラウンドでも通知を表示する設定
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.alert, .badge, .sound])
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
            //本日のタスクがない場合(0件)
        } else {
            todaysTaskMessageLabel.text = "本日のタスクはありません"
        }
    }

    func reloadSystemData(checkCount: Int) {
        if checkCount == 1 {
            tableView.reloadData()
        }
    }
    
     //セクションのセルの数
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //セルの数を配列の数と同じにする
            return textArray.count
        }

        //セクション数(今回は1つ)
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        //セルを構築する際に呼ばれるメソッド
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = textArray[indexPath.row]
            
            var num = 0
            cell.tag = num
            print(cell.tag)
            
            num += 1
            
          
            
            return cell
            
        }
    
  
    
    //セルが選択(タップ)された時
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            textFieldTouchReturnKey = false
            indexNumber = indexPath.row
            
//         let nextVC = storyboard?.instantiateViewController(identifier: "next") as! NextViewController
//            nextVC.count2 = count
//            navigationController?.pushViewController(nextVC, animated: true)
            
        }

        //セルの高さ
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return view.frame.size.height / 8
        }

        //セルをスワイプで削除
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
            let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
                self.textArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                var a = indexPath.row
                
                //textarrayの配列から-1する
                //self.textArray.remove(at: index.row)
                
                tableView.reloadData()

               //登録済みの通知も削除する
                
               let center = UNUserNotificationCenter.current()
//                //center.removeAllPendingNotificationRequests()
                center.removePendingNotificationRequests(withIdentifiers: ["\(self.tableView.tag)"])
                print(self.tableView.tag)
 
            }
            deleteButton.backgroundColor = UIColor.red

            return [deleteButton]
        }

    func setDateSystem(date: Date) {

        //プッシュ通知認証許可フラグ
        var isFirst = true
        //デリゲートメソッドを設定
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            self.notificationGranted = granted

            if let error = error {
                print("エラーです")
            }
            self.setNotification(date: date)
        }
        isFirst = false
    }

    func setNotification(date: Date) {
        //通知日時の設定
        var trigger: UNNotificationTrigger
        //noticficationtimeにdatepickerで取得した値をset
        //取得時刻と現在時刻を比較し、過去の日時であった場合は登録せずアラートを出す
        
        let notificationTime = Calendar.current.dateComponents(in: TimeZone.current, from: date)
        //現在時刻の取得
        let now = Date()
        //変数taskedDateに取得日時をDatecomponens型で代入
        let taskDate = DateComponents(calendar: .current, year: notificationTime.year, month: notificationTime.month, day: notificationTime.day, hour: notificationTime.hour, minute: notificationTime.minute).date!
        //変数secondsに現在時刻とタスク通知日時の差分の秒数を代入
        let seconds = taskDate.seconds(from: now)
        //Task通知秒数のTEST出力用
        print(seconds)
        //triggerに現在時刻から〇〇秒後のタスク実行時間をset
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        //タスク通知内容の設定
        let content = UNMutableNotificationContent()
        content.title = "タスク実行時間です。"
        content.body = "タスクを実行してください"
        content.sound = .default
        
        //通知スタイルを指定
        let request = UNNotificationRequest(identifier: "\(uuid)", content: content, trigger: trigger)
        //print("\(uuid)")
    
        //通知をセット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        //identifier(識別子)をカウントUP
        uuid += 1
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
            //遷移先のNextVCのタスク名に、入力したタスク名を表示させる
            nextVC.taskNameString = textField.text!
            //デリゲート元の設定
            nextVC.reloadData = self
            nextVC.dateProtol = self
        }
    }

    //returnキーが押された時に発動するメソッド
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldTouchReturnKey = true
        textArray.append(textField.text!)
        textField.resignFirstResponder()
        //タスク作成画面へ遷移させる
        performSegue(withIdentifier: "next", sender: nil)

        return true

    }
}

