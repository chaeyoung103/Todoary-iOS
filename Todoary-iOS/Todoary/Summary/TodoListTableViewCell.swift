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
        $0.layer.borderWidth = 0.5
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
        
//        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
//        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
//        swipeGesture.delegate = self
//        backView.addGestureRecognizer(swipeGesture)
        
        
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
    
//    weak var delegate : MWSwipeableTableViewCellDelegate?
    
    var animationOptions : UIView.AnimationOptions = [.allowUserInteraction, .beginFromCurrentState]
    var animationDuration : TimeInterval = 0.5
    var animationDelay : TimeInterval = 0
    var animationSpingDamping : CGFloat = 0.5
    var animationInitialVelocity : CGFloat = 1
    
    private weak var leftWidthConstraint : NSLayoutConstraint!
    private weak var rightWidthConstraint : NSLayoutConstraint!
    
    var buttonWidth :CGFloat = 80 {
        didSet(val) {
            if let r = self.rightWidthConstraint {
                r.constant = self.buttonWidth
            }
            if let l = self.leftWidthConstraint {
                l.constant = self.buttonWidth
            }
        }
    }
    
    private weak var panRecognizer : UIPanGestureRecognizer!
    private weak var buttonCancelTap : UITapGestureRecognizer!
    
    private var beginPoint : CGPoint = .zero
    
    weak var rightButton : UIButton! {
        willSet(val) {
            if let r = self.rightButton {
                r.removeFromSuperview()
            }
            if let b = val {
                hiddenSettingViewShow()
//                self.addSubview(b)
//                b.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
//
//                b.translatesAutoresizingMaskIntoConstraints = false
//
//                self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[v]-(0)-|", options: [], metrics: nil, views: ["v":b]))
//                self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[v]-(0)-|", options: [], metrics: nil, views: ["v":b]))
//                let wc = NSLayoutConstraint(item: b, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.buttonWidth)
//                b.addConstraint(wc)
//                self.rightWidthConstraint = wc
//                self.sendSubviewToBack(b)
            }
        }
    }
    
    weak var leftButton : UIButton! {
        willSet(val) {
            if let l = self.leftButton {
                l.removeFromSuperview()
            }
            if let b = val {
                hiddenSettingViewShow()
//                self.addSubview(b)
//                b.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
//                b.translatesAutoresizingMaskIntoConstraints = false
//                self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[v]-(0)-|", options: [], metrics: nil, views: ["v":b]))
//                self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-(0)-[v]", options: [], metrics: nil, views: ["v":b]))
//                let wc = NSLayoutConstraint(item: b, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.buttonWidth)
//                b.addConstraint(wc)
//                self.leftWidthConstraint = wc
//                self.sendSubviewToBack(b)
            }
        }
    }
}

//protocol MWSwipeableTableViewCellDelegate : NSObjectProtocol {
//    func swipeableTableViewCellDidRecognizeSwipe(cell : TodoListTableViewCell)
//    func swipeableTableViewCellDidTapLeftButton(cell : TodoListTableViewCell)
//    func swipeableTableViewCellDidTapRightButton(cell : TodoListTableViewCell)
//}
//
//extension TodoListTableViewCell{
    
