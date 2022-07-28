//
//  TodoSettingViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/23.
//

import UIKit
import SnapKit
import Then

class TodoSettingViewController : UIViewController, AlarmComplete, CalendarComplete {
    
    
    var dateFormatter = DateFormatter()
    var now = Date()
    var todoTitle : String!
    var targetDate : String!
    var isAlarmEnabled : Bool!
    var targetTime : String!
    var categories: [Int]!
    
    
    //MARK: - UIComponenets
    
    let completeBtn = UIButton().then{
        $0.setTitle("완료", for: .normal)
        $0.addLetterSpacing(spacing: 0.36)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 18, weight: .medium)
        $0.addTarget(self, action: #selector(todocompleteBtnDidTap), for: .touchUpInside)
    }
    
    //navigation bar
    var navigationView : NavigationView!
    
    let todo = UITextField().then{
        $0.placeholder = "투두이름"
        $0.font = UIFont.nbFont(type: .body2)
        $0.setPlaceholderColor(.black)
    }
    
    let todoBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let dateTitle = UILabel().then{
        $0.text = "날짜"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let date = UIButton().then{
        $0.setTitle("2022년 7월 20일", for: .normal)
        $0.addLetterSpacing(spacing: 0.28)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body2)
        $0.addTarget(self, action: #selector(dateDidTap), for: .touchUpInside)
    }
    
    let dateBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let alarm = UILabel().then{
        $0.text = "알람"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    var time = UIButton().then{
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.setTitle("AM 8:00", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addLetterSpacing(spacing: 0.28)
        $0.titleLabel?.font = UIFont.nbFont(type: .body2)
        $0.addTarget(self, action: #selector(timeDidTap), for: .touchUpInside)
    }
    
    let alarmSwitch = UISwitch().then{
        $0.addTarget(self, action: #selector(onClickSwitch(sender:)), for: .valueChanged)

    }
    
    let alarmBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let category = UILabel().then{
        $0.text = "카테고리"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let plusBtn = UIButton().then{
        $0.setImage(UIImage(named: "categoryadd"), for: .normal)
    }
    
    let category1 = UIButton().then{
        $0.setTitle("운동", for: .normal)
        $0.setTitleColor(UIColor(red: 122/255, green: 73/255, blue: 185/255, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 12, weight: .bold)
        $0.addLetterSpacing(spacing: 0.24)
        $0.layer.borderColor = UIColor(red: 122/255, green: 73/255, blue: 185/255, alpha: 1).cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 26/2
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 13, bottom: 3, right: 11)
        $0.isEnabled = false
    }
    
    let category2 = UIButton().then{
        $0.setTitle("운동", for: .normal)
        $0.setTitleColor(UIColor(red: 122/255, green: 73/255, blue: 185/255, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 12, weight: .bold)
        $0.addLetterSpacing(spacing: 0.24)
        $0.layer.borderColor = UIColor(red: 122/255, green: 73/255, blue: 185/255, alpha: 1).cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 26/2
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 13, bottom: 3, right: 11)
        $0.isEnabled = false
    }
    
    let category3 = UIButton().then{
        $0.setTitle("운동", for: .normal)
        $0.setTitleColor(UIColor(red: 122/255, green: 73/255, blue: 185/255, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 12, weight: .bold)
        $0.addLetterSpacing(spacing: 0.24)
        $0.layer.borderColor = UIColor(red: 122/255, green: 73/255, blue: 185/255, alpha: 1).cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 26/2
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 14, bottom: 4, right: 14)
        $0.isEnabled = false
    }
    
    let categoryBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView = NavigationView(frame: .zero , self.navigationController!)

        self.view.backgroundColor = .white
        
        setUpView()
        setUpConstraint()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        targetDate = dateFormatter.string(from: now)
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        date.setTitle(dateFormatter.string(from: now), for: .normal)
        
        
        
    }
    
    //MARK: - Actions
    @objc func dateDidTap() {
        let todoCalendarBottomSheetVC = TodoCalendarBottomSheetViewController()
        todoCalendarBottomSheetVC.modalPresentationStyle = .overFullScreen
        todoCalendarBottomSheetVC.delegate = self
        self.present(todoCalendarBottomSheetVC, animated: false, completion: nil)
    }
    
    @objc func timeDidTap() {
        let todoAlarmBottomSheetVC = TodoAlarmBottomSheetViewController()
        todoAlarmBottomSheetVC.modalPresentationStyle = .overFullScreen
        
        todoAlarmBottomSheetVC.delegate = self
        
        self.present(todoAlarmBottomSheetVC, animated: false, completion: nil)
    }
    
    @objc func todocompleteBtnDidTap() {
        todoTitle = todo.text!
        let todoSettingInput = TodoSettingInput(title: todoTitle, targetDate: targetDate, isAlarmEnabled: isAlarmEnabled, targetTime: targetTime, categories: [])
        TodoSettingDataManager().todoSettingDataManager(self, todoSettingInput)
    }
    
    @objc func onClickSwitch(sender: UISwitch) {

        if sender.isOn {
            time.isHidden = false
            isAlarmEnabled = true
            targetTime = "08:00"
            let todoAlarmBottomSheetVC = TodoAlarmBottomSheetViewController()
            todoAlarmBottomSheetVC.modalPresentationStyle = .overFullScreen
            
            todoAlarmBottomSheetVC.delegate = self
            
            self.present(todoAlarmBottomSheetVC, animated: false, completion: nil)
        }else {
            time.isHidden = true
            targetTime = nil
            isAlarmEnabled = false
        }
    }
    
    //MARK: - Helpers
    
    func alarmComplete(time: String, time_api: String) {
        self.time.setTitle(time, for: .normal)
        self.targetTime = time_api
    }
    
    func calendarComplete(date: String, date_api: String) {
        self.date.setTitle(date, for: .normal)
        self.targetDate = date_api
    }
    
}
    
    
