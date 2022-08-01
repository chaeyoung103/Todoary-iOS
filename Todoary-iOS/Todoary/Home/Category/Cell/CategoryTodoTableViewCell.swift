//
//  CategoryTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

class CategoryTodoTableViewCell: UITableViewCell {

    static let cellIdentifier = "todoCell"
    
    var navigation: UINavigationController!
    
    var viewController: CategoryViewController!
    
    lazy var categoryLabel = UIButton().then{
        $0.titleEdgeInsets = UIEdgeInsets(top: 4, left: 11, bottom: 3, right: 11)
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 12, weight: .bold)
        $0.layer.cornerRadius = 21/2
    }
    
    lazy var checkBox = UIButton().then{
        $0.setImage(UIImage(named: "todo_check_empty"), for: .normal)
        $0.setImage(UIImage(named: "todo_check"), for: .selected)
        $0.addTarget(self, action: #selector(checkBoxDidClicked(_:)), for: .touchUpInside)
    }
    
    lazy var todoTitle = UILabel().then{
        $0.text  = "운동"
        $0.numberOfLines = 0
        $0.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.addLetterSpacing(spacing: 0.3)
        $0.setTextWithLineHeight(lineHeight: 22)
        $0.textColor = .black
        
    }
    
    let dateLabel = UILabel().then{
        $0.text = "7월 21일"
        $0.textAlignment = .right
        $0.font = UIFont.nbFont(ofSize: 13, weight: .medium)
        $0.textColor = .timeColor
    }
    
    lazy var timeLabel = UILabel().then{
        $0.text = "AM 7:00"
        $0.textAlignment = .right
        $0.textColor = .timeColor
        $0.font = UIFont.nbFont(ofSize: 13, weight: .medium)
    }
    
    lazy var alarmImage = UIImageView().then{
        $0.image = UIImage(named: "notifications")
        $0.isHidden = true
    }
    
    let timeView = UIView()
    
    let timeStack = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 7.86
    }
    
    let backView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowRadius = 7.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    let selectedView = UIView().then{
        $0.backgroundColor = .white
    }

    lazy var deleteButton = UIButton().then{
        $0.setImage(UIImage(named: "minus"), for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(deleteButtonDidClicked), for: .touchUpInside)
    }
    
    //MARK: - Properties
    
    var todoData: GetTodoInfo!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectedBackgroundView = selectedView
        
        setUpView()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func prepareForReuse() {
        
        todoTitle.text = ""
        dateLabel.text = ""
        timeLabel.text = ""
        
        alarmImage.isHidden = true
        
        timeView.removeFromSuperview()
        
        categoryLabel.setTitle("", for: .normal)
        categoryLabel.setTitleColor(.white, for: .normal)
        categoryLabel.layer.borderColor = UIColor.white.cgColor
    }
    
    func setUpView(){
        
        self.contentView.addSubview(backView)
        
        self.addSubview(deleteButton)
        
        backView.addSubview(categoryLabel)
        backView.addSubview(checkBox)
        backView.addSubview(todoTitle)
        backView.addSubview(timeStack)
        
        timeStack.addArrangedSubview(dateLabel)
    }
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(todoTitle.snp.height).offset(69+19)
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        categoryLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(19)
            make.top.equalToSuperview().offset(14)
            make.height.equalTo(21)
            make.width.equalTo(categoryLabel.titleLabel!).offset(22)
        }
        
        checkBox.snp.makeConstraints{ make in
            make.width.height.equalTo(22)
            make.top.equalTo(categoryLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(19)
        }
        
        todoTitle.snp.makeConstraints{ make in
            make.width.equalTo(177)
            make.top.equalTo(categoryLabel.snp.bottom).offset(14)
            make.bottom.equalToSuperview().offset(-19)
            make.leading.equalTo(checkBox.snp.trailing).offset(9)
        }
        
        timeStack.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-18)
            make.leading.equalTo(todoTitle.snp.trailing).offset(12)
            make.bottom.equalToSuperview().offset(-23)
        }
        
        dateLabel.snp.makeConstraints{ make in
            make.width.equalTo(71)
            make.height.equalTo(14.14)
        }
        
        deleteButton.snp.makeConstraints{ make in
            make.width.height.equalTo(22)
            make.leading.equalToSuperview().offset(17)
            make.centerY.equalTo(backView)
        }
        
    }
    
    func setUpTimeStack(){
        
        if(todoData.targetTime != nil){
            timeView.addSubview(timeLabel)
            timeView.addSubview(alarmImage)
            
            timeStack.addArrangedSubview(timeView)
            
            timeView.snp.makeConstraints{ make in
                make.width.equalTo(71)
                make.height.equalTo(14.14)
            }
            
            timeLabel.snp.makeConstraints{ make in
                make.top.bottom.leading.trailing.equalToSuperview()
            }
            
            alarmImage.snp.makeConstraints{ make in
                make.width.equalTo(14)
                make.height.equalTo(13.2)
                make.leading.equalToSuperview().offset(6)
                make.top.equalToSuperview()
            }
        }
        
    }
    
    func settingTodoData(_ cellData: GetTodoInfo){
        
        self.todoData = cellData
        
        self.todoTitle.text = self.todoData.title
        self.dateLabel.text = cellData.targetDate
        self.timeLabel.text = cellData.convertTime ?? ""
        self.alarmImage.isHidden = cellData.isAlarmEnabled
        self.setUpTimeStack()
        self.setCategoryData()
    }

    @objc
    func checkBoxDidClicked(_ sender: UIButton){
        let parameter = TodoCheckboxInput(todoId: todoData.todoId, isChecked: !sender.isSelected)
        print(parameter.todoId, parameter.isChecked)
        
        TodoCheckboxDataManager().patch(cell: self, parameter: parameter)
    }
    
    func checkSendCheckboxApiResultCode(_ code: Int){
        switch code{
        case 1000:
            print("성공")
            checkBox.isSelected.toggle()
            return
        default:
            let alert = DataBaseErrorAlert()
            navigation.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc
    func deleteButtonDidClicked(){
        
        guard let tableView = (self.superview as? UITableView) else{
            fatalError()
        }
        let indexPath = tableView.indexPath(for: self)!
        
        TodoDeleteDataManager().delete(viewController: self.viewController, todoId: todoData.todoId, indexPath: indexPath)
    }
    
    func setCategoryData(){
        
        let categoryData = todoData.categories[0]

        self.categoryLabel.setTitle(categoryData.title, for: .normal)
        self.categoryLabel.layer.borderColor = UIColor.categoryColor[categoryData.color].cgColor
        self.categoryLabel.setTitleColor( UIColor.categoryColor[categoryData.color], for: .normal)
    }
}

//class CategoryLabel: UIButton{
//
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//
//        setUpValue()
//        setUpConstraint()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setUpValue(){
//        self.setTitle("운동", for: .normal)
//        self.titleEdgeInsets = UIEdgeInsets(top: 4, left: 11, bottom: 3, right: 11)
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.category14.cgColor
//        self.setTitleColor(.category14, for: .normal)
//        self.titleLabel?.font = UIFont.nbFont(ofSize: 12, weight: .bold)
//        self.layer.cornerRadius = 21/2
//    }
//
//    func setUpConstraint(){
//        self.snp.makeConstraints{ make in
//            make.width.equalTo(self.titleLabel!).offset(22)
//            make.height.equalTo(21)
//        }
//    }
//}
