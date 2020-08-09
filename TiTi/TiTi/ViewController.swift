//
//  ViewController.swift
//  TiTi
//
//  Created by uno on 2020/07/28.
//  Copyright © 2020 younoah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK:- 알고리즘
    // 1. 변수설정, 버튼 클릭시 1초마다 돌아가는 메서드 설정, print를 통해 작동여부 확인
    // 2. 이제 내부에서 돌아가는 변수값을 화면에 출력 -> 동작 확인
    // 3. 정지 기능
    // 4. 초 -> 시간:분:초 로 바꿔서 표현하기
    
    // MARK:- 프로퍼티
    @IBOutlet var labelPersent: UILabel!
    @IBOutlet var labelAllTime: UILabel!
    @IBOutlet var labelSumTime: UILabel!
    @IBOutlet var labelTimer: UILabel!
    
    @IBOutlet var buttonStartOutlet: UIButton!
    @IBOutlet var buttonStopOutlet: UIButton!
    @IBOutlet var buttonReStartOutlet: UIButton!
    
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
    
    // MARK:- 뷰의 상태 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    }
    @IBAction func buttonStopAction(_ sender: UIButton) {
        //labelTimer.text = "종료!"
        realTime.invalidate()
        timerTrigger = true
    }
    @IBAction func buttonReStartAction(_ sender: UIButton) {
        labelTimer.text = "재시작!"
    }
    @IBAction func buttonReSetAction(_ sender: UIButton) {
        labelTimer.text = "초기화!"
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
        intSeconds = intSeconds - 1
        intSum = intSum + 1
        intAllTimes = intAllTimes - 1
        
        // print함수로 타이머 작동여부 확인
        print("seconds : " + String(intSeconds))
        print("sum : " + String(intSum))
        print("alltimes : " + String(intAllTimes))
        
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
        
        let resultTime = String(hour) + ":" + String(minute) + ":" + String(second)
        
        return resultTime
    }
    
}

