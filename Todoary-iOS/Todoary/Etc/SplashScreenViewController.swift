//
//  SplashScreenViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/08/11.
//

import Foundation
import SnapKit
import UIKit
import Then

class SplashScreenViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    let appface = UIImageView().then{
//        $0.image = UIImage(named: <#T##String#>)
        $0.backgroundColor = .black
    }
    
    let apptitle = UIImageView().then{
        $0.image = UIImage(named: "home_apptitle")
    }
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        navigationView = NavigationView(frame: .zero , self.navigationController!)
        
        setUpView()
        setUpConstraint()
            
        }
}
