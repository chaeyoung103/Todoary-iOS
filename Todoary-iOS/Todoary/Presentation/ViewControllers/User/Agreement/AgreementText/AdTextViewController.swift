//
//  AdTextViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/04.
//

import Foundation
import UIKit
import SnapKit
import Then


//AdTextViewController
class AdTextViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    //navigationView
    let contentView = UIView().then{
        $0.backgroundColor = .white
        
    }
    
    var navigationView:NavigationView!
    
    //약관내용

    let contentScrollView = UIScrollView().then{
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
        $0.isScrollEnabled = true
        $0.indicatorStyle = .black
        $0.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -3)
    }
    
    let AdText = UILabel().then{
        $0.text = "1. 광고성 정보의 이용 \n - Todoary 사용자 분들이 유용하게 Todoary를 이용하실 수 있도록 사용자 맞춤형 서비스 및 상품 추천, 각종 경품 행사 및 이벤트 등의 광고성 정보를 전자우편 등을 통해 사용자에게 제공합니다. \n - 광고성 정보 수신 동의는 언제든지 거부하실 수 있으며 수신 동의 후에도 언제든지 동의를 철회할 수 있습니다.\n\n 2. 미동의 시 불이익 \n - 개인정보보호법 제 22조 제 5항에 의한 선택정보 사항 동의 거부에 따른 별도 서비스 이용 제한은 없습니다. 단 할인, 이벤트 및 맞춤형 상품 추천 등의 정보 안내가 제한됩니다. \n\n 3. 광고성 정보 수신 동의 철회 \n - Todoary가 제공하는 광고성 정보를 원하지 않을 경우 설정 > 약관 및 정책에서 철회를 요청할 수 있으며, 향후 광고성 정보 수신을 원하는 경우 동일한 화면에서 동의하실 수 있습니다."
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = .headline
        $0.labelTypeSetting(type: .acceptTerm)
    }

    override func viewDidLoad() {
    
        super.viewDidLoad()
        navigationView = NavigationView(frame: .zero , self.navigationController!).then{
            $0.navigationTitle.text = "광고성 정보 수신 동의"
        }

        setUpView()
        setUpConstraint()
    }
    
    @objc func backBtnDidTab() {
        self.navigationController?.popViewController(animated: true)
        }

}
