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
    
    var category_title : [String]! = ["?"]
    var category_color : [Int]! = [0]
    
    
    var dateFormatter = DateFormatter()
    var now = Date()
    var todoTitle : String!
    var targetDate : String!
    var isAlarmEnabled = false
    var targetTime = ""
    var categories: [Int]!
    
    var collectionView : UICollectionView!
    
    var current_category : CategoryButtonCollectionViewCell!
    
    
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
        $0.addTarget(self, action: #selector(plusBtnDidTap), for: .touchUpInside)
    }
    
    let categoryBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView = NavigationView(frame: .zero , self.navigationController!)

        self.view.backgroundColor = .white
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = CGFloat(8)
        
        collectionView = UICollectionView(frame: .init(), collectionViewLayout: flowLayout).then{
            $0.delegate = self
            $0.dataSource = self

            $0.register(CategoryButtonCollectionViewCell.self, forCellWithReuseIdentifier: CategoryButtonCollectionViewCell.cellIdentifier)
        }
        
        setUpView()
        setUpConstraint()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        targetDate = dateFormatter.string(from: now)
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        date.setTitle(dateFormatter.string(from: now), for: .normal)
        
        GetCategoryDataManager().getCategoryDataManager(self)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func plusBtnDidTap() {
        let colorPickerViewController = ColorPickerViewController()
        self.navigationController?.pushViewController(colorPickerViewController, animated: true)
        self.navigationController?.isNavigationBarHidden = true
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
            targetTime = ""
            isAlarmEnabled = false
        }
    }
    
    //MARK: - Helpers
    func successAPI_category(_ result : [GetCategoryResult]) {
        for i in 0...result.count{
            category_title[i] = result[i].title
            category_color[i] = result[i].color
            
        }
    }
    
    func alarmComplete(time: String, time_api: String) {
        self.time.setTitle(time, for: .normal)
        self.targetTime = time_api
    }
    
    func calendarComplete(date: String, date_api: String) {
        self.date.setTitle(date, for: .normal)
        self.targetDate = date_api
    }
    
}

extension TodoSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CategoryButtonSelect{
    func newCategoryDidSelected(cell: CategoryButtonCollectionViewCell){
        current_category.buttonIsNotSelected()
        current_category.categoryBtn.isSelected = false
        current_category = cell
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category_title.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryButtonCollectionViewCell.cellIdentifier, for: indexPath) as? CategoryButtonCollectionViewCell else{
            fatalError()
        }
        
        cell.setBtnAttribute(title: category_title[indexPath.row], color: .categoryColor[ category_color[indexPath.row]])
        cell.delegate = self
        
        if(indexPath.row == 0){
            cell.buttonIsSelected()
            current_category = cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tmpLabel = UILabel()
        tmpLabel.text = category_title[indexPath.row]
        
        if(category_title[indexPath.row].count > 2){
            tmpLabel.then{
                $0.font = UIFont.nbFont(ofSize: 14, weight: .bold)
                $0.addLetterSpacing(spacing: 0.28)
            }
        }
        
        return CGSize(width: Int(tmpLabel.intrinsicContentSize.width+32), height: 26)
    }
}
    
