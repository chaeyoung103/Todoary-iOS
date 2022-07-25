//
//  CategoryViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var navigationView : NavigationView!

    lazy var trashButton = UIButton().then{
        $0.setImage(UIImage(named: "category_trash"), for: .normal)
        $0.addTarget(self, action: #selector(trashButtonDidClicked), for: .touchUpInside)
    }

    var collectionView : UICollectionView!

    var tableView : UITableView!
    
    var isEditingMode = false
    
    var currentCategory : CategoryButtonCollectionViewCell!

    
    //dumy data
    
    var todoData = [
        CategoryTodo(categories: ["가나다라마바":.category1,"가다다라마바":.category8,"가라다라마바":.category5], title: "운동", date: "7월 20일", time: "AM 7:00", alarm: true),
        CategoryTodo(categories: ["운동":.category13], title: "가나다라마바 사가나다라 마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사", date: "7월 20일", time: nil, alarm: nil),
        CategoryTodo(categories: ["운동":.category6, "대외활동":.category1], title: "베어랑 아침 산책 8시까지 만나기로함", date: "7월 20일", time: "AM 7:00", alarm: false),
        CategoryTodo(categories: ["운동":.category8, "대외활동":.category3,"공부":.category6], title: "아침 산책", date: "7월 20일", time: nil, alarm: nil),
        CategoryTodo(categories: [:], title: "아침 산책", date: "7월 20일", time: nil, alarm: nil)
    ]

    
    let categoryTitle = ["운동","대외활동","공부","가나다라마바"]
    let categoryColor = [UIColor.category1, .category6, .category4, .category13]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isHidden = true
        
        navigationView = NavigationView(frame: .zero, self.navigationController!)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = CGFloat(8)
        
        collectionView = UICollectionView(frame: .init(), collectionViewLayout: flowLayout).then{
            $0.delegate = self
            $0.dataSource = self

            $0.register(CategoryButtonCollectionViewCell.self, forCellWithReuseIdentifier: CategoryButtonCollectionViewCell.cellIdentifier)
        }
        
        tableView = UITableView().then{
            $0.delegate = self
            $0.dataSource = self
            
            $0.separatorStyle = .none
            $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            $0.register(CategoryTodoTableViewCell.self, forCellReuseIdentifier: CategoryTodoTableViewCell.cellIdentifier)
            $0.register(NewTodoAddBtnTableViewCell.self, forCellReuseIdentifier: NewTodoAddBtnTableViewCell.cellIdentifier)
            
        }
        
        setUpView()
        setUpConstraint()

    }
    
    @objc
    func trashButtonDidClicked(){
        
        let leading: Int!
        let trailing: Int!
        
        if(isEditingMode){
            leading = 32
            trailing = -30
        }else{
            leading = 58
            trailing = -4
        }
        
        var i = 0
        while(i < todoData.count){
            guard let cell = tableView.cellForRow(at: [0,i]) as? CategoryTodoTableViewCell else{
                fatalError()
            }
            cell.contentView.snp.updateConstraints{ make in
                make.leading.equalToSuperview().offset(leading)
                make.trailing.equalToSuperview().offset(trailing)
            }
            cell.deleteButton.isHidden.toggle()
            i = i + 1
        }
        isEditingMode.toggle()
    }

}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource, TableViewEditModeProtocol{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row != tableView.numberOfRows(inSection: 0)-1){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTodoTableViewCell.cellIdentifier) as? CategoryTodoTableViewCell else{
                fatalError()
            }
            let cellData = todoData[indexPath.row]
            cell.todoTitle.text = cellData.title
            cell.dateLabel.text = cellData.date
            cell.timeLabel.text = cellData.time ?? ""
            cell.alarmImage.isHidden = cellData.alarm ?? false
            cell.setUpCategory(cellData.categories)
            cell.setUpTimeStack()
            cell.delegate = self
            return cell
        } else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewTodoAddBtnTableViewCell.cellIdentifier) as? NewTodoAddBtnTableViewCell else{
                fatalError()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(indexPath.row == todoData.count){
            return false
        }else{
            return true
        }
    }
    
    func deleteBtnDidClicked(indexPath : IndexPath){
        todoData.remove(at: indexPath.row)
        tableView.reloadData()
    }

}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CategoryButtonSelect{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryTitle.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryButtonCollectionViewCell.cellIdentifier, for: indexPath) as? CategoryButtonCollectionViewCell else{
            fatalError()
        }
        
        cell.setBtnAttribute(title: categoryTitle[indexPath.row], color: categoryColor[indexPath.row])
        cell.delegate = self
        
        if(indexPath.row == 0){
            cell.buttonIsSelected()
            currentCategory = cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tmpLabel = UILabel()
        tmpLabel.text = categoryTitle[indexPath.row]
        
        if(categoryTitle[indexPath.row].count > 2){
            tmpLabel.then{
                $0.font = UIFont.nbFont(ofSize: 14, weight: .bold)
                $0.addLetterSpacing(spacing: 0.28)
            }
        }
        
        return CGSize(width: Int(tmpLabel.intrinsicContentSize.width+32), height: 26)
    }
    
    func newCategoryDidSelected(cell: CategoryButtonCollectionViewCell){
        currentCategory.buttonIsNotSelected()
        currentCategory.categoryBtn.isSelected = false
        currentCategory = cell
    }
    
}


struct CategoryTodo{
    var categories : [String:UIColor]
    var title : String?
    var date : String?
    var time : String?
    var alarm : Bool?
}
