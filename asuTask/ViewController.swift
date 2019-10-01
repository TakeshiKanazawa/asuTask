//
//  ViewController.swift
//  asuTask
//
//  Created by 金澤武士 on 2019/09/28.
//  Copyright © 2019 tk. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
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
        
        cell.textLabel?.text  = textArray[indexPath.row]
//        cell.imageView?.image = UIImage(named:)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //タップした時にその配列の番号の中身を取り出して値を渡す
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "next") as! NextViewController
        
            nextVC.taskNameString = textArray[indexPath.row]
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.size.height/6
        
    }
    
        //値を次の画面へ渡す処理
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if (segue.identifier == "next") {
                let subVC: NextViewController = segue.destination as! NextViewController
                //変数名.が持つ変数 =  渡したいものが入った変数
                subVC.taskNameString = textField.text!
                
                
            }
        }
    
    //returnキーが押された時に発動するメソッド
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //押された
        textFieldTouchReturnKey = true
        textArray.append(textField.text!)
        textField.resignFirstResponder()
        textField.text = ""
//        tableView.reloadData()
        //タスク作成画面へ遷移させる
        performSegue(withIdentifier: "next", sender: nil)
        
        return true
        
    }
}

