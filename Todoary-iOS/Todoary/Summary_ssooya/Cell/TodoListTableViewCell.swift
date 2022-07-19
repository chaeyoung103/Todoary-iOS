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
    
    weak var cellDelegate : SelectedTableViewCellDeliver?
    
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
//    {
//        willSet(val){
//            if let l = self.hiddenView{
//                l.superview?.removeFromSuperview()
//                isViewAdd = false
//            }
//            if let b = val{
//
//                self.superview?.superview?.addSubview(b)
//                self.superview?.superview?.sendSubviewToBack(b)
//
//                b.snp.makeConstraints{ make in
//                    make.leading.equalToSuperview().offset(32)
//                    make.trailing.equalToSuperview().offset(-30)
//                    make.top.equalTo(self.contentView)
//                    make.bottom.equalTo(self.contentView)
//                }
//                                isViewAdd = true
//            }
//        }
//    }
    
    //MARK: - CellData
    var isPin : Bool!
    var isAlarm : Bool!
    var hasCategory : Bool!
    
    //MARK: - Properties
    
    var originalCenter = CGPoint()
    var deleteOnDragRelease = false
    
    //hiddenView addSubView 되었는지 아닌지 확인 용도
    var isViewAdd = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
     
        setUpView()
        setUpConstraint()
        
//        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        swipeGesture.delegate = self
        backView.addGestureRecognizer(swipeGesture)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func checkBoxDidClicked(_ sender: UIButton){
        
        sender.isSelected.toggle()
        /*
        if(sender.isSelected){

        }else{

        }
         */
    }
    
    weak var delegate : MWSwipeableTableViewCellDelegate?
    
    var animationOptions : UIView.AnimationOptions = [.allowUserInteraction, .beginFromCurrentState]
    var animationDuration : TimeInterval = 0.5
    var animationDelay : TimeInterval = 0
    var animationSpingDamping : CGFloat = 0.5
    var animationInitialVelocity : CGFloat = 1
    
    private weak var leftWidthConstraint : NSLayoutConstraint!
    private weak var rightWidthConstraint : NSLayoutConstraint!
    
//    var buttonWidth :CGFloat = 105 {
//        didSet(val) {
//            if let r = self.rightWidthConstraint {
//                r.constant = self.buttonWidth
//            }
//            if let l = self.leftWidthConstraint {
//                l.constant = self.buttonWidth
//            }
//        }
//    }
    
    let leftWidth : CGFloat = 90
    let rightWidth : CGFloat = 90
    
    private weak var panRecognizer : UIPanGestureRecognizer!
    private weak var buttonCancelTap : UITapGestureRecognizer!
    
    private var beginPoint : CGPoint = .zero

}

protocol MWSwipeableTableViewCellDelegate : NSObjectProtocol {
    func swipeableTableViewCellDidRecognizeSwipe(cell : TodoListTableViewCell)
    func swipeableTableViewCellDidTapLeftButton(cell : TodoListTableViewCell)
    func swipeableTableViewCellDidTapRightButton(cell : TodoListTableViewCell)
}

extension TodoListTableViewCell{


    @objc
    func didTap(_ sender : UITapGestureRecognizer) {
        UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, usingSpringWithDamping: self.animationSpingDamping, initialSpringVelocity: self.animationInitialVelocity, options: self.animationOptions, animations: { () -> Void in
            self.contentView.frame.origin.x = 0
        }, completion: nil)
    }
