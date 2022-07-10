//
//  AlarmSettingViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/10.
//

import UIKit

class AlarmSettingViewController: UIViewController {
    
    var navigationView : NavigationView!
    
    var tableView : UITableView!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()

        navigationView = NavigationView(frame: .zero, self.navigationController!).then{
            $0.navigationTitle.text = "알림"
        }
        
        tableView = UITableView().then{
            $0.separatorStyle = .none
            $0.register(AlarmSettingTableViewCell.self, forCellReuseIdentifier: "alarmSettingCell")
            $0.delegate = self
            $0.dataSource = self
        }
        
        setUpView()
        setUpConstraint()
        
    }
}

extension AlarmSettingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return AlarmSettingTableViewCell()
    }
    
    
    
}
