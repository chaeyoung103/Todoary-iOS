//
//  SummaryBottomSheetViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/16.
//

import UIKit

class SummaryBottomSheetViewController: UIViewController {
    
    //MARK: - UI
    
    let sheetLine = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5/2
    }
    
    var tableView : UITableView!
    
    let addButton = UIButton().then{
        $0.backgroundColor = .summaryTitle
        $0.setImage(UIImage(named: "pencil"), for: .normal)
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
    let isDiaryExist = false
    
    var todoDataList : [GetTodoInfo]! = []
    
    var todoDate : ConvertDate!
    
    var clampCell : IndexPath = [0,-1] //clamp cell default 값
    
    var homeNavigaiton : UINavigationController!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 134/255, green: 182/255, blue: 255/255, alpha: 1)

        tableView = UITableView().then{
            
            $0.delegate = self
            $0.dataSource = self
            
            $0.separatorStyle = .none
            $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            
            $0.register(TodoListTitleCell.self, forCellReuseIdentifier: TodoListTitleCell.cellIdentifier)
            $0.register(TodoBannerCell.self, forCellReuseIdentifier: TodoBannerCell.cellIdentifier)
            $0.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.cellIdentifier)
            $0.register(DiaryTitleCell.self, forCellReuseIdentifier: DiaryTitleCell.cellIdentifier)
            //선택한 날짜에 다이어리 존재 여부에 따른 table cell 구성 differ
            isDiaryExist ? $0.register(DiaryCell.self, forCellReuseIdentifier: DiaryCell.cellIdentifier) : $0.register(DiaryBannerCell.self, forCellReuseIdentifier: DiaryBannerCell.cellIdentifier)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellWillMoveToOriginalPosition))
            $0.addGestureRecognizer(tapGesture)
            
        }
        
        setUpView()
        setUpConstraint()
        setUpSheetVC()
    }
    
    //MARK: - Action
    
    @objc
    func addButtonDidClicked(){
        
        HomeViewController.dismissBottomSheet()
        
        let vc = DiaryViewController()
        vc.todaysDate.text = todoDate.dateUsedDiary
        vc.sendApiDate = todoDate.dateSendServer
        
        homeNavigaiton.pushViewController(vc, animated: true)
    }
    
    @objc
    func cellWillMoveToOriginalPosition(){
        guard let cell = tableView.cellForRow(at: clampCell) as? TodoListTableViewCell else { return }
        cell.cellWillMoveOriginalPosition()
    }
    
    //MARK: - Helper
 
    func getPinnedCount() -> Int{
        
        var count : Int = 0
        
        todoDataList.forEach{ each in
            if (each.isPinned!) {
                count += 1
            }
        }
        return count
    }
    
    func dataArraySortByPin(){
        todoDataList.sort(by: {$0.createdTime < $1.createdTime})
        todoDataList.sort(by: {$0.targetTime ?? "25:00" < $1.targetTime ?? "25:00"})
        todoDataList.sort(by: {$0.isPinned! && !$1.isPinned!})
    }

}
//MARK: - Delegate
extension SummaryBottomSheetViewController: MoveViewController{
    func moveToViewController() {
        HomeViewController.dismissBottomSheet()
        let vc = TodoSettingViewController()
        vc.date.setTitle(todoDate.dateUsedTodo, for: .normal)
        
        self.homeNavigaiton.pushViewController(vc, animated: true)
    }
}

//MARK: - API
extension SummaryBottomSheetViewController{
    
    func checkGetTodoApiResultCode(_ result: GetTodoModel){

        switch result.code{
        case 1000:
            todoDataList = result.result
            dataArraySortByPin()
            tableView.reloadData()
            return
        default:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func checkSendPinApiResultCode(_ code: Int, _ indexPath: IndexPath){
        switch code{
        case 1000:
            print("성공")
            //pin 고정 또는 pin 고정 아니며 핀 고정 개수 초과하지 않은 케이스
            var willChangeData = todoDataList[indexPath.row-1]
            
            willChangeData.isPinned!.toggle()
            todoDataList[indexPath.row-1].isPinned = willChangeData.isPinned
            
            dataArraySortByPin()
        
            guard let newIndex = todoDataList.firstIndex(of: willChangeData) else{
                return
            }
            
            tableView.moveRow(at: indexPath, to: IndexPath(row: newIndex + 1, section: 0))
            tableView.reloadData()
            return
            
        default:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: - TableView
extension SummaryBottomSheetViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoDataList.count != 0 ? todoDataList.count + 3 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowCount = tableView.numberOfRows(inSection: 0)
        
        let cell: UITableViewCell!
        
        switch indexPath.row{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTitleCell.cellIdentifier, for: indexPath) as? TodoListTitleCell else{
                fatalError()
            }
            cell.navigaiton = homeNavigaiton
            cell.delegate = self
            return cell
        case rowCount - 2:
            cell = tableView.dequeueReusableCell(withIdentifier: DiaryTitleCell.cellIdentifier, for: indexPath)
        case rowCount - 1:
            //선택한 날짜에 다이어리 존재 여부에 따른 table cell 구성 differ
            let identifier = isDiaryExist ? DiaryCell.cellIdentifier : DiaryBannerCell.cellIdentifier
            cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        default:
            
            if(todoDataList.count != 0){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.cellIdentifier, for: indexPath) as? TodoListTableViewCell else{
                    fatalError()
                }
                let data = todoDataList[indexPath.row-1]
                cell.navigation = homeNavigaiton
                cell.delegate = self
                cell.cellData = data
                cell.cellWillSettingWithData()
                return cell
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoBannerCell.cellIdentifier, for: indexPath) as? TodoBannerCell else{
                    fatalError()
                }
                cell.navigation = homeNavigaiton
                return cell
            }
        }

        return cell
    }

}

//MARK: - TableViewCell Delegate
extension SummaryBottomSheetViewController: SelectedTableViewCellDeliver{
    
    func checkDeleteApiResultCode(_ code: Int, _ indexPath: IndexPath){
        switch code{
        case 1000:
            if(todoDataList.count == 1){
                todoDataList = []
                tableView.reloadData()
                return
            }
            todoDataList.remove(at: indexPath.row-1)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            return
        default:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func cellWillPin(_ indexPath: IndexPath){
        
        let pinnedCount: Int = getPinnedCount()
        
        let willChangeData = todoDataList[indexPath.row-1]
        let currentPin = willChangeData.isPinned!
    
        if(!currentPin && pinnedCount >= 2){ //pin 상태가 아니지만, 핀 고정 개수 초과
            //기본 팝업 띄우기
            let alertTitle = "고정은 2개까지만 가능합니다."
            
            let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        let parameter = TodoPinInput(todoId: willChangeData.todoId, isPinned: !currentPin)
        
        TodoPinDataManager().patch(parameter: parameter, indexPath: indexPath)
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
}
