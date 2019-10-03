//
//  ViewController.swift
//  asuTask
//
//  Created by 金澤武士 on 2019/09/28.
//  Copyright © 2019 tk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ReloadProtocol {


    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var tableView: UITableView!

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
        textField.text = ""
    }

    func reloadSystemData(checkCount: Int) {
        if checkCount == 1 {
            tableView.reloadData()
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
        //textField.text = ""
        //タスク作成画面へ遷移させる
        performSegue(withIdentifier: "next", sender: nil)

        return true

    }
}


