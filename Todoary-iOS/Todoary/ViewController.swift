//
//  ViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/01.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    
    let moveButton = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(moveButton)
        
        moveButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(100)
        }
    }


}

