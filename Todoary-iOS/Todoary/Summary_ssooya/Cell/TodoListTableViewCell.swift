//
//  TodoListTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/16.
//

import UIKit
import SnapKit

enum CurrentHidden{
    case none
    case left
    case right
}

class TodoListTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "todoListCell"
    
    weak var delegate : SelectedTableViewCellDeliver?
    
    let selectedBackView = UIView().then{
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    //tableCell UI
    let checkBox = UIButton().then{
        $0.setImage(UIImage(named: "todo_check_empty"), for: .normal)
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
        $0.isEnabled = false
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
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .white
    }
    
    lazy var hiddenLeftView = HiddenLeftButtonView().then{
        $0.pinButton.addTarget(self, action: #selector(pinButtonDidClicked(_:)), for: .touchUpInside)
    }
    
    lazy var hiddenRightView = HiddenRightButtonView().then{
        $0.settingButton.addTarget(self, action: #selector(settingButtonDidClicked(_:)), for: .touchUpInside)
        $0.deleteButton.addTarget(self, action: #selector(deleteButtonDidClicked(_:)), for: .touchUpInside)
    }
    
    lazy var hiddenView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        
        $0.snp.makeConstraints{ make in
            make.height.equalTo(60)
        }
    }
    
    //MARK: - CellData
    var isPin : Bool!
    var isAlarm : Bool!
    var hasCategory : Bool!
    
    //hiddenView addSubView 되었는지 아닌지 확인 용도
    var isViewAdd : CurrentHidden = .none
    
    var originalCenter = CGPoint()
    var isClamp = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
     
        setUpView()
        setUpConstraint()
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        
        swipeGesture.delegate = self
        backView.addGestureRecognizer(swipeGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties(for swipe)
    
//    weak var delegate : MWSwipeableTableViewCellDelegate?
    
    var animationOptions : UIView.AnimationOptions = [.allowUserInteraction, .beginFromCurrentState]
    var animationDuration : TimeInterval = 0.5
    var animationDelay : TimeInterval = 0
    var animationSpingDamping : CGFloat = 0.5
    var animationInitialVelocity : CGFloat = 1
    
    let leftWidth : CGFloat = 58
    let rightWidth : CGFloat = 105

    private var beginPoint : CGPoint = .zero
    
}

extension TodoListTableViewCell{

    @objc
    func handlePan(_ recognizer: UIPanGestureRecognizer){

        let translation = recognizer.translation(in: self)
        let superView = self.superview?.superview
        
        if(recognizer.state == .began){
            originalCenter = center
            hiddenSettingViewShow(translation.x)
        }
        if (recognizer.state == .changed){
            
            center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y)
    
            if(frame.origin.x > 0){ //왼쪽 view
//                superView?.bringSubviewToFront(hiddenLeftView)
                isClamp = frame.origin.x > leftWidth * 1.5 && isViewAdd != .right
            }else{  //오른쪽 view
//                superView?.bringSubviewToFront(hiddenRightView)
                isClamp = frame.origin.x < -rightWidth * 1.2 && isViewAdd != .left
            }
        }
        if recognizer.state == .ended {
            if !isClamp {
                cellWillMoveOriginalPosition()
            }else{
                guard let indexPath = getCellIndexPath() else{
                    fatalError("indexPath casting error")
                }
                delegate?.cellWillClamp(indexPath)
                
                let clampFrame : CGRect!
                if(frame.origin.x < 0){
                    clampFrame = CGRect(x: -rightWidth, y: frame.origin.y,
                                            width: bounds.size.width, height: bounds.size.height)
                    superView?.bringSubviewToFront(hiddenRightView)
                    UIView.animate(withDuration: 0.32, animations: {self.frame = clampFrame})
                }else{
                    clampFrame = CGRect(x: leftWidth, y: frame.origin.y,
                                                width: bounds.size.width, height: bounds.size.height)
                    superView?.bringSubviewToFront(hiddenLeftView)
                    UIView.animate(withDuration: 0.4, animations: {self.frame = clampFrame})
                }
                
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
    
    func moveBackHiddenView(){
        
        let superView = self.superview?.superview
        
        superView?.sendSubviewToBack(self.hiddenLeftView)
        superView?.sendSubviewToBack(self.hiddenRightView)
        superView?.sendSubviewToBack(self.hiddenView)
    }
    
    func removeHiddenViews(){
        
        hiddenView.removeFromSuperview()
        hiddenRightView.removeFromSuperview()
        hiddenLeftView.removeFromSuperview()
        
        isViewAdd = .none
    }
    
    func cellWillMoveOriginalPosition(){
        
        let originalFrame = CGRect(x: 0, y: frame.origin.y,
                                   width: bounds.size.width, height: bounds.size.height)
        
        moveBackHiddenView()
        
        UIView.animate(withDuration: 0.25,
                       animations: { self.frame = originalFrame },
                       completion: { done in
            if(done){
                self.removeHiddenViews()
            }
        })
        
        isClamp = false
    }
    
}

//사용 확정 메서드 임시 모음
extension TodoListTableViewCell{
    
    func getCellIndexPath() -> IndexPath?{
        return (self.superview as? UITableView)?.indexPath(for: self)
    }
    
    func hiddenSettingViewShow(_ translation: CGFloat){

        if(isViewAdd == .none && !isClamp){
            
            isViewAdd = translation < 0 ? .right : .left
            
            self.superview?.superview?.addSubview(hiddenView)
            self.superview?.superview?.addSubview(hiddenRightView)
            self.superview?.superview?.addSubview(hiddenLeftView)
            
            
            self.superview?.superview?.sendSubviewToBack(hiddenRightView)
            self.superview?.superview?.sendSubviewToBack(hiddenLeftView)
            self.superview?.superview?.sendSubviewToBack(hiddenView)
            
            hiddenView.snp.makeConstraints{ make in
                make.leading.equalToSuperview().offset(32)
                make.trailing.equalToSuperview().offset(-30)
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView)
            }
            
            hiddenRightView.snp.makeConstraints{ make in
                make.trailing.equalToSuperview().offset(-30)
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView)
            }
            
            hiddenLeftView.snp.makeConstraints{ make in
                make.leading.equalToSuperview().offset(32)
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView)
            }
        }
    }
    
    @objc
    func checkBoxDidClicked(_ sender: UIButton){
        sender.isSelected.toggle()
    }
    
    @objc
    func settingButtonDidClicked(_ sender : UIButton){
        print("setting button did clicked")
        
        cellWillMoveOriginalPosition()
    }
    
    @objc
    func deleteButtonDidClicked(_ sender : UIButton){
        
        guard let indexPath = getCellIndexPath() else{
            fatalError("indexPath casting error")
        }

        cellWillMoveOriginalPosition()
        
        delegate?.cellWillDelete(indexPath)
    }
    
    @objc
    func pinButtonDidClicked(_ sender : UIButton){
        
        guard let indexPath = getCellIndexPath() else{
            fatalError("indexPath casting error")
        }
        
        cellWillMoveOriginalPosition()
        
        delegate?.cellWillPin(indexPath)
    }
    
    override func prepareForReuse() {
        pinImage.removeFromSuperview()
        alarmImage.removeFromSuperview()
        categoryButton.removeFromSuperview()
        titleLabel.text = ""
        timeLabel.text = ""
    }
}

protocol SelectedTableViewCellDeliver: AnyObject{
    func cellWillDelete(_ indexPath: IndexPath)
    func cellWillPin(_ indexPath: IndexPath)
    func cellWillMoveSettingVC()
    func cellWillClamp(_ indexPath: IndexPath)
}
