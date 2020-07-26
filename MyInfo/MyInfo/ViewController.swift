//
//  ViewController.swift
//  MyInfo
//
//  Created by uno on 2020/07/26.
//  Copyright © 2020 younoah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelHello: UILabel!
    @IBOutlet weak var textGradeID: UITextField!
    @IBOutlet weak var textName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonSubmit(_ sender: UIButton) {
        labelHello.text = "학번 : " + textGradeID.text! + "\n이름 : " + textName.text!
    }
    
}