/*
    @objc func didPan(_ sender: UIPanGestureRecognizer) {

        switch sender.state {
        case .began:
            hiddenSettingViewShow()
            self.delegate?.swipeableTableViewCellDidRecognizeSwipe(cell: self)
            self.beginPoint = sender.location(in: self)
            self.beginPoint.x -= self.contentView.frame.origin.x

        case .changed:
            let now = sender.location(in: self)
            let distX = now.x - self.beginPoint.x

            if (distX <= 0) {
                print("right?")
                let d = max(distX,-(self.contentView.frame.size.width-self.rightWidth))

                if d > -self.rightWidth*2 || isViewAdd || self.contentView.frame.origin.x > 0 {
                    self.contentView.frame.origin.x = d
                }
                else {
                    sender.isEnabled = false
                    sender.isEnabled = true
                }
            }
            else {
                print("left?")
                let d = min(distX,self.contentView.frame.size.width-self.leftWidth)
                if d < self.leftWidth*2 || isViewAdd || self.contentView.frame.origin.x < 0 {
                    self.contentView.frame.origin.x = d
                }
                else {
                    sender.isEnabled = false
                    sender.isEnabled = true
                }
            }

        default:
            delegate?.swipeableTableViewCellDidRecognizeSwipe(cell: self)
            let offset = self.contentView.frame.origin.x

            if offset > self.leftWidth && isViewAdd {
                UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, usingSpringWithDamping: self.animationSpingDamping, initialSpringVelocity: self.animationInitialVelocity, options: self.animationOptions, animations: { () -> Void in
                    self.contentView.frame.origin.x = self.leftWidth
                }, completion: nil)
            }
            else if -offset > self.rightWidth && isViewAdd {
                UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, usingSpringWithDamping: self.animationSpingDamping, initialSpringVelocity: self.animationInitialVelocity, options: self.animationOptions, animations: { () -> Void in
                    self.contentView.frame.origin.x = -self.rightWidth
                }, completion: nil)
            }
            else {
                UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, usingSpringWithDamping: self.animationSpingDamping, initialSpringVelocity: self.animationInitialVelocity, options: self.animationOptions, animations: { () -> Void in
                    self.contentView.frame.origin.x = 0
                }, completion: nil)
            }
        }
    }
*/
    
    @objc func didPan(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            print("began")
            hiddenSettingViewShow()
            self.delegate?.swipeableTableViewCellDidRecognizeSwipe(cell: self)
            self.beginPoint = sender.location(in: self)
            self.beginPoint.x -= self.contentView.frame.origin.x

        case .changed:
            print("changed")
            let now = sender.location(in: self)
            print(now)
            let distX = now.x - self.beginPoint.x
//            let distX = translation.x
            print(distX)
            let transition = sender.translation(in: self).x
            
//            if (distX <= 0 ) {
            if (transition <= 0 ) {
                print("right?")
                let d = max(distX,-(self.contentView.frame.size.width-self.rightWidth ))
                print(d)
                print(self.contentView.frame.size.width-self.rightWidth)
                if d > -self.rightWidth*2 || hiddenView != nil || self.contentView.frame.origin.x > 0 {
                    print("right move?")
                    self.contentView.frame.origin.x = d
                }
                else {
                    print("stop?")
                    sender.isEnabled = false
                    sender.isEnabled = true
                }
            }
            else {
                print("left?")
                let d = min(distX,self.contentView.frame.size.width-self.leftWidth)
                print(d)
                print(self.contentView.frame.size.width-self.leftWidth)
                if d < self.leftWidth*2 || hiddenView != nil || self.contentView.frame.origin.x < 0 {
                    print("left move?")
                    self.contentView.frame.origin.x = d
                }
                else {
                    sender.isEnabled = false
                    sender.isEnabled = true
                }
            }

        default:
            print("end")
            delegate?.swipeableTableViewCellDidRecognizeSwipe(cell: self)
            let offset = self.contentView.frame.origin.x
            print(offset)
            if offset > self.leftWidth && isViewAdd {
                print("left end")
                UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, usingSpringWithDamping: self.animationSpingDamping, initialSpringVelocity: self.animationInitialVelocity, options: self.animationOptions, animations: { () -> Void in
                    self.contentView.frame.origin.x = self.leftWidth
                }, completion: nil)
            }
            else if -offset > self.rightWidth && isViewAdd {
                print("right end")
                UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, usingSpringWithDamping: self.animationSpingDamping, initialSpringVelocity: self.animationInitialVelocity, options: self.animationOptions, animations: { () -> Void in
                    self.contentView.frame.origin.x = -self.rightWidth
                }, completion: nil)
            }
            else {
                UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, usingSpringWithDamping: self.animationSpingDamping, initialSpringVelocity: self.animationInitialVelocity, options: self.animationOptions, animations: { () -> Void in
                    self.contentView.frame.origin.x = 0
                }, completion: nil)
            }
        }
    }
    
    
