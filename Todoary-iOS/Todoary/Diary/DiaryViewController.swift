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
    
    let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    //navigation bar
    var navigationView:NavigationView!
    
    private var DiaryTableView : DiaryTableView!
    
    //오늘 날짜
    let todaysDate = UILabel().then{
        $0.font = UIFont.nbFont(ofSize: 16, weight: .bold)
        $0.addLetterSpacing(spacing: 0.32)
        $0.textColor = .black
    }
    
    var sendApiDate: String!
    
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
    
    let firstToolBar = UIToolbar().then{
        $0.backgroundColor = .gray
        $0.sizeToFit()
        let cameraBtn = UIBarButtonItem(image: UIImage(named: "camera"), style: .plain, target: self, action: #selector(toolBarBtnDidTab))
        cameraBtn.tintColor = .black
        
        let textBtn = UIBarButtonItem(image: UIImage(named: "type"), style: .plain, target: self, action: #selector(toolBarBtnDidTab))
        textBtn.tintColor = .black
        
        let stickerBtn = UIBarButtonItem(image: UIImage(named: "smile"), style: .plain, target: self, action: #selector(toolBarBtnDidTab))
        stickerBtn.tintColor = .black
        
        let highlightBtn = UIBarButtonItem(image: UIImage(named: "edit"), style: .plain, target: self, action: #selector(toolBarBtnDidTab))
        highlightBtn.tintColor = .black
        
        let exitBtn = UIBarButtonItem(image: UIImage(named: "x"), style: .plain, target: self, action: #selector(toolBarBtnDidTab))
        exitBtn.tintColor = .black
        
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let edgeSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        edgeSpace.width = 15
        
        $0.setItems([edgeSpace, cameraBtn, space, textBtn, space, stickerBtn,space, highlightBtn,space, exitBtn, edgeSpace], animated: true)
        $0.isUserInteractionEnabled = true
        
    }
    
    let secondToolBar = UIToolbar().then{
        $0.backgroundColor = .gray
        $0.sizeToFit()
    }
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationView = NavigationView(frame: .zero , self.navigationController!)
        //tool바 넣어주기
        textView.inputAccessoryView = firstToolBar
//        firstToolBar.inputView = secondToolBar
        
        setUpView()
        setUpConstraint()
        
        configure()
        setupCollectionView()
            
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Helpers
    
    private func configure() {
        
        DiaryTableView = Todoary.DiaryTableView(frame: .zero)
        DiaryTableView.separatorStyle = .none
        
        view.addSubview(DiaryTableView)

        DiaryTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(131.5)
                make.leading.equalToSuperview()
                make.width.equalToSuperview()
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
    
    //MARK: - Actions
    @objc func toolBarBtnDidTab() {
        print("버튼 잘 눌림")
    }
}
        //MARK: - Helpers_UITableViewDelegate, UITableViewDataSource

extension DiaryViewController: UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ DiaryTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //그 날짜에 있는 todo 개수만큼으로 설정하기
        2
    }
    
    func tableView(_ DiaryTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = DiaryTableView.dequeueReusableCell(withIdentifier: DiaryTabelViewCell.cellIdentifier, for: indexPath) as? DiaryTabelViewCell else{
            fatalError()
        }
        return cell
    }

    //MARK: - Helpers_UITextViewDelegate
    
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


