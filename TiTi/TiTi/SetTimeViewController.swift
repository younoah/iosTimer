//
//  SetTimeViewController.swift
//  TiTi
//
//  Created by uno on 2020/08/24.
//  Copyright © 2020 younoah. All rights reserved.
//

import UIKit

class SetTimeViewController: UIViewController {

    
    @IBOutlet weak var allTimeLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var allTimeHourTextField: UITextField!
    @IBOutlet weak var allTimeMinuteTextField: UITextField!
    @IBOutlet weak var timerHourTextField: UITextField!
    @IBOutlet weak var timerMinuteTextField: UITextField!
    
    var allTimeHour: Int = 8
    var allTimeMinute: Int = 0
    var timerHour: Int = 0
    var timerMinute: Int = 50
    
    var second: Int = 3000
    var allTime: Int = 28800
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allTimeHourTextField.addTarget(
            self,
            action: #selector(textFieldDidChange(textField:)),
            for: UIControl.Event.editingChanged)
        allTimeMinuteTextField.addTarget(
            self,
            action: #selector(textFieldDidChange(textField:)),
            for: UIControl.Event.editingChanged)
        timerHourTextField.addTarget(
            self,
            action: #selector(textFieldDidChange(textField:)),
            for: UIControl.Event.editingChanged)
        timerMinuteTextField .addTarget(
            self,
            action: #selector(textFieldDidChange(textField:)),
            for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        // 총 목표시간, 타이머 시간을 계산해서 보여주기
        
        if allTimeHourTextField.text != "" {
            allTimeHour = Int(allTimeHourTextField.text!)!
            if allTimeMinuteTextField.text != "" {
                allTimeMinute = Int(allTimeMinuteTextField.text!)!
            } else {
                allTimeMinute = 0
            }
        } else {
            allTimeHour = 8
            if allTimeMinuteTextField.text != "" {
                allTimeMinute = Int(allTimeMinuteTextField.text!)!
            } else {
                allTimeMinute = 0
            }
        }
    
        if timerHourTextField.text != "" {
            timerHour = Int(timerHourTextField.text!)!
            if timerMinuteTextField.text != "" {
                timerMinute = Int(timerMinuteTextField.text!)!
            } else {
                timerMinute = 50
            }
        } else {
            timerHour = 0
            if timerMinuteTextField.text != "" {
                timerMinute = Int(timerMinuteTextField.text!)!
            } else {
                timerMinute = 50
            }
        }
        
        allTimeLabel.text = String(allTimeHour) + ":" + String(allTimeMinute) + ":00"
        timerLabel.text = String(timerHour) + ":" + String(timerMinute) + ":00"
    }
    
    @IBAction func touchUpSetButton(_ sender: UIButton) {
        allTime = allTimeHour * 3600 + allTimeMinute * 60
        second = timerHour * 3600 + timerMinute * 60
        UserDefaults.standard.set(second, forKey: "second")
        UserDefaults.standard.set(allTime, forKey: "allTime")
        self.dismiss(animated: true, completion: nil)
    }
}
