//
//  CalendarCell.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/17.
//

import UIKit

class CalendarCell : UICollectionViewCell {
    
    override var isSelected: Bool{
            didSet{
                if isSelected{
                    dateLabel.layer.backgroundColor = UIColor.calendarSelectColor.cgColor
                    dateLabel.textColor = .white
                    dateLabel.layer.shadowRadius = 4.0
                    dateLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
                    dateLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
                    dateLabel.layer.shadowOpacity = 1
                    dateLabel.layer.masksToBounds = false
                }
                else{
                    dateLabel.textAlignment = .center
                    dateLabel.textColor = .black
                    dateLabel.font = UIFont.nbFont(ofSize: 14, weight: .bold)
                    dateLabel.layer.backgroundColor = UIColor.calendarExistColor.cgColor
                    dateLabel.layer.cornerRadius = 12
                }
            }
        }
    
    let dateLabel = UILabel().then{
        $0.text = "월"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont.nbFont(ofSize: 14, weight: .bold)
        $0.layer.backgroundColor = UIColor.calendarExistColor.cgColor
        $0.layer.cornerRadius = 12
    }
    
    let diary = UIView().then{
        $0.isHidden = true
        $0.backgroundColor = UIColor(red: 95/255, green: 158/255, blue: 252/255, alpha: 1)
        $0.layer.cornerRadius = 7/2
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setUpView()
        setConstraint()
    }
    
    private func setUpView(){
        addSubview(dateLabel)
        addSubview(diary)
    }
    
    private func setConstraint() {
        dateLabel.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        diary.snp.makeConstraints{ make in
            make.centerX.equalTo(dateLabel)
            make.bottom.equalTo(dateLabel.snp.bottom).offset(-4)
            make.width.equalTo(7)
            make.height.equalTo(7)
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
