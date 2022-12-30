//
//  ScreenSettingViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/11.
//

import UIKit

class ScreenSettingViewController: BaseViewController {
    
    let mainView = ScreenSettingView()
    
    override func style() {
        super.style()
        navigationTitle.text = "화면"
    }
    
    override func layout() {
        
        super.layout()
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func initialize() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.separatorStyle = .none
    }

}

extension ScreenSettingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "screenSettingCell", for: indexPath) as? DefaultTableViewCell else{
            fatalError()
        }
        
        switch indexPath.row{
        case 0:
            cell.cellTitle.text = "글꼴"
            return cell
        case 1:
            cell.cellTitle.text = "화면테마"
            return cell
        default:
            fatalError("TableView Cell indexing Error")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            self.navigationController?.pushViewController(FontSettingViewController(), animated: true)
            return
        case 1:
            return
        default:
            return
        }
    }
}
