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

class HomeViewController : UIViewController {
    
    let now = Date()
    var cal = Calendar.current
    let dateFormatterYear = DateFormatter()
    let dateFormatterMonth = DateFormatter()
    var Month : Int = 0
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
    
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "home_profile")
        $0.layer.cornerRadius = 40/2
        $0.clipsToBounds = true
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
    
    let year_Month = UILabel().then{
        $0.text = "2020년7월"
        $0.textColor = .black
        $0.font = UIFont.nbFont(type: .header)
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
        
        setUpView()
        setUpConstraint()
        
        self.initView()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(WeekCell.self, forCellWithReuseIdentifier: "weekCell")
        self.collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "calendarCell")
    }

    
    //MARK: - settingBtnDidTab
    
    @objc
    func settingBtnDidTap(_ sender: UIButton){
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }

}

class paddingLabel: UILabel {
    var padding = UIEdgeInsets(top: 1.5, left: 10, bottom: 0, right: 10)
    
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
