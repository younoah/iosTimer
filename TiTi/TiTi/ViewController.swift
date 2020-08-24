//
//  ViewController.swift
//  TiTi
//
//  Created by uno on 2020/07/28.
//  Copyright © 2020 younoah. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    // MARK:- 알고리즘
    // 1. 변수설정, 버튼 클릭시 1초마다 돌아가는 메서드 설정, print를 통해 작동여부 확인
    // 2. 이제 내부에서 돌아가는 변수값을 화면에 출력 -> 동작 확인
    // 3. 정지 기능
    // 4. 초 -> 시간:분:초 로 바꿔서 표현하기
    
    // MARK:- 프로퍼티
    @IBOutlet weak var labelPersent: UILabel!
    @IBOutlet weak var labelAllTime: UILabel!
    @IBOutlet weak var labelSumTime: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    
    @IBOutlet weak var buttonStartOutlet: UIButton!
    @IBOutlet weak var buttonStopOutlet: UIButton!
    @IBOutlet weak var buttonReStartOutlet: UIButton!
    
    @IBOutlet weak var buttonReSetOutlet: UIButton!
    @IBOutlet weak var buttonTimeSetOutlet: UIButton!
    
    // 타이머 시간 : 50분으로 설정
    var intSeconds: Int = 3000
    
    // 총 남은시간 : 8시간 설정
    var intAllTimes: Int = 28800
    
    // 누적시간 : 0 부터 시작
    var intSum: Int = 0
    
    // 타이머 작동 메서드를 실행할 수 있는지 여부
    var timerTrigger: Bool  = true
    // 타이머 작동을 위한 기본작업
    var realTime = Timer()
    
    // 컬러 변수
    let buttonColor = UIColor(named: "ButtonColor")
    let buttonClickColor = UIColor(named: "ButtonClickColor")
    let backgroundColor = UIColor(named: "BackgroundColor")
    
    
    // MARK:- 뷰의 상태 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup aft er loading the view.
        buttonStartOutlet.layer.cornerRadius = 8
        buttonStopOutlet.layer.cornerRadius = 8
        buttonReStartOutlet.layer.cornerRadius = 8
    }
    
    // MARK:- 액션 메서드
    @IBAction func buttonStartAction(_ sender: UIButton) {
        //labelTimer.text = "시작"
        if timerTrigger {
            checkTimeTrigger()
            timerTrigger = false
        }
        
        startChangeColor()
        startChangeButton()
        
    }
    @IBAction func buttonStopAction(_ sender: UIButton) {
        //labelTimer.text = "종료!"
        endTime()
        
        stopChangeColor()
        stopChangeButton()
        
    }
    @IBAction func buttonReStartAction(_ sender: UIButton) {
        labelTimer.text = "재시작!"
        intSeconds = 3000
        updateShow()
        stopChangeColor()
        stopChangeButton()
        buttonReStartOutlet.backgroundColor = buttonClickColor
        buttonReStartOutlet.isUserInteractionEnabled = false
        
    }
    @IBAction func buttonReSetAction(_ sender: UIButton) {
        labelTimer.text = "초기화!"
        getTimeDate()
        updateShow()
        stopChangeColor()
        stopChangeButton()
        buttonReStartOutlet.backgroundColor = buttonClickColor
        buttonReStartOutlet.isUserInteractionEnabled = false
    }
    @IBAction func buttonTimeSetAction(_ sender: UIButton) {
        labelTimer.text = "시간 설정!"
    }
    
    // MARK:- 타이머 메서드
    
    // 타이머 작동 메서드, 실행시 1초마다 updateCounter가 실행된다
    func checkTimeTrigger() {
        realTime = Timer.scheduledTimer(timeInterval: 1,
                                        target: self,
                                        selector: #selector(updateCounter),
                                        userInfo: nil,
                                        repeats: true)
    }
    
    // 위의 타이머 작동 메서드인 checkTimeTrigger 메서드가 실행되었을때 1초마다 실행되는 함수
    @objc func updateCounter() {
        
        // 종료될 경우 설정
        
        // 타이머 시간이 종료된 경우
        if intSeconds < 1 {
            endTime()
            stopChangeColor()
            stopChangeButton()
            AudioServicesPlaySystemSound(1254) // 진동
            AudioServicesPlaySystemSound(4095) // 특정 사운드
            
        // 총 남은시간이 종료된 경우
        } else if intAllTimes < 1 {
            endTime()
        // 그외의 타이머가 실행되어야 하는 경우
        } else {
            intSeconds = intSeconds - 1
            intSum = intSum + 1
            intAllTimes = intAllTimes - 1
        }
        
        // print함수로 타이머 작동여부 확인
//        print("seconds : " + String(intSeconds))
//        print("sum : " + String(intSum))
//        print("alltimes : " + String(intAllTimes))
        
        updateShow()
    }
    
    // 각 라벨에 시간을 출력
    func updateShow() {
        labelTimer.text = printTime(temp: intSeconds)
        labelAllTime.text = printTime(temp: intAllTimes)
        labelSumTime.text = printTime(temp: intSum)
    }
    
    // 초를  시간:분:초 로 바꿔서 표현하는 메서드
    // 초 : 60으로 나눈 나머지
    // 분 : 60으로 나눈 몫
    // 시간 : 60*60으로 나눈 몫
    // 다만 분은 61분 이상으로 표현될수 있기 때문에 분 은 시간*60으로 표현한다.
    func printTime(temp: Int) -> String {
        let second: Int = temp % 60
        let hour: Int = temp / 3600
        let minute: Int = temp / 60 - hour * 60
        
        // 삼항연산자를 이용하여 만약 10보다 작은 한자리 숫자일 경우 앞에 0을 추가하여 출력한다.
        let addZeroSecond = second < 10 ? "0" + String(second): String(second)
        let addZeroMinute = minute < 10 ? "0" + String(minute): String(minute)
        
        let resultTime = String(hour) + ":" + addZeroMinute + ":" + addZeroSecond
        
        return resultTime
    }
    
    // 정지되는 경우의 메서드
    func endTime() {
        realTime.invalidate()
        timerTrigger = true
    }
    
    // MARK:- 컬러 변경 메서드
    
    // 종료버튼 클릭시 배경, 버튼 컬러 변경
    func stopChangeColor() {
        self.view.backgroundColor = backgroundColor
        buttonStartOutlet.backgroundColor = buttonColor
        buttonStopOutlet.backgroundColor = buttonClickColor
        buttonReStartOutlet.backgroundColor = buttonColor
    }
    
    // 시작버튼 클릭시 배경, 버튼 컬러 변경
    func startChangeColor() {
        self.view.backgroundColor = UIColor.black
        buttonStartOutlet.backgroundColor = buttonClickColor
        buttonStopOutlet.backgroundColor = buttonColor
        buttonReStartOutlet.backgroundColor = buttonClickColor
    }
    
    // MARK:- 버튼 상태 메서드
    // 종료버튼 클릭시 시작, 재시작 버튼 활성화, 종료버튼 비활성화
    func startChangeButton() {
        buttonStartOutlet.isUserInteractionEnabled = false
        buttonStopOutlet.isUserInteractionEnabled = true
        buttonReStartOutlet.isUserInteractionEnabled = false
        buttonReSetOutlet.isUserInteractionEnabled = false
        buttonTimeSetOutlet.isUserInteractionEnabled = false
    }
    
    // 시작버튼 클릭시 시작, 재시작 버튼 비활성화, 종료버튼 활성화
    func stopChangeButton() {
        buttonStartOutlet.isUserInteractionEnabled = true
        buttonStopOutlet.isUserInteractionEnabled = false
        buttonReStartOutlet.isUserInteractionEnabled = true
        buttonReSetOutlet.isUserInteractionEnabled = true
        buttonTimeSetOutlet.isUserInteractionEnabled = true
    }
    
    // MARK:- 저장데이터 메서드
    // 저장되어 있는 시간을 불러오는 메서드
    func getTimeDate() {
        intSeconds =  UserDefaults.standard.value(forKey: "second") as? Int ?? 3000
        intAllTimes = UserDefaults.standard.value(forKey: "allTime") as? Int ?? 28800
        intSum = 0
    }
}

