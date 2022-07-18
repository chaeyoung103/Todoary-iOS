//
//  TodoListBottomSheetViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/16.
//

import UIKit

class TodoListBottomSheetViewController: UIViewController {
    
    let todoListTitle = PaddingLabel().then{
        $0.text = "TODO LIST"
        $0.font = UIFont.nbFont(ofSize: 12, weight: .extraBold)
        $0.textColor = .summaryTitle
        $0.addLetterSpacing(spacing: 0.24)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24/2
        $0.clipsToBounds = true
    }
    
    var tableView : UITableView!
    
    let diaryTitle = PaddingLabel().then{
        $0.text = "DIARY"
        $0.font = UIFont.nbFont(ofSize: 12, weight: .extraBold)
        $0.textColor = .summaryTitle
        $0.addLetterSpacing(spacing: 0.24)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24/2
        $0.clipsToBounds = true

    }
    
    let writeDiaryBanner = PaddingLabel(padding: UIEdgeInsets(top: 16, left: 19, bottom: 17, right: 25)).then{
        $0.text = "오늘의 일기를 작성해주세요! 🖌"
        $0.font = UIFont.nbFont(ofSize: 13, weight: .extraBold)
        $0.addLetterSpacing(spacing: 0.26)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    
    let todoListCount : Int = 5

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 134/255, green: 182/255, blue: 255/255, alpha: 1)

        tableView = UITableView().then{
            $0.delegate = self
            $0.dataSource = self
            
            $0.separatorStyle = .none
            $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            
            $0.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.cellIdentifier)
            
        }
        
        //MARK: - header section padding 문제 해결 못함..
//        if #available(iOS 15, *) {
//            tableView.sectionHeaderTopPadding = 1
//        }
    
        
        setUpView()
        setUpConstraint()
    }
    
    func setUpView(){
        
        self.view.addSubview(todoListTitle)
        self.view.addSubview(tableView)
        self.view.addSubview(diaryTitle)
        self.view.addSubview(writeDiaryBanner)
    }
    
    func setUpConstraint(){
        
        todoListTitle.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(33)
            make.height.equalTo(24)
        }
        
        tableView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(todoListTitle.snp.bottom).offset(8.5)
            make.height.equalTo(75*(todoListCount+1))
        }
//        tableView.backgroundColor = .red
        
        diaryTitle.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(35)
            make.top.equalTo(tableView.snp.bottom).offset(36.5)
            make.height.equalTo(24)
        }
        
        writeDiaryBanner.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(46)
            make.top.equalTo(diaryTitle.snp.bottom).offset(16)
        }
    }

}

extension TodoListBottomSheetViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.cellIdentifier, for: indexPath)
        
        return cell
    }

}
