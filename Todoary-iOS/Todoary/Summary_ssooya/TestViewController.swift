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
        
//        if let sheet = viewControllerToPresent.sheetPresentationController {
//            sheet.detents = [.medium(),.large()]
//            sheet.largestUndimmedDetentIdentifier = .medium
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//            sheet.prefersEdgeAttachedInCompactHeight = true
//            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
//        }
        viewControllerToPresent.loadViewIfNeeded()
        present(viewControllerToPresent, animated: true, completion: nil)
    }

}
