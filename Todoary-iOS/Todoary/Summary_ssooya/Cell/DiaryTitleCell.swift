//
//  DiaryTitleCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

class DiaryTitleCell: UITableViewCell {
    
    let backView = UIView().then{
        $0.backgroundColor = .transparent
    }
    
    let diaryTitle = PaddingLabel().then{
        $0.text = "DIARY"
        $0.font = UIFont.nbFont(ofSize: 12, weight: .extraBold)
        $0.textColor = .summaryTitle
        $0.addLetterSpacing(spacing: 0.24)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24/2
        $0.clipsToBounds = true

    }
    
    static let cellIdentifier = "diaryTitleCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .transparent
        
        //set view
        self.contentView.addSubview(backView)
        
        backView.addSubview(diaryTitle)
        
        //set constraint
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(60.5)
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        diaryTitle.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(35)
            make.top.equalToSuperview().offset(36.5)
            make.height.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
