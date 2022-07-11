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
        
        let offset : Double!
        if(sender.caller == 0){
            offset = 163
        }else{
            offset = 213
        }
        
        messageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(offset)
            make.leading.equalToSuperview().offset(67)
        }
        
        currentInfoView = messageView
        
//        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
//            messageLabel.alpha = 0.0
//        }, completion: { (isCompleted) in
//            messageLabel.removeFromSuperview()
//        })

        
    }
}

extension AlarmSettingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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