//    func closeButtonsIfShown(animated:Bool = true) -> Bool {
//        if self.contentView.frame.origin.x != 0 {
//            if animated {
//                UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, usingSpringWithDamping: self.animationSpingDamping, initialSpringVelocity: self.animationInitialVelocity, options: self.animationOptions, animations: { () -> Void in
//                    self.contentView.frame.origin.x = 0
//                    self.panRecognizer.isEnabled = false
//                    self.panRecognizer.isEnabled = true
//                }, completion: nil)
//            }
//            else {
//                self.contentView.frame.origin.x = 0
//                self.panRecognizer.isEnabled = false
//                self.panRecognizer.isEnabled = true
//
//            }
//            return true
//        }
//        else {
//            return false
//        }
//    }

//    @objc func didTapButton(_ sender:UIButton!) {
////        if let d = delegate {
////            if let l = self.leftButton {
////                if sender == l {
////                    print("left button clicked")
////                    d.swipeableTableViewCellDidTapLeftButton(cell: self)
////                }
////            }
////            if let r = self.rightButton {
////                if sender == r {
////                    print("right button clicked")
////                    d.swipeableTableViewCellDidTapRightButton(cell: self)
////                }
////            }
////        }
//        self.closeButtonsIfShown(animated: true)
//    }
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
            deleteOnDragRelease = frame.origin.x < -frame.size.width / 3.0
        }
        if recognizer.state == .ended {
          // the frame this cell had before user dragged it
          let originalFrame = CGRect(x: 0, y: frame.origin.y,
              width: bounds.size.width, height: bounds.size.height)
          if !deleteOnDragRelease {
            // if the item is not being deleted, snap back to the original location
              UIView.animate(withDuration: 0.4, animations: {self.frame = originalFrame})
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
    
}


//사용 확정 메서드 임시 모음
extension TodoListTableViewCell{
    
    func getCellIndexPath() -> IndexPath?{
        return (self.superview as? UITableView)?.indexPath(for: self)
    }

    func hiddenSettingViewShow(){

        if(!isViewAdd){
            
            self.superview?.superview?.addSubview(hiddenView)
            self.superview?.superview?.addSubview(hiddenLeftView)
            self.superview?.superview?.addSubview(hiddenRightView)
            
            self.superview?.superview?.sendSubviewToBack(hiddenLeftView)
            self.superview?.superview?.sendSubviewToBack(hiddenRightView)
            self.superview?.superview?.sendSubviewToBack(hiddenView)
            
            //if 고정되면, 버튼 2개만 front 함수 통해 앞으로 빼기 -> left, right에 따라 버튼 visibility 조절 필요
            self.superview?.superview?.bringSubviewToFront(hiddenRightView)
            self.superview?.superview?.bringSubviewToFront(hiddenLeftView)

            hiddenView.snp.makeConstraints{ make in
                make.leading.equalToSuperview().offset(32)
                make.trailing.equalToSuperview().offset(-30)
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView)
            }
            
            hiddenLeftView.snp.makeConstraints{ make in
                make.leading.equalToSuperview().offset(32)
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView)
            }
            
            hiddenRightView.snp.makeConstraints{ make in
                make.trailing.equalToSuperview().offset(-30)
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView)
            }

            isViewAdd = true
        }
    }
    
    @objc
    func settingButtonDidClicked(_ sender : UIButton){
        print("setting button did clicked")
    }
    
    @objc
    func deleteButtonDidClicked(_ sender : UIButton){
        
        hiddenView.removeFromSuperview()
        hiddenRightView.removeFromSuperview()
        hiddenLeftView.removeFromSuperview()
        isViewAdd = false
        
        guard let indexPath = getCellIndexPath() else{
            fatalError("indexPath casting error")
        }
        cellDelegate?.willDeleteCell(indexPath)
    }
    
    @objc
    func pinButtonDidClicked(_ sender : UIButton){
        
        hiddenView.removeFromSuperview()
        hiddenRightView.removeFromSuperview()
        hiddenLeftView.removeFromSuperview()
        isViewAdd = false
        
        guard let indexPath = getCellIndexPath() else{
            fatalError("indexPath casting error")
        }
        
        cellDelegate?.willPinCell(indexPath)
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
    func willDeleteCell(_ indexPath: IndexPath)
    func willPinCell(_ indexPath: IndexPath)
    func willMoveSettingCell()
}
