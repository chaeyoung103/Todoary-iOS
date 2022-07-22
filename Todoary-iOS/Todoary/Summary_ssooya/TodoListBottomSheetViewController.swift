//
//  TodoListBottomSheetViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/16.
//

import UIKit

class TodoListBottomSheetViewController: UIViewController {
    
    let sheetLine = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5/2
    }
    
    var tableView : UITableView!
    
    let addButton = UIButton().then{
        $0.backgroundColor = .summaryTitle
        $0.layer.cornerRadius = 70/2
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
        $0.addTarget(self, action: #selector(addButtonDidClicked), for: .touchUpInside)
    }
    //MARK: - Properties
    
    //for 다이어리 작성했을 때 view 구성
    let isDiaryExist = true
    
    //더미 데이터
    var summaryData : [SummaryData] = [
        SummaryData(time: "AM 7:00", pin: false, alarm: false, category: false),
        SummaryData(time: "AM 10:00", pin: true, alarm: false, category: false),
        SummaryData(time: "AM 10:30", pin: false, alarm: true, category: false),
        SummaryData(time: "AM 11:00", pin: false, alarm: false, category: true),
        SummaryData(time: "PM 2:00", pin: true, alarm: true, category: true),
        SummaryData(time: "PM 4:00", pin: false, alarm: false, category: false),
        SummaryData(time: "PM 11:00", pin: false, alarm: true, category: true),
        SummaryData(time: "PM 11:30", pin: false, alarm: true, category: true)
    ]
    
    //clamp cell
    var clampCell : IndexPath = [0,-1] //default 값
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 134/255, green: 182/255, blue: 255/255, alpha: 1)

        tableView = UITableView().then{
            
            $0.delegate = self
            $0.dataSource = self
            
            $0.separatorStyle = .none
            $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            
            $0.register(TodoListTitleCell.self, forCellReuseIdentifier: TodoListTitleCell.cellIdentifier)
            $0.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.cellIdentifier)
            $0.register(DiaryTitleCell.self, forCellReuseIdentifier: DiaryTitleCell.cellIdentifier)
            //선택한 날짜에 다이어리 존재 여부에 따른 table cell 구성 differ
            isDiaryExist ? $0.register(DiaryCell.self, forCellReuseIdentifier: DiaryCell.cellIdentifier) : $0.register(DiaryBannerCell.self, forCellReuseIdentifier: DiaryBannerCell.cellIdentifier)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellWillMoveToOriginalPosition))
            $0.addGestureRecognizer(tapGesture)
            
        }
        
        dataArraySortByPin()
        
        setUpView()
        setUpConstraint()
        setUpSheetVC()
    }
    
    func setUpView(){
        self.view.addSubview(sheetLine)
        self.view.addSubview(tableView)
        self.view.addSubview(addButton)
    }
    
    func setUpConstraint(){
        
        sheetLine.snp.makeConstraints{ make in
            make.width.equalTo(46)
            make.height.equalTo(5)
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(172)
            make.trailing.equalToSuperview().offset(-172)
        }
        
        tableView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
        
        addButton.snp.makeConstraints{ make in
            make.width.height.equalTo(70)
            make.bottom.equalToSuperview().offset(-89)
            make.trailing.equalToSuperview().offset(-27)
        }
    
    }
    
    @objc
    func addButtonDidClicked(){
        print("clicked")
    }
    
    @objc
    func cellWillMoveToOriginalPosition(){
        guard let cell = tableView.cellForRow(at: clampCell) as? TodoListTableViewCell else{
                return
        }
        cell.cellWillMoveOriginalPosition()
    }
 
}

