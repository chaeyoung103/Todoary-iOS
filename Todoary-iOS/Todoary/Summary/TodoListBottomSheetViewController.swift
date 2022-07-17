//
//  TodoListBottomSheetViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/16.
//

import UIKit

class TodoListBottomSheetViewController: UIViewController {
    
    let todoListTitle = UILabel().then{
        $0.text = "TODO LIST"
        $0.font = UIFont.nbFont(ofSize: 15, weight: .extraBold)
    }
    
    var tableView : UITableView!
    
    let hiddenView = HiddenSettingView()

    override func viewDidLoad() {
        
        for fontFamily in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
                print(fontName)
            }
        }
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 134/255, green: 182/255, blue: 255/255, alpha: 1)

        tableView = UITableView().then{
            $0.delegate = self
            $0.dataSource = self
            
            $0.separatorStyle = .none
            $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            
            $0.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.cellIdentifier)
        }
        
        setUpView()
        setUpConstraint()
    }
    
    func setUpView(){
        self.view.addSubview(todoListTitle)
        self.view.addSubview(tableView)
    }
    
    func setUpConstraint(){
        
        todoListTitle.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(33)
        }
        
        tableView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(todoListTitle.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        }
    }

}

extension TodoListBottomSheetViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.cellIdentifier, for: indexPath)
        
        return cell
    }
    
}
