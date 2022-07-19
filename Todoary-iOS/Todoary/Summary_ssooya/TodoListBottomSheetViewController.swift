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
    
    let todoListCount : Int = 5
    
    //for 다이어리 작성했을 때 view 구성
    let isDiaryExist = true
    
    let tableViewBackView = UIView()

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 134/255, green: 182/255, blue: 255/255, alpha: 1)
        self.view.isUserInteractionEnabled = true

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
        
        tableView.backgroundView = tableViewBackView
        tableViewBackView.backgroundColor = .red
        
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
            make.top.equalToSuperview().offset(23)
            make.bottom.equalToSuperview()
        }
        
        tableViewBackView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalTo(tableView)
        }
    
    }
 
}

extension TodoListBottomSheetViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListCount + 3
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
            cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.cellIdentifier, for: indexPath)
        }
        
        return cell
    }

}

extension TodoListBottomSheetViewController: UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let controller: UISheetPresentationController = .init(presentedViewController: presented, presenting: presenting)
        
        let detent1: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test1", constant: 325)
        let detent2: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test2", constant: 600)
        
        let detentIdentifier :UISheetPresentationController.Detent.Identifier = UISheetPresentationController.Detent.Identifier(rawValue: "Test2") ?? .medium
        
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
