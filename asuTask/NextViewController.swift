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

    override func viewDidLoad() {
        super.viewDidLoad()

        taskNameTextField.text = taskNameString


    }

    //戻るボタン
    @IBAction func back(_ sender: Any) {

        reloadData?.reloadSystemData(checkCount: 1)
        dismiss(animated: true, completion: nil)

    }




}
