//
//  TodoListTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/16.
//

import UIKit
import SnapKit

class TodoListTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "todoListCell"
    
    let selectedBackView = UIView().then{
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    //tableCell UI
    let checkBox = UIButton().then{
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.setImage(UIImage(named: "todo_check"), for: .selected)
        $0.addTarget(self, action: #selector(checkBoxDidClicked(_:)), for: .touchUpInside)
    }
    
    let titleLabel = UILabel().then{
        $0.text = "아침 산책"
        $0.textColor = .black
        $0.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.addLetterSpacing(spacing: 0.3)
    }
    
    let categoryButton = UIButton().then{
        $0.setTitle("운동", for: .normal)
        $0.setTitleColor(UIColor(red: 122/255, green: 73/255, blue: 185/255, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 12, weight: .bold)
        $0.addLetterSpacing(spacing: 0.24)
        $0.layer.borderColor = UIColor(red: 122/255, green: 73/255, blue: 185/255, alpha: 1).cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 21/2
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 13, bottom: 3, right: 11)
    }
    
    let pinImage = UIImageView().then{
        $0.image = UIImage(named: "push_pin")
    }
    
    let alarmImage = UIImageView().then{
        $0.image = UIImage(named: "notifications")
    }
    
    let timeLabel = UILabel().then{
        $0.text = "AM 7:00"
        $0.font = UIFont.nbFont(ofSize: 13, weight: .medium)
        $0.addLetterSpacing(spacing: -0.26)
    }
    
    let backView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let hiddenView = HiddenSettingView()
    
    //MARK: - Properties
    var originalCenter = CGPoint()
    var deleteOnDragRelease = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        backView.layer.cornerRadius = 20
        
        setUpView()
        setUpConstraint()
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        swipeGesture.delegate = self
        backView.addGestureRecognizer(swipeGesture)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func checkBoxDidClicked(_ sender: UIButton){
        
        sender.isSelected.toggle()
        
//        if(sender.isSelected){
//
//        }else{
//
//        }
    }
}


extension TodoListTableViewCell{

    @objc
    func handlePan(_ recognizer: UIPanGestureRecognizer){

        if(recognizer.state == .began){
            originalCenter = center
            hiddenSettingViewShow()
        }
        if (recognizer.state == .changed){
            let translation = recognizer.translation(in: self)
            center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y)
            // has the user dragged the item far enough to initiate a delete/complete?
            deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
        }
        if recognizer.state == .ended {
          // the frame this cell had before user dragged it
          let originalFrame = CGRect(x: 0, y: frame.origin.y,
              width: bounds.size.width, height: bounds.size.height)
          if !deleteOnDragRelease {
            // if the item is not being deleted, snap back to the original location
              UIView.animate(withDuration: 0.2, animations: {self.frame = originalFrame})
          }
        }
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {

        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translation(in: superview)
            if abs(translation.x) > abs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
    
    func hiddenSettingViewShow(){
        
        self.superview?.superview?.addSubview(hiddenView)
        self.superview?.superview?.sendSubviewToBack(hiddenView)
        
        hiddenView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
        }
    }
}
