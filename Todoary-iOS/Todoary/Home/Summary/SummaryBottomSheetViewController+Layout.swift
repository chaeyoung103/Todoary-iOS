//
//  SummaryBottomSheetViewController+Layout.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/02.
//

import UIKit

extension SummaryBottomSheetViewController{
    
    func setUpView(){
        self.view.addSubview(sheetLine)
        self.view.addSubview(tableView)
        self.view.addSubview(addButton)
    }
    
    func setUpConstraint(){
        
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

extension SummaryBottomSheetViewController: UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let controller: UISheetPresentationController = .init(presentedViewController: presented, presenting: presenting)
        
        let detent1: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test1", constant: 325)
        let detent2: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test2", constant: 600)
        
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

