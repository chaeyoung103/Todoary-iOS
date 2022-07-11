//
//  AskViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/10.
//

import UIKit

class AskViewController: UIViewController {
    
    var navigationView: NavigationView!
    
    var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationView = NavigationView(frame: .zero, self.navigationController!).then{
            $0.navigationTitle.text = "문의하기"
        }
        
        tableView = UITableView().then{
            $0.delegate = self
            $0.dataSource = self
            
            $0.register(DefaultTableViewCell.self, forCellReuseIdentifier: "askSettingCell")
            
            $0.separatorStyle = .none
        }
    }


}

extension AskViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return DefaultTableViewCell()
    }
    
    
}
