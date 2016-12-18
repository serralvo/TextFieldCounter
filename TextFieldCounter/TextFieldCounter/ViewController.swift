//
//  ViewController.swift
//  TextFieldCounter
//
//  Created by Fabricio Serralvo on 12/7/16.
//  Copyright © 2016 Fabricio Serralvo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let frame = CGRect(x: 27, y: 70, width: 320, height: 30)
        let textField = TextFieldCounter(frame: frame, limit: 0, shouldAnimate: true, colorOfCounterLabel: UIColor.darkGray, colorOfLimitLabel: UIColor.orange)
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.backgroundColor = UIColor.white
        textField.placeholder = "Type something my friend :)"
        
        self.view.addSubview(textField)
    }

}
