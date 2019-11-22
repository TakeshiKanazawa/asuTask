//
//  DetailViewController.swift
//  asuTask
//
//  Created by 金澤武士 on 2019/10/01.
//  Copyright © 2019 tk. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var taskNameString = String()
    @IBOutlet weak var taskNameButton: UIButton!
    
    @IBOutlet weak var taskPlannedTimeButton: UIButton!
    
    @IBOutlet weak var taskPriorityButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
       //タスク名の表示
        taskNameButton.setTitle(taskNameString, for:.normal)

    }
    



}
