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
    
    var currentInfoView: UIView?
    

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
        
        //for view 터치시, 도움말 팝업 제거
        let viewTapGesture = UITapGestureRecognizer()
        viewTapGesture.delegate = self
        self.view.addGestureRecognizer(viewTapGesture)
        
    }
    
    @objc
    func showInfoMessage(_ sender: CellButtonTapGesture){
        
        let messageView = InfoMessageView()
        
        self.view.addSubview(messageView)
        
        var offset = 0
        
        switch sender.caller{
        case 0:
            offset = 163
            messageView.messageLabel.text = """
            Todo list의 시간 알림입니다.
            알림을 해제하면 모든 Todo list
            알림을 받으실 수 없습니다.
            """
            break
        case 1:
            offset = 213
            messageView.messageLabel.text = """
            하루를 매일 기록할 수 있도록 도와주는
            알림입니다. 매일 설정한 시간에 알람이
            올 수 있도록 설정할 수 있습니다.
            """
            break
        case 2:
            offset = 263
            messageView.messageLabel.text = """
            일주일 동안 기록을 하지 않으면
            Todoary가 알려줍니다.
            """
            break
        default:
            return
        }
        
        messageView.snp.makeConstraints{ make in
            make.width.equalTo(messageView.messageLabel.snp.width).offset(32)
            make.height.equalTo(messageView.messageLabel.snp.height).offset(22)
            make.top.equalToSuperview().offset(offset)
            make.leading.equalToSuperview().offset(67)
        }
        
        currentInfoView = messageView
        
    }
}

extension AlarmSettingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmSettingCell", for: indexPath) as? AlarmSettingTableViewCell else{
            return UITableViewCell()
        }
        
        
        let tapGesture = CellButtonTapGesture(target: self, action: #selector(showInfoMessage(_:)))
        tapGesture.caller = indexPath.row
        cell.infoBtn.addGestureRecognizer(tapGesture)
        
        switch indexPath.row{
        case 0:
            cell.cellTitle.text = "Todoary 알림"
            return cell
        case 1:
            cell.cellTitle.text = "하루기록 알림"
            return cell
        case 2:
            cell.cellTitle.text = "리마인드 알림"
            return cell
        default:
            fatalError("TableViewCell Error")
        }
    }
    
}

extension AlarmSettingViewController: UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        currentInfoView?.removeFromSuperview()
        return true
    }
}

