//
//  AgreementViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/02.
//

import Foundation
import UIKit
import SnapKit
import Then

class AgreementViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    //navigationView
   // let agreeNavigationView = NavigationView().then {
       // $0.navigationTitle.text = "약관동의"
    //}

    //MARK: -  //텍스트

    let agreeTitle = UILabel().then{
        $0.text = "Todoary 서비스 이용약관에 동의해 주세요."
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
    }
    
    let allCheckText = UILabel().then{
        $0.text = "전체동의"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
    }
    
    //MARK: - //약관 제목버튼
    let privacyTitle = UIButton().then{
        $0.setTitle("개인 정보 취급방침 동의 (필수)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.setUnderline()
        $0.addTarget(self, action: #selector(privacyTitleDIdTab), for: .touchUpInside)
    }
    
    let useServiceTitle = UIButton().then{
        $0.setTitle("서비스 이용약관 동의 (필수)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.setUnderline()
    }
    
    let adTitle = UIButton().then{
        $0.setTitle("광고성 정보 수신 동의 (선택)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.titleLabel?.textAlignment = .left
        $0.setUnderline()
       // $0.addTarget(self, action: #selector(), for: .touchUpInside)
    }
    
    let locationTitle = UIButton().then{
        $0.setTitle("위치정보 이용 동의 (선택)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.titleLabel?.textAlignment = .left
        $0.setUnderline()
        $0.addTarget(self, action: #selector(allcheckBtndidnotcheck), for: .touchUpInside)
    }


    //MARK: - //약관 체크버튼
    
    let allCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .selected)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.addTarget(self, action: #selector(allcheckBtndidcheck), for: .touchUpInside)
    }
    
    let privacyCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .selected)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.addTarget(self, action: #selector(privacydidCheck), for: .touchUpInside)
        $0.addTarget(self, action: #selector(allcheckBtndidnotcheck), for: .touchUpInside)
        
    }
    
    let useServiceCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .selected)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.addTarget(self, action: #selector(useServicedidCheck), for: .touchUpInside)
        $0.addTarget(self, action: #selector(allcheckBtndidnotcheck), for: .touchUpInside)
    }
    
    let adCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .selected)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.addTarget(self, action: #selector(ADdidCheck), for: .touchUpInside)
        $0.addTarget(self, action: #selector(allcheckBtndidnotcheck), for: .touchUpInside)
    }
    
    let locationCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .selected)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.addTarget(self, action: #selector(locationdidCheck), for: .touchUpInside)
        $0.addTarget(self, action: #selector(allcheckBtndidnotcheck), for: .touchUpInside)
    }

    
    //MARK: - //BorderLine
    let privacyBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let useServiceBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let adBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let locationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let agreeAllBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    //MARK: -  //버튼
    let confirmBtn = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .buttonColor
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.cornerRadius = 52/2
    }
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setUpView()
        setUpConstraint()
    }
  
    //MARK: - checkBtndidCheck
    
    @objc func privacyTitleDIdTab() {
        let PrivacyTextViewController = PrivacyTextViewController()
        PrivacyTextViewController.modalTransitionStyle = .flipHorizontal
        PrivacyTextViewController.modalPresentationStyle = .fullScreen
        
           self.present(PrivacyTextViewController, animated: false, completion: nil)
       }
    
    
    //MARK: - checkBtndidCheck
    
    @objc func privacydidCheck() {
        if privacyCheckBtn.isSelected{ privacyCheckBtn.isSelected = false
            } else {privacyCheckBtn.isSelected = true}
    }
    
    @objc func useServicedidCheck() {
        if useServiceCheckBtn.isSelected{ useServiceCheckBtn.isSelected = false
            } else {useServiceCheckBtn.isSelected = true}
    }
        
    @objc func ADdidCheck() {
        if adCheckBtn.isSelected{ adCheckBtn.isSelected = false
            } else {adCheckBtn.isSelected = true}
    }
        
    @objc func locationdidCheck() {
        if locationCheckBtn.isSelected{ locationCheckBtn.isSelected = false
            } else {locationCheckBtn.isSelected = true}
    }
    
    @objc func allcheckBtndidcheck () {
        if allCheckBtn.isSelected {
            allCheckBtn.isSelected = false
            locationCheckBtn.isSelected = false
            adCheckBtn.isSelected = false
            useServiceCheckBtn.isSelected = false
            privacyCheckBtn.isSelected = false
        } else { allCheckBtn.isSelected = true
            allCheckBtn.isSelected = true
            locationCheckBtn.isSelected = true
            adCheckBtn.isSelected = true
            useServiceCheckBtn.isSelected = true
            privacyCheckBtn.isSelected = true}
        }
    
    @objc func allcheckBtndidnotcheck () {
        if locationCheckBtn.isSelected == true,
            adCheckBtn.isSelected == true,
            useServiceCheckBtn.isSelected == true,
            privacyCheckBtn.isSelected == true {
            allCheckBtn.isSelected = true
        } else { allCheckBtn.isSelected = false }
}
}

