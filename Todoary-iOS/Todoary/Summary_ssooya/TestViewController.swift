//
//  TestViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

class TestViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        show()
        
    }
    
    func show(){
        
        let viewControllerToPresent = TodoListBottomSheetViewController()
        
        viewControllerToPresent.loadViewIfNeeded()
        present(viewControllerToPresent, animated: true, completion: nil)
    }

}
