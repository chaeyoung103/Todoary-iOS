//
//  CalendarCell.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/17.
//

import UIKit

class CalendarCell : UICollectionViewCell {
    
    let dateLabel = UILabel().then{
        $0.layer.backgroundColor = UIColor.calendarExistColor.cgColor
        $0.layer.cornerRadius = 12
        $0.text = "월"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont.nbFont(ofSize: 13, weight: .semibold)
        $0.addLetterSpacing(spacing: 0.26)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setUpView()
        setConstraint()
    }
    
    private func setUpView(){
        addSubview(dateLabel)
    }
    
    private func setConstraint() {
        dateLabel.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.equalTo(42)
            make.height.equalTo(42)
        }
      }
    
    required init?(coder: NSCoder) {
        fatalError("do not use in storyboard")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}
