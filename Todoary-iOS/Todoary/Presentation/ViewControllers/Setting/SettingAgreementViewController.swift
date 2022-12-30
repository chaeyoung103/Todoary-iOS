//
//  SettingAgreementViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import UIKit
import SnapKit
import Then

class SettingAgreementViewController : BaseViewController {
    
    let mainView = SettingAgreementView()

    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func style() {
        
        super.style()
        
        navigationTitle.text = "약관 및 정책"
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
        mainView.tableView.separatorStyle = .none
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
}


//MARK: - Helpers

extension SettingAgreementViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingAgreementViewCell", for: indexPath) as? SettingAgreementViewCell else{
        return UITableViewCell()
    }
    
    switch indexPath.row{
    case 0:
        cell.title.text = "개인 정보 취급방침"
        return cell
    case 1:
        cell.title.text = "서비스 이용약관"
        return cell
    case 2:
        cell.title.text = "광고성 정보 수신"
        return cell
        
    default:
        fatalError("TableViewCell Error")
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            self.navigationController?.pushViewController(PrivacyTextViewController(), animated: true)
            return
        case 1:
            self.navigationController?.pushViewController(UseServiceViewController(), animated: true)
            return
        case 2:
            self.navigationController?.pushViewController(AdTextSettingViewController(), animated: true)
            return
        default:
            return
            }
        }
    }

