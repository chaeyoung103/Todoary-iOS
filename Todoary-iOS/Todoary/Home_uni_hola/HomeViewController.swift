//
//  HomeViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import UIKit
import SnapKit
import Then

class HomeViewController : UIViewController , UITextFieldDelegate {
    
    let now = Date()
    var cal = Calendar.current
    let dateFormatterYear = DateFormatter()
    let dateFormatterMonth = DateFormatter()
    let dateFormatterDate = DateFormatter()
    var today : Int = 0
    var month_component : Int = 0
    var year_component : Int = 0
    var month : Int = 0
    var year : Int = 0
    var emptyDay : Int = 0
    var components = DateComponents()
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMonth = 0
    var weekdayAdding = 0
    let inset = UIEdgeInsets(top: 1, left: 3, bottom: 0, right: 3)
    
    //MARK: - UIComponenets

    //settingBtn
    
    let settingBtn = UIButton().then{
        $0.setImage(UIImage(named: "homemenu"), for: .normal)
        $0.addTarget(self, action: #selector(settingBtnDidTap), for: .touchUpInside)
    }
    
    //todoaryLogo
    
    let logo = UIImageView().then{
        $0.image = UIImage(named: "home_apptitle")
    }
    
    //profile
    
    let profileImage = UIButton().then {
        $0.setImage(UIImage(named: "home_profile"),for: .normal)
        $0.layer.cornerRadius = 40/2
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(profileBtnDidTap), for: .touchUpInside)
    }
    
    let nickname = paddingLabel().then{
        $0.layer.backgroundColor = UIColor.calendarExistColor.cgColor
        $0.layer.cornerRadius = 6
        $0.textAlignment = .center
        $0.text = "베어"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(ofSize: 14, weight: .semibold)
    }
    
    let introduce = UILabel().then{
        $0.text = "J가 되고 싶은 P"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.24)
        $0.font = UIFont.nbFont(type: .sub1)
    }
    
    
    let toolBar = UIToolbar().then {
        $0.backgroundColor = .white
        $0.sizeToFit()
        let btnDone = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(onPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(onPickCancel))
        $0.setItems([btnCancel , space , btnDone], animated: true)
        $0.isUserInteractionEnabled = true
    }
    
    let datePicker = UIDatePicker().then{
        $0.backgroundColor = .clear
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        $0.locale = Locale(identifier: "ko_KR")
    }
    
    let year_Month = UITextField().then{
        $0.text = "1999년 7월"
        $0.textColor = .black
        $0.font = UIFont.nbFont(type: .header)
        $0.tintColor = .clear
        
    }
    
    let previousMonthBtn = UIButton().then{
        $0.setImage(UIImage(named: "home_previous"), for: .normal)
        $0.addTarget(self, action: #selector(prevBtnDidTap), for: .touchUpInside)
    }
    
    let nextMonthBtn = UIButton().then{
        $0.setImage(UIImage(named: "home_next"), for: .normal)
        $0.addTarget(self, action: #selector(nextBtnDidTap), for: .touchUpInside)
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 4
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.collectionViewLayout = layout
    }


//MARK: - viewDidLoad

    override func viewDidLoad() {
    
        super.viewDidLoad()
    
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        toolBar.subviews.first?.backgroundColor = .white
        datePicker.subviews.first?.backgroundColor = .white
        datePicker.subviews.first?.subviews.first?.backgroundColor = .white
        
        setUpView()
        setUpConstraint()
        
        self.initView()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(WeekCell.self, forCellWithReuseIdentifier: "weekCell")
        self.collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "calendarCell")
        self.year_Month.delegate = self
        self.year_Month.inputView = self.datePicker
        self.year_Month.inputAccessoryView = self.toolBar
        
        GetProfileDataManager().getProfileHomeDataManger(self)

    }

    
    //MARK: - settingBtnDidTab
    
    @objc func settingBtnDidTap(_ sender: UIButton){
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    @objc func profileBtnDidTap() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    
    // datePicker.addTarget의 selector에 지정된 메서드
    @objc func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter() // Date 타입과 관련된 포맷터
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)" // 요일을 한글자만
        formatter.locale = Locale(identifier: "ko_KR")
    }
    
    @objc func onPickDone() {
        components.year = cal.component(.year, from: datePicker.date)
        components.month = cal.component(.month, from: datePicker.date)
        self.calculation()
        self.collectionView.reloadData()
        year_Month.resignFirstResponder() /// 피커뷰 내림
    }
         
    @objc func onPickCancel() {
        year_Month.resignFirstResponder() /// 피커뷰 내림
    }
    
    func successAPI_home(_ result : GetProfileResult) {
        nickname.text = result.nickname
        introduce.text = result.introduce
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return false
        }
}


class paddingLabel: UILabel {
    var padding = UIEdgeInsets(top: 1.5, left: 5, bottom: 0, right: 5)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
            var contentSize = super.intrinsicContentSize
            contentSize.height += padding.top + padding.bottom
            contentSize.width += padding.left + padding.right
            
            return contentSize
        }
}
