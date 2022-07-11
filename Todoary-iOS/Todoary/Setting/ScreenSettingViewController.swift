//
//  ScreenSettingViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/11.
//

import UIKit

class ScreenSettingViewController: UIViewController {
    
    var navigationView: NavigationView!
    
    var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationView = NavigationView(frame: .zero, self.navigationController!).then{
//
//        }
//
//        tableView = UITableView().then{
//
//        }
        
        setUpView()
        setUpConstraint()

    }

}

extension ScreenSettingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return DefaultTableViewCell()
    }
}
