//
//  CheckBox.swift
//  asuTask
//
//  Created by 金澤武士 on 2019/12/01.
//  Copyright © 2019 tk. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    // チェックボックス画像
    let checkedImage = UIImage(named: "unchecked")! as UIImage
    let uncheckedImage = UIImage(named: "checked")! as UIImage

    // Bool
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
                
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }

    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
