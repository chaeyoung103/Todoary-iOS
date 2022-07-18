//
//  InfoMessageView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/11.
//

import UIKit

class InfoMessageView: UIView {
    
    let silverView = UIView().then{
        $0.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.layer.shadowRadius = 5.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 1)
        $0.layer.shadowOpacity = 0.5
        $0.layer.masksToBounds = false
    }
    
    let messageLabel = UILabel().then{
        $0.font = UIFont.nbFont(ofSize: 11, weight: .semibold)
        $0.numberOfLines = 0
        $0.setTextWithLineHeight(lineHeight: 13.2)
        $0.addLetterSpacing(spacing: 0.22)
        $0.textColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.addSubview(silverView)
        self.addSubview(messageLabel)
        
        silverView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