//    weak var delegate : MWSwipeableTableViewCellDelegate?
//
//    var animationOptions : UIView.AnimationOptions = [.allowUserInteraction, .beginFromCurrentState]
//    var animationDuration : TimeInterval = 0.5
//    var animationDelay : TimeInterval = 0
//    var animationSpingDamping : CGFloat = 0.5
//    var animationInitialVelocity : CGFloat = 1
//
//    private weak var leftWidthConstraint : NSLayoutConstraint!
//    private weak var rightWidthConstraint : NSLayoutConstraint!
//
//    var buttonWidth :CGFloat = 80 {
//        didSet(val) {
//            if let r = self.rightWidthConstraint {
//                r.constant = self.buttonWidth
//            }
//            if let l = self.leftWidthConstraint {
//                l.constant = self.buttonWidth
//            }
//        }
//    }
//
//    private weak var panRecognizer : UIPanGestureRecognizer!
//    private weak var buttonCancelTap : UITapGestureRecognizer!
//
//    private var beginPoint : CGPoint = CGPointZero
//
//    weak var rightButton : UIButton! {
//        willSet(val) {
//            if let r = self.rightButton {
//                r.removeFromSuperview()
//            }
//            if let b = val {
//                self.addSubview(b)
//                b.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
//                b.translatesAutoresizingMaskIntoConstraints = false
//                self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[v]-(0)-|", options: [], metrics: nil, views: ["v":b]))
//                self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[v]-(0)-|", options: [], metrics: nil, views: ["v":b]))
//                let wc = NSLayoutConstraint(item: b, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.buttonWidth)
//                b.addConstraint(wc)
//                self.rightWidthConstraint = wc
//                self.sendSubviewToBack(b)
//            }
//        }
//    }
//
//    weak var leftButton : UIButton! {
//        willSet(val) {
//            if let l = self.leftButton {
//                l.removeFromSuperview()
//            }
//            if let b = val {
//                self.addSubview(b)
//                b.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
//                b.translatesAutoresizingMaskIntoConstraints = false
//                self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[v]-(0)-|", options: [], metrics: nil, views: ["v":b]))
//                self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-(0)-[v]", options: [], metrics: nil, views: ["v":b]))
//                let wc = NSLayoutConstraint(item: b, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.buttonWidth)
//                b.addConstraint(wc)
//                self.leftWidthConstraint = wc
//                self.sendSubviewToBack(b)
//            }
//        }
//    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        commonInit()
//    }
    
