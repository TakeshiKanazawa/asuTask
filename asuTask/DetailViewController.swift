//
//  DetailViewController.swift
//  asuTask
//
//  Created by 金澤武士 on 2019/10/01.
//  Copyright © 2019 tk. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //タスク名のインスタンス
    var taskNameString = String()
    //タスク時刻のインスタンス
    var taskTimeString = String()
    //タスク優先度のインスタンス
    var taskPriorityString = String()
    
    @IBOutlet weak var taskNameButton: UIButton!
    
    @IBOutlet weak var taskPlannedTimeButton: UIButton!
    
    @IBOutlet weak var taskPriorityButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //タスク名の表示
         taskNameButton.setTitle(taskNameString, for:.normal)
        //タスク時刻の表示
        taskPlannedTimeButton.setTitle(taskTimeString, for: .normal)
        //タスク優先度の表示
        taskPriorityButton.setTitle(taskPriorityString, for: .normal)
    }
    
    //戻るボタン
    @IBAction func backButton(_ sender: Any) {
              dismiss(animated: true, completion: nil)
    }
    


}
