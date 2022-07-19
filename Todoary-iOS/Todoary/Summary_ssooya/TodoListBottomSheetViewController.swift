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
    
    //MARK: - Properties
    
//    var todoListCount : Int = 5
    
    //for 다이어리 작성했을 때 view 구성
    let isDiaryExist = true
    
    //더미 데이터
    var dumyData = ["AM 7:00","AM 10:00","AM 10:30","AM 11:00"
                    ,"PM 2:00","PM 4:00","PM 11:00","PM 12:00"]
    
    var pinData = [false, true, false, false, true,true, false, true]
    
    var alarmData = [false, false, true, false, true,false, true, true]
    
    var categoryData = [false, false, false, true, false,true, true, true]

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
            
        }
        
        setUpView()
        setUpConstraint()
        setUpSheetVC()
        
        //MARK: - header section padding 문제 해결 못함..
//        if #available(iOS 15, *) {
//            tableView.sectionHeaderTopPadding = 1
//        }
    }
    
    func setUpView(){
        self.view.addSubview(sheetLine)
        self.view.addSubview(tableView)
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
    
    }
 
}

extension TodoListBottomSheetViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pinData.count + 3
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
            cell.cellDelegate = self
            cell.timeLabel.text = dumyData[indexPath.row-1]
            cell.isPin = pinData[indexPath.row-1]
            cell.isAlarm = alarmData[indexPath.row-1]
            cell.hasCategory = categoryData[indexPath.row-1]
            cell.setUpViewByCase()
            return cell
        }
        return cell
    }

}

extension TodoListBottomSheetViewController: SelectedTableViewCellDeliver{
    
    func willDeleteCell(_ indexPath: IndexPath){
        
        dumyData.remove(at: indexPath.row-1)
        pinData.remove(at: indexPath.row-1)
        alarmData.remove(at: indexPath.row-1)
        categoryData.remove(at: indexPath.row-1)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func willPinCell(_ indexPath: IndexPath){
        
//        tableView.moveRow(at: indexPath, to: <#T##IndexPath#>)
    }
    
    func willMoveSettingCell(){
        
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
