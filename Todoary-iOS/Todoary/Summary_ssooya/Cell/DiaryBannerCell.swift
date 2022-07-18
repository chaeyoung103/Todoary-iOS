//
//  DiaryBannerCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

class DiaryBannerCell: UITableViewCell {
    
    static let cellIdentifier = "diaryBannerCell"
    
    let backView = UIView().then{
        $0.backgroundColor = .transparent
    }
    
    let writeDiaryBanner = PaddingLabel(padding: UIEdgeInsets(top: 16, left: 19, bottom: 17, right: 25)).then{
        $0.text = "오늘의 일기를 작성해주세요!"
        $0.font = UIFont.nbFont(ofSize: 13, weight: .extraBold)
        $0.addLetterSpacing(spacing: 0.26)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .transparent
        
        //set view
        self.contentView.addSubview(backView)
        
        backView.addSubview(writeDiaryBanner)
        
        //set constraint
        
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(62)
            make.width.equalToSuperview()
        }
        
        backView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        writeDiaryBanner.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