extension TodoListBottomSheetViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summaryData.count + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowCount = tableView.numberOfRows(inSection: 0)
        
        let cell: UITableViewCell!
        
        switch indexPath.row{
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: TodoListTitleCell.cellIdentifier, for: indexPath)
        case rowCount - 2:
            cell = tableView.dequeueReusableCell(withIdentifier: DiaryTitleCell.cellIdentifier, for: indexPath)
        case rowCount - 1:
            //선택한 날짜에 다이어리 존재 여부에 따른 table cell 구성 differ
            let identifier = isDiaryExist ? DiaryCell.cellIdentifier : DiaryBannerCell.cellIdentifier
            cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.cellIdentifier, for: indexPath) as? TodoListTableViewCell else{
                fatalError()
            }
            let data = summaryData[indexPath.row-1]
            cell.delegate = self
            cell.titleLabel.text = "아침 산책"
            cell.timeLabel.text = data.time
            cell.isPin = data.pin
            cell.isAlarm = data.alarm
            cell.hasCategory = data.category
            cell.setUpViewByCase()
            return cell
        }
        return cell
    }

}

extension TodoListBottomSheetViewController: SelectedTableViewCellDeliver{
    
    func cellWillDelete(_ indexPath: IndexPath){
        summaryData.remove(at: indexPath.row-1)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func cellWillPin(_ indexPath: IndexPath){
        
        let pinnedCount: Int = getPinnedCount()
        
        let willChangeData = summaryData[indexPath.row-1]
    
        if(!willChangeData.pin && pinnedCount >= 2){ //pin 상태가 아니지만, 핀 고정 개수 초과
            //기본 팝업 띄우기
            let alertTitle = "고정은 2개까지만 가능합니다."
            
            let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //pin 고정 또는 pin 고정 아니며 핀 고정 개수 초과하지 않은 케이스
        willChangeData.pin.toggle()
        
        dataArraySortByPin()
    
        guard let newIndex = summaryData.firstIndex(of: willChangeData) else{
            return
        }
        
        tableView.moveRow(at: indexPath, to: IndexPath(row: newIndex + 1, section: 0))
        tableView.reloadData()
    }
    
    func cellWillMoveSettingVC(){
        
    }
    
    func cellWillClamp(_ indexPath: IndexPath){
        
        //1. 기존 고정 cell 존재 여부 점검 (row 값 -1인지 아닌지)
        if(clampCell == indexPath){
            return
        }else if(clampCell.row != -1){
        //2. -1 아닐 경우 -> 이미 고정되어 있는 cell 존재 -> 고정 풀기
            guard let cell = tableView.cellForRow(at: clampCell) as? TodoListTableViewCell else{
                return
            }
            cell.cellWillMoveOriginalPosition()
        }
        //row 값 -1일 때와, row 값 -1 아닐 때 공통 코드(즉, 자기 자신 아닐 때만 제외)
        clampCell = indexPath
    }
    
    func getPinnedCount() -> Int{
        
        var count : Int = 0
        
        summaryData.forEach{ each in
            if (each.pin) {
                count += 1
            }
        }
        
        return count
    }
    
    func dataArraySortByPin(){
        summaryData.sort(by: {$0.time < $1.time})
        summaryData.sort(by: {$0.pin && !$1.pin})
    }
}

extension TodoListBottomSheetViewController: UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let controller: UISheetPresentationController = .init(presentedViewController: presented, presenting: presenting)
        
        let detent1: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test1", constant: 325)
        let detent2: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test2", constant: 600)
        
        let detentIdentifier :UISheetPresentationController.Detent.Identifier = UISheetPresentationController.Detent.Identifier(rawValue: "Test2")
        
        controller.detents = [detent1, detent2]
        controller.preferredCornerRadius = 30
        controller.largestUndimmedDetentIdentifier = detentIdentifier
        controller.prefersScrollingExpandsWhenScrolledToEdge = false
        
        return controller
    }
    
    func setUpSheetVC(){
        isModalInPresentation = true
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
}

class SummaryData : Equatable{
    
    var time: String
    var pin: Bool
    var alarm: Bool
    var category: Bool
    
    init(time: String, pin: Bool, alarm: Bool, category: Bool ){
        self.time = time
        self.pin = pin
        self.alarm = alarm
        self.category = category
    }
    
    static func ==(lhs: SummaryData, rhs: SummaryData) -> Bool {
        return lhs.time == rhs.time && lhs.pin == rhs.pin && lhs.alarm == rhs.alarm && lhs.category == rhs.category
    }
}
