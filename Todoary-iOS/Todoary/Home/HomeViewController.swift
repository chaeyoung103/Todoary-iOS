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
    
    static var check : Int!
    
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
    var component_select = DateComponents()
    var select = -1
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMonth = 0
    var weekdayAdding = 0
    let inset = UIEdgeInsets(top: 1, left: 3, bottom: 0, right: 3)
    
    static var calendarRecord = [Int](repeating: 0, count: 32)
    static var diaryRecord = [Int](repeating: 0, count: 32)
    
    static let bottomSheetVC = SummaryBottomViewController()
    
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
        $0.imageView?.contentMode = .scaleAspectFill
        $0.setImage(UIImage(named: "home_profile"),for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40/2
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1).cgColor
        $0.addTarget(self, action: #selector(profileBtnDidTap), for: .touchUpInside)
    }
    
    let nickname = paddingLabel().then{
        $0.layer.backgroundColor = UIColor.calendarExistColor.cgColor
        $0.layer.cornerRadius = 6
        $0.textAlignment = .center
        $0.text = ""
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(ofSize: 14, weight: .semibold)
    }
    
    let introduce = UILabel().then{
        $0.text = ""
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.24)
        $0.font = UIFont.nbFont(type: .sub1)
    }
    
    lazy var year_Month = UIButton().then{
        $0.setTitle("2022년 8월", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 18, weight: .bold)
        $0.titleLabel?.textAlignment = .left
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(settingInit), for: .touchUpInside)
    }
    
    lazy var previousMonthBtn = UIButton().then{
        $0.setImage(UIImage(named: "home_previous"), for: .normal)
        $0.addTarget(self, action: #selector(prevBtnDidTap), for: .touchUpInside)
    }
    
    lazy var nextMonthBtn = UIButton().then{
        $0.setImage(UIImage(named: "home_next"), for: .normal)
        $0.addTarget(self, action: #selector(nextBtnDidTap), for: .touchUpInside)
    }
    
    static let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: 2)
        $0.collectionViewLayout = layout
    }


//MARK: - viewDidLoad

    override func viewDidLoad() {
    
        super.viewDidLoad()
    
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        setUpView()
        setUpConstraint()
      
        
        HomeViewController.collectionView.delegate = self
        HomeViewController.collectionView.dataSource = self
        HomeViewController.collectionView.register(WeekCell.self, forCellWithReuseIdentifier: "weekCell")
        HomeViewController.collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "calendarCell")
        
        self.initView()
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.calculation()
        let component = cal.date(from: components)
        
        GetCalendataManager().getCalendataManager(self, yearMonth: "\(dateFormatterYear.string(from: component!))-\(dateFormatterMonth.string(from: component!))")
        
        GetDiaryDataManager().getDiaryDataManager(self, yearMonth: "\(dateFormatterYear.string(from: component!))-\(dateFormatterMonth.string(from: component!))")
        
        HomeViewController.collectionView.reloadData()
        
        GetProfileDataManager().getProfileDataManger(self)
        
        let fcmToken = FcmTokenInput(fcm_token: UserDefaults.standard.string(forKey: "fcmToken"))
        
        FcmTokendataManager().fcmTokendataManager(self, fcmToken)
        
        showBottomSheet()
    }

    
    //MARK: - Actions
    
    @objc func settingBtnDidTap(_ sender: UIButton){
        HomeViewController.dismissBottomSheet()
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    @objc func profileBtnDidTap() {
        HomeViewController.dismissBottomSheet()
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    
    // 년,월 누르기 -> 오늘로 돌아가기
    @objc func settingInit(){
        self.initView()
        
        let convertDate = ConvertDate(year: self.year, month: self.month, date: String(self.today))
        
        GetTodoDataManager().gets(convertDate.dateSendServer)
        DiaryDataManager().gets(convertDate.dateSendServer)
    }
    
    //MARK: - Helpers
    
    func successAPI_home(_ result : GetProfileResult) {
        nickname.text = result.nickname
        introduce.text = result.introduce
        let url = URL(string: result.profileImgUrl!)
        profileImage.load(url: url!)
    }
    static func successAPI_calendar(_ result : [Int]) {
        
        calendarRecord = [Int](repeating: 0, count: 32)
        
        if !result.isEmpty{
            for i in 0...result.count-1{
                calendarRecord[result[i]] = result[i]
            }
        }
        HomeViewController.collectionView.reloadData()
    }
    
    static func successAPI_diary(_ result : [Int]) {
        
        diaryRecord = [Int](repeating: 0, count: 32)
        
        if !result.isEmpty{
            for i in 0...result.count-1{
                diaryRecord[result[i]] = result[i]
            }
        }
        HomeViewController.collectionView.reloadData()
    }
    
    static func dismissBottomSheet(){
        HomeViewController.bottomSheetVC.dismiss(animated: true, completion: nil)
    }
    
    func showBottomSheet(){
        HomeViewController.bottomSheetVC.homeNavigaiton = self.navigationController
        
        HomeViewController.bottomSheetVC.loadViewIfNeeded()
        
        let pickDate = HomeViewController.bottomSheetVC.todoDate.dateSendServer
        
        GetTodoDataManager().gets(pickDate)
        DiaryDataManager().gets(pickDate)
        GetCategoryDataManager().getCategoryDataManager(HomeViewController.bottomSheetVC)
        
        present(HomeViewController.bottomSheetVC, animated: true, completion: nil)
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

extension UIButton {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.setImage(image, for: .normal)
                    }
                }
            }
        }
    }
}
