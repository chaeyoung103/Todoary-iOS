//
//  DiaryViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/30.
//

import Foundation
import UIKit
import SnapKit
import Then


class DiaryViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    //navigation bar
    var navigationView:NavigationView!
    
    private var DiaryTableView : DiaryTableView!
    
    //오늘 날짜
    let todaysDate = UILabel().then{
        //선택한 날짜 나오게 연결해주기
        $0.text = "2022.07.22"
        $0.font = UIFont.nbFont(ofSize: 16, weight: .bold)
        $0.addLetterSpacing(spacing: 0.32)
        $0.textColor = .black
    }
    
    //다이어리 제목
    let diaryTitle = UITextField().then{
        $0.placeholder = "오늘의 일기"
        $0.font = UIFont.nbFont(ofSize: 18, weight: .bold)
        $0.setPlaceholderColor(.black)
        $0.addLeftPadding(padding: 0)
        $0.addLetterSpacing(spacing: 0.32)
        $0.borderStyle = .none
    }
    
    
    let diaryLine =  UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    //다이어리 내용
    
    let textViewPlaceHolder = "오늘의 일기를 작성해보세요!"
    
    lazy var textView: UITextView = {
        
        let diaryText = UITextView()
        diaryText.text = textViewPlaceHolder
        diaryText.setTextWithLineHeight(spaing: 20)
        diaryText.textColor = .silver_225
        diaryText.font = UIFont.nbFont(ofSize: 15, weight: .medium)
        
        diaryText.delegate = self

        
        return diaryText
    }()
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationView = NavigationView(frame: .zero , self.navigationController!)
        
        setUpView()
        setUpConstraint()
        
        configure()
        setupCollectionView()
            
        }
    //MARK: - Helpers
    
    private func configure() {
        
        DiaryTableView = Todoary.DiaryTableView(frame: .zero)
        
        view.addSubview(DiaryTableView)

        DiaryTableView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(125)
                make.leading.equalToSuperview().offset(32)
                make.width.equalTo(387)
                make.height.equalTo(161)
                make.centerX.equalToSuperview()
           }
       }

    private func setupCollectionView() {
        DiaryTableView.delegate = self
        DiaryTableView.dataSource = self
        
        //cell 등록
        
        DiaryTableView.register(DiaryTabelViewCell.self, forCellReuseIdentifier: DiaryTabelViewCell.cellIdentifier)
    }
  
}


        //MARK: - Helpers_UITextViewDelegate

extension DiaryViewController: UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ DiaryTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ DiaryTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = DiaryTableView.dequeueReusableCell(withIdentifier: DiaryTabelViewCell.cellIdentifier, for: indexPath) as? DiaryTabelViewCell else{
            fatalError()
        }
        return cell
    }

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.setTextWithLineHeight(spaing: 20)
            textView.textColor = .black
            textView.font = UIFont.nbFont(ofSize: 15, weight: .medium)
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.setTextWithLineHeight(spaing: 20)
            textView.textColor = .silver_225
            textView.font = UIFont.nbFont(ofSize: 15, weight: .medium)
        }
    }
}

