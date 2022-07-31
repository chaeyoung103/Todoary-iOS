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

    var todoData: [GetTodoInfo]! = []
    
//    var categoryTitle = ["운동","대외활동","공부","가나다라마바"]
//    let categoryColor = [UIColor.category1, .category6, .category4, .category13]
    
    var categories : [GetCategoryResult] = []

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
        
        
        //1. category 조회
        GetCategoryDataManager().get(self)
        //2. category 조회 결과 통해 첫 번째 카테고리로 투두 조회
        
        print("third")
//        TodoGetByCategoryDataManager().get(viewController: self, categoryId: 29)

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

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("second")
        return todoData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row != tableView.numberOfRows(inSection: 0)-1){
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTodoTableViewCell.cellIdentifier) as? CategoryTodoTableViewCell else{
                fatalError()
            }
            let cellData = todoData[indexPath.row]
//            cell.todoTitle.text = cellData.title
//            cell.dateLabel.text = cellData.date
//            cell.timeLabel.text = cellData.time ?? ""
//            cell.alarmImage.isHidden = cellData.alarm ?? false
//            cell.setUpCategory(cellData.categories)
//            cell.setUpTimeStack()
            cell.settingTodoData(cellData)
            cell.navigation = self.navigationController
            cell.viewController = self
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

}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryButtonCollectionViewCell.cellIdentifier, for: indexPath) as? CategoryButtonCollectionViewCell else{
            fatalError()
        }
        
        let categoryData = categories[indexPath.row]
  
        cell.setBtnAttribute(title: categoryData.title, color: UIColor.categoryColor[categoryData.color])
//        cell.delegate = self
        cell.viewController = self
        
        if(indexPath.row == 0){
            cell.buttonIsSelected()
            currentCategory = cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let categoryTitle = categories[indexPath.row].title
        
        let tmpLabel = UILabel()
        tmpLabel.text = categoryTitle
        
        if(categoryTitle.count > 2){
            tmpLabel.then{
                $0.font = UIFont.nbFont(ofSize: 14, weight: .bold)
                $0.addLetterSpacing(spacing: 0.28)
            }
        }
        
        return CGSize(width: Int(tmpLabel.intrinsicContentSize.width+32), height: 26)
    }
    
}

//MARK: - API
extension CategoryViewController{
    
    func checkGetCategoryApiResultCode(_ result: [GetCategoryResult]){
        print("api end")
        self.categories = result
        collectionView.reloadData()
        
        print("category result")
        categories.forEach{ each in
            print(each)
        }
    }
    
    func checkGetTodoApiResultCode(_ result: GetTodoModel){
        switch result.code{
        case 1000:
//            cell.buttonIsSelected()
//            currentCategory.buttonIsNotSelected()
//            currentCategory.categoryBtn.isSelected = false
//            currentCategory = cell
            print("first")
            todoData = result.result
            tableView.reloadData()
            return
        default:
            return
        }
    }
    
    func checkGetTodoApiResultCode(_ cell: CategoryButtonCollectionViewCell, _ result: GetTodoModel){
        switch result.code{
        case 1000:
            cell.buttonIsSelected()
            currentCategory.buttonIsNotSelected()
            currentCategory.categoryBtn.isSelected = false
            currentCategory = cell

            todoData = result.result
            tableView.reloadData()
            return
        default:
            return
        }
    }
    
    func checkDeleteApiResultCode(code: Int, indexPath : IndexPath){
        switch code{
        case 1000:
            todoData.remove(at: indexPath.row)
            tableView.reloadData()
            return
        default:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
        }

    }
}
