//
//  ViewController.swift
//  TextFieldCounter
//
//  Created by Fabricio Serralvo on 12/7/16.
//  Copyright © 2016 Fabricio Serralvo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TextFieldCounterDelegate {

    @IBOutlet weak var textField: TextFieldCounter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.counterDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor(colorLiteralRed: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    }

    func didReachMaxLength(textField: TextFieldCounter) {
        print("didReachMaxLength")
    }
    
}
