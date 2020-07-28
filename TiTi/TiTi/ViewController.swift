//
//  ViewController.swift
//  TiTi
//
//  Created by uno on 2020/07/28.
//  Copyright © 2020 younoah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var LabelPersent: UILabel!
    @IBOutlet var LabelAllTime: UILabel!
    @IBOutlet var LabelSumTime: UILabel!
    @IBOutlet var LabelTimer: UILabel!
    
    @IBOutlet var ButtonStartOutlet: UIButton!
    @IBOutlet var ButtonStopOutlet: UIButton!
    @IBOutlet var ButtonReStartOutlet: UIButton!
    
    // 화면에 들어왔을 시 실행되는 메소드
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ButtonStartOutlet.layer.cornerRadius = 8
        ButtonStopOutlet.layer.cornerRadius = 8
        ButtonReStartOutlet.layer.cornerRadius = 8
    }
    
    @IBAction func ButtonStartAction(_ sender: UIButton) {
        LabelTimer.text = "iOS 스터디 꿀잼!"
    }
    @IBAction func ButtonStopAction(_ sender: UIButton) {
        LabelTimer.text = "종료!"
    }
    @IBAction func ButtonReStartAction(_ sender: UIButton) {
        LabelTimer.text = "재시작!"
    }
    @IBAction func ButtonReSetAction(_ sender: UIButton) {
        LabelTimer.text = "초기화!"
    }
    @IBAction func ButtonTimeSetAction(_ sender: UIButton) {
        LabelTimer.text = "시간 설정!"
    }
    
}

