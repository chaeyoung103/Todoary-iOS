//
//  SummaryBottomSheetViewController+Layout.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/02.
//

import UIKit

extension SummaryBottomViewController{
    
    func setUpView(){
        self.view.addSubview(sheetLine)
        self.view.addSubview(tableView)
        self.view.addSubview(addButton)
        
        self.view.addSubview(todoEasySettingView)
        self.view.addSubview(todoTf)
        self.view.addSubview(collectionView)
        self.view.bringSubviewToFront(collectionView)
    }
    
    func setUpConstraint(){
        
        todoEasySettingView.snp.makeConstraints{ make in
            make.height.equalTo(118)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        todoTf.snp.makeConstraints{ make in
            make.height.equalTo(45)
            make.top.equalTo(self.todoEasySettingView.snp.top).offset(17)
            make.leading.equalTo(todoEasySettingView).offset(32)
            make.trailing.equalTo(todoEasySettingView).offset(-31)
            make.bottom.equalTo(todoEasySettingView.snp.bottom).offset(-56)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.height.equalTo(26)
            make.top.equalTo(todoTf.snp.bottom).offset(14)
            make.leading.equalTo(todoEasySettingView).offset(32)
            make.trailing.equalTo(todoEasySettingView.snp.trailing)
            make.bottom.equalTo(todoEasySettingView.snp.bottom).offset(-16)
        }
        
        sheetLine.snp.makeConstraints{ make in
            make.width.equalTo(46)
            make.height.equalTo(5)
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(172)
            make.trailing.equalToSuperview().offset(-172)
        }
        
        tableView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
        
        addButton.snp.makeConstraints{ make in
            make.width.height.equalTo(70)
            make.bottom.equalToSuperview().offset(-52.52)
            make.trailing.equalToSuperview().offset(-27)
        }
    }
}

extension SummaryBottomViewController: UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let controller: UISheetPresentationController = .init(presentedViewController: presented, presenting: presenting)
        
        let height = UIScreen.main.bounds.size.height
        
        let detent1: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test1", constant: height - 519 - 41)
        let detent2: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test2", constant: height - 95 - 41 ) //790 - 41
        
        let detentIdentifier :UISheetPresentationController.Detent.Identifier = UISheetPresentationController.Detent.Identifier(rawValue: "Test2")
        
        controller.detents = [detent1, detent2]
        controller.preferredCornerRadius = 30
        controller.largestUndimmedDetentIdentifier = detentIdentifier
        controller.prefersScrollingExpandsWhenScrolledToEdge = false
        
        return controller
    }
    
    func setUpSheetVC(){
        isModalInPresentation = true
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
}

