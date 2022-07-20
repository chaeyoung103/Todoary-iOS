//
//  TestViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

class TestViewController: UIViewController {
    
//    let button = UIButton().then{
//        $0.backgroundColor = .summaryTitle
//        $0.layer.cornerRadius = 70/2
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        show()
        
//        self.view.addSubview(button)
//
//        button.snp.makeConstraints{ make in
//            make.width.height.equalTo(70)
//            make.bottom.equalToSuperview().offset(-89)
//            make.trailing.equalToSuperview().offset(-27)
//        }
    }
    
    func show(){
        
        let viewControllerToPresent = TodoListBottomSheetViewController()
        
        viewControllerToPresent.loadViewIfNeeded()
        present(viewControllerToPresent, animated: true, completion: nil)
    }

}