//    private func commonInit() {
//
//        let pan = UIPanGestureRecognizer(target: self, action: "didPan:")
//        pan.delegate = self
//        self.addGestureRecognizer(pan)
//        self.panRecognizer = pan
//
//        let tap = UITapGestureRecognizer(target: self, action: "didTap:")
//        tap.delegate = self
//        self.addGestureRecognizer(tap)
//        self.buttonCancelTap = tap
//
//        self.contentView.backgroundColor = UIColor.clearColor()
//    }
    
    
//    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if let tap = gestureRecognizer as? UITapGestureRecognizer {
//            if tap == self.buttonCancelTap {
//                return self.contentView.frame.origin.x != 0
//            }
//            else {
//                return super.gestureRecognizerShouldBegin(gestureRecognizer)
//            }
//        }
//        else if let pan = gestureRecognizer as? UIPanGestureRecognizer {
//            let trans = pan.translation(in: self)
//            if abs(trans.x) > abs(trans.y) {
//                return true
//            }
//            else if self.contentView.frame.origin.x != 0 {
//                return true
//            }
//            else {
//                return false
//            }
//        }
//        else {
//            return super.gestureRecognizerShouldBegin(gestureRecognizer)
//        }
//    }
//
//    @objc
//    func didTap(sender : UITapGestureRecognizer) {
//        UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, usingSpringWithDamping: self.animationSpingDamping, initialSpringVelocity: self.animationInitialVelocity, options: self.animationOptions, animations: { () -> Void in
//            self.contentView.frame.origin.x = 0
//        }, completion: nil)
//    }
//
//    @objc func didPan(sender: UIPanGestureRecognizer) {
//        switch sender.state {
//        case .began:
////            hiddenSettingViewShow()
//            self.delegate?.swipeableTableViewCellDidRecognizeSwipe(cell: self)
//            self.beginPoint = sender.location(in: self)
//            self.beginPoint.x -= self.contentView.frame.origin.x
//
//        case .changed:
//            let now = sender.location(in: self)
//            let distX = now.x - self.beginPoint.x
//            if distX <= 0 {
//                let d = max(distX,-(self.contentView.frame.size.width-self.buttonWidth))
//                if d > -self.buttonWidth*2 || self.rightButton != nil || self.contentView.frame.origin.x > 0 {
//                    self.contentView.frame.origin.x = d
//                }
//                else {
//                    sender.isEnabled = false
//                    sender.isEnabled = true
//                }
//            }
//            else {
//                let d = min(distX,self.contentView.frame.size.width-self.buttonWidth)
//                if d < self.buttonWidth*2 || self.leftButton != nil || self.contentView.frame.origin.x < 0 {
//                    self.contentView.frame.origin.x = d
//                }
//                else {
//                    sender.isEnabled = false
//                    sender.isEnabled = true
//                }
//            }
//
//        default:
//            delegate?.swipeableTableViewCellDidRecognizeSwipe(cell: self)
//            let offset = self.contentView.frame.origin.x
//            if offset > self.buttonWidth && self.leftButton != nil {
//                UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, usingSpringWithDamping: self.animationSpingDamping, initialSpringVelocity: self.animationInitialVelocity, options: self.animationOptions, animations: { () -> Void in
//                    self.contentView.frame.origin.x = self.buttonWidth
//                }, completion: nil)
//            }
//            else if -offset > self.buttonWidth && self.rightButton != nil {
//                UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, usingSpringWithDamping: self.animationSpingDamping, initialSpringVelocity: self.animationInitialVelocity, options: self.animationOptions, animations: { () -> Void in
//                    self.contentView.frame.origin.x = -self.buttonWidth
//                }, completion: nil)
//            }
//            else {
//                UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, usingSpringWithDamping: self.animationSpingDamping, initialSpringVelocity: self.animationInitialVelocity, options: self.animationOptions, animations: { () -> Void in
//                    self.contentView.frame.origin.x = 0
//                }, completion: nil)
//            }
//        }
//    }
//
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
//
//    func didTapButton(sender:UIButton!) {
//        if let d = delegate {
//            if let l = self.leftButton {
//                if sender == l {
//                    d.swipeableTableViewCellDidTapLeftButton(cell: self)
//                }
//            }
//            if let r = self.rightButton {
//                if sender == r {
//                    d.swipeableTableViewCellDidTapRightButton(cell: self)
//                }
//            }
//        }
//        self.closeButtonsIfShown(animated: false)
//    }
//
//    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        let showing = self.contentView.frame.origin.x != 0
//        if !showing {
//            super.setHighlighted(highlighted, animated: animated)
//            self.rightButton?.alpha = showing || !highlighted ? 1 : 0
//            self.leftButton?.alpha = showing || !highlighted ? 1 : 0
//        }
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        let showing = self.contentView.frame.origin.x != 0
//        if !showing {
//            super.setSelected(selected, animated: animated)
//            self.rightButton?.alpha = showing || !selected ? 1 : 0
//            self.leftButton?.alpha = showing || !selected ? 1 : 0
//        }
//    }
//}


extension TodoListTableViewCell{

//    @objc
//    func handlePan(_ recognizer: UIPanGestureRecognizer){
//
//        if(recognizer.state == .began){
//            originalCenter = center
//            hiddenSettingViewShow()
//        }
//        if (recognizer.state == .changed){
//            let translation = recognizer.translation(in: self)
//            center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y)
//            // has the user dragged the item far enough to initiate a delete/complete?
//            deleteOnDragRelease = frame.origin.x < -frame.size.width / 4.0
//        }
//        if recognizer.state == .ended {
//          // the frame this cell had before user dragged it
//          let originalFrame = CGRect(x: 0, y: frame.origin.y,
//              width: bounds.size.width, height: bounds.size.height)
//          if !deleteOnDragRelease {
//            // if the item is not being deleted, snap back to the original location
//              UIView.animate(withDuration: 0.2, animations: {self.frame = originalFrame})
//          }
//        }
//    }
//
//    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//
//        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
//            let translation = panGestureRecognizer.translation(in: superview)
//            if abs(translation.x) > abs(translation.y) {
//                return true
//            }
//            return false
//        }
//        return false
//    }
    
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
