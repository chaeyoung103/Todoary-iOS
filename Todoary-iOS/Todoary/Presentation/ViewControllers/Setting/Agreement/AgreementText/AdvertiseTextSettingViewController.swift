//
//  AdvertiseTextSettingViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/08/12.
//

import Foundation
import UIKit
import SnapKit
import Then

class AdvertiseTextSettingViewController : BaseViewController {

    let mainView = AdvertiseTextSettingView()
    
    override func style(){
        super.style()
        navigationTitle.text = "광고성 정보 수신 동의"
    }
    
    override func layout() {
        
        super.layout()
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func initialize() {
        mainView.adCheckBtn.addTarget(self, action: #selector(advertiseButtonDidChecked), for: .touchUpInside)
    }
    
    @objc func advertiseButtonDidChecked() {
        AdDataManager().adDataManager(viewController: self, isChecked: mainView.adCheckBtn.isSelected == true)
        if mainView.adCheckBtn.isSelected { mainView.adCheckBtn.isSelected = false
        }else{ mainView.adCheckBtn.isSelected = true}
    }
    
    func checkAdagreement(_ code: Int){
        switch code{
        case 1000:
            print("광고성 동의 체크")
            return
        default:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: {
                self.mainView.adCheckBtn.isSelected = (!self.mainView.adCheckBtn.isSelected == true)
            })
        }
    }
}
