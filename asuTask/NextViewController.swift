//
//  NextViewController.swift
//  asuTask
//
//  Created by 金澤武士 on 2019/09/28.
//  Copyright © 2019 tk. All rights reserved.


import UIKit

class NextViewController: UIViewController {
    
    //タスク名のテキストフィールド
    var taskNameString = String()
    @IBOutlet weak var taskNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    taskNameTextField.text = taskNameString
        

    }
    
    //戻るボタン
    @IBAction func back(_ sender: Any) {
          dismiss(animated: true, completion:nil)
            
    }
    

    

}
