//
//  DiaryView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

class DiaryView: UIView {
    
    let backView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    
    let diaryTitle = UILabel().then{
        $0.font = UIFont.nbFont(ofSize: 13, weight: .extraBold)
        $0.text = "(제목)"
        $0.textColor = .black
        $0.numberOfLines = 1
        $0.addLetterSpacing(spacing: 0.26)
    }
    
    let diaryTextView = UILabel().then{
        $0.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elitut aliquam, purus sit amet luctus venenatis, lectusmagna fringilla urna, porttitor rhoncus dolor purusnon enim praesent elementum facilisis leo, vel fringilla est ullamcorper eget nulla facilisi etiam ... (본문)"
        $0.numberOfLines = 0
        $0.font = UIFont.nbFont(ofSize: 12, weight: .medium)
        $0.addLetterSpacing(spacing: 0.24)
        $0.setTextWithLineHeight(lineHeight: 14.4)
        
    }
    
    lazy var diaryImage = UIImageView().then{
        $0.backgroundColor = .silver_115
    }
    
    //image 등록 여부에 따른 view 구성 differ
    let isImageExist = true
    
    override init(frame: CGRect) {
        
        super.init(frame: .zero)
        
        setUpView()
        setUpConstraint()
        
        if(isImageExist){
            imageViewSetting()
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        self.addSubview(backView)
        
        backView.addSubview(diaryTitle)
        backView.addSubview(diaryTextView)
    }
    
    func setUpConstraint(){
        
        backView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(diaryTextView.snp.height).offset(63)
        }
        
        diaryTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(23)
        }
        
        diaryTextView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(diaryTitle.snp.bottom).offset(1)
            make.bottom.equalToSuperview().offset(-23)
        }
    }
    
    func imageViewSetting(){
        
        backView.addSubview(diaryImage)
        
        backView.snp.updateConstraints{ make in
            make.height.equalTo(diaryTextView.snp.height).offset(175)
        }
        
        diaryTextView.snp.remakeConstraints{ make in
            make.leading.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(diaryTitle.snp.bottom).offset(1)
            make.bottom.equalTo(diaryImage.snp.top).offset(-15)
        }
        
        diaryImage.snp.makeConstraints{ make in
            make.width.equalTo(166)
            make.height.equalTo(104)
            make.top.equalTo(diaryTextView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
    }

}
