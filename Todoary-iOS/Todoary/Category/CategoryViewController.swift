//
//  CategoryViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var navigationView : NavigationView!

    let trashButton = UIButton()
//        .then{
//    }

    var collectionView : UICollectionView!

    var tableView : UITableView!

    let todoAddBtn = UIButton()
//        .then{
//
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        navigationView = NavigationView(frame: .zero, self.navigationController!)

    }
    
    

}
