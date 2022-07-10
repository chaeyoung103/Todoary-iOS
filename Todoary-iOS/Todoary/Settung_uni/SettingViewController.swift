//
//  SettingViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import UIKit
import SnapKit
import Then

class SettingViewController : UIViewController {
    
    //MARK: - UIComponenets

    let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    
    //navigation bar
    var navigationView : NavigationView!
    
    //tableView
    var tableView : UITableView!
    
    //t
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView = NavigationView(frame: .zero , self.navigationController!).then{
            $0.navigationTitle.text = "설정"
        }
        
        tableView = UITableView().then{
            $0.separatorStyle = .none
            $0.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingTableViewCell")
            $0.delegate = self
            $0.dataSource = self
        }

        setUpView()
        setUpConstraint()
    }
    
}


//MARK: - Helpers

extension SettingViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? AccountTableViewCell else{
        return UITableViewCell()
    }
    
    switch indexPath.row{
    case 0:
        cell.title.text = "알림"
        return cell
    case 1:
        cell.title.text = "화면"
        return cell
    case 2:
        cell.title.text = "계정"
        return cell
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    default:
        fatalError("TableViewCell Error")
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
        }
    }
