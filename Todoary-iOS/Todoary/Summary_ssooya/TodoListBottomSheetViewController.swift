//
//  TodoListBottomSheetViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/16.
//

import UIKit

class TodoListBottomSheetViewController: UIViewController {
    
    var tableView : UITableView!
    
    lazy var writeDiaryBanner = PaddingLabel(padding: UIEdgeInsets(top: 16, left: 19, bottom: 17, right: 25)).then{
        $0.text = "오늘의 일기를 작성해주세요!"
        $0.font = UIFont.nbFont(ofSize: 13, weight: .extraBold)
        $0.addLetterSpacing(spacing: 0.26)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    lazy var diaryView = DiaryView()
    
    
    let todoListCount : Int = 5
    
    //for 다이어리 작성했을 때 view 구성
    let isDiaryExist = true

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        isModalInPresentation = true
        
        self.view.backgroundColor = UIColor(red: 134/255, green: 182/255, blue: 255/255, alpha: 1)

        tableView = UITableView().then{
            $0.delegate = self
            $0.dataSource = self
            
            $0.separatorStyle = .none
            $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            
            $0.register(TodoListTitleCell.self, forCellReuseIdentifier: TodoListTitleCell.cellIdentifier)
            $0.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.cellIdentifier)
            $0.register(DiaryTitleCell.self, forCellReuseIdentifier: DiaryTitleCell.cellIdentifier)
            $0.register(DiaryCell.self, forCellReuseIdentifier: DiaryCell.cellIdentifier)
            
        }
        
        setUpView()
        setUpConstraint()
        
        //MARK: - header section padding 문제 해결 못함..
//        if #available(iOS 15, *) {
//            tableView.sectionHeaderTopPadding = 1
//        }
    }
    
    func setUpView(){
        self.view.addSubview(tableView)
    }
    
    func setUpConstraint(){
        
        tableView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(23)
            make.bottom.equalToSuperview().offset(-73)
        }
    
    }
/*
    func diaryViewSetting(){
        
        if(isDiaryExist){
            self.view.addSubview(diaryView)
            
            diaryView.snp.makeConstraints{ make in
                make.leading.equalToSuperview().offset(32)
                make.trailing.equalToSuperview().offset(-30)
                make.top.equalTo(diaryTitle.snp.bottom).offset(16)
            }
        }else{
            
            self.view.addSubview(writeDiaryBanner)
            
            writeDiaryBanner.snp.makeConstraints{ make in
                make.leading.equalToSuperview().offset(32)
                make.trailing.equalToSuperview().offset(-30)
                make.height.equalTo(46)
                make.top.equalTo(diaryTitle.snp.bottom).offset(16)
            }
        }
    }
 */
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
            cell = tableView.dequeueReusableCell(withIdentifier: DiaryCell.cellIdentifier, for: indexPath)
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.cellIdentifier, for: indexPath)
        }
        
        return cell
    }

}
