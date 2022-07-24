//
//  CategoryViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var navigationView : NavigationView!

    let trashButton = UIButton().then{
        $0.setImage(UIImage(named: "setting"), for: .normal)
    }

    var collectionView : UICollectionView!

    var tableView : UITableView!
    
    //dumy data
    
    let todoData = [
        CategoryTodo(categories: ["가나다라마바","가나다라마바","가나다라마바"], title: "운동", date: "7월 20일", time: "AM 7:00"),
        CategoryTodo(categories: ["운동"], title: "가나다라마바 사가나다라 마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사", date: "7월 20일", time: nil),
        CategoryTodo(categories: ["운동", "대외활동"], title: "베어랑 아침 산책 8시까지 만나기로함", date: "7월 20일", time: "AM 7:00"),
        CategoryTodo(categories: ["운동", "대외활동","공부"], title: "아침 산책", date: "7월 20일", time: nil),
        CategoryTodo(categories: [], title: "아침 산책", date: "7월 20일", time: nil)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        navigationView = NavigationView(frame: .zero, self.navigationController!)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 57, height: 26)
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

}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource{
    
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
            cell.setUpCategory(cellData.categories)
            cell.setUpTimeStack()
            return cell
        } else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewTodoAddBtnTableViewCell.cellIdentifier) as? NewTodoAddBtnTableViewCell else{
                fatalError()
            }
            return cell
        }
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryButtonCollectionViewCell.cellIdentifier, for: indexPath)
        return cell
    }
}


struct CategoryTodo{
    var categories : [String]
    var title : String?
    var date : String?
    var time : String?
}
