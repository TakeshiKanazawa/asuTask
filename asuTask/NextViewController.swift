//
//  NextViewController.swift
//  asuTask
//
//  Created by 金澤武士 on 2019/09/28.
//  Copyright © 2019 tk. All rights reserved.


import UIKit

class NextViewController: UIViewController {
    
    //タスク名のラベル
    var toDoString = String()
    @IBOutlet weak var todoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    todoLabel.text = toDoString


    }
    
    //戻るボタン
    @IBAction func back(_ sender: Any) {
          dismiss(animated: true, completion:nil)
    }
    

}
