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
    }
    
    var tableView : UITableView!

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
    
//    //leading
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let pin = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
//            print("Share 클릭 됨")
//            success(true)
//        }
//
//        pin.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
//        pin.image = UIImage(named: "push_pin_big")
////        delete.backgroundColor = .white
//
//        return UISwipeActionsConfiguration(actions: [pin])
//    }
//
//    //trailing
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let setting = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
//            print("Like 클릭 됨")
//            success(true)
//        }
//
//        setting.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
//        setting.image = UIImage(named: "settings")
//
//
//        let delete = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
//            print("Share 클릭 됨")
//            success(true)
//        }
//
//        delete.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
//        delete.image = UIImage(named: "trash")
////        delete.backgroundColor = .white
//
//        return UISwipeActionsConfiguration(actions: [delete, setting])
//    }

    
    //trailing
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//
//        return UISwipeActionsConfiguration()
//    }
    
}