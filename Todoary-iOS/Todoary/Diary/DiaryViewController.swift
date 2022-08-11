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
    
    static let stickerData = [UIImage(named: "sticker1"),
                               UIImage(named: "sticker2"),
                               UIImage(named: "sticker3"),
                               UIImage(named: "sticker4"),
                               UIImage(named: "sticker5"),
                               UIImage(named: "sticker6"),
                               UIImage(named: "sticker7"),
                               UIImage(named: "sticker8"),
                               UIImage(named: "sticker9"),
                               UIImage(named: "sticker10"),
                               UIImage(named: "sticker11"),
                               UIImage(named: "sticker12"),
                               UIImage(named: "sticker13"),
                               UIImage(named: "sticker14"),
                               UIImage(named: "sticker15"),
                               UIImage(named: "sticker16")]
    
    //MARK: - UIComponenets


    var toolbar = DiaryToolbar().then{
        $0.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 92.0)
        $0.stickerBtn.addTarget(self, action: #selector(stickerBtnDidTab), for: .touchUpInside)
    }
    
    var DiarySticker = DiaryStickerView().then{
        $0.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 406.0)
        }
    
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
        diaryText.setTextWithLineHeight(spaing: 25)
        diaryText.textColor = .silver_225
        diaryText.font = UIFont.nbFont(ofSize: 15, weight: .medium)
        
        diaryText.delegate = self
        

        return diaryText
    }()
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationView = NavigationView(frame: .zero , self.navigationController!)
        
        //tool바 넣어주기
        textView.inputAccessoryView = toolbar
        
        //Sticker뷰 넣어주기
//        textView.inputView = DiarySticker
//        DiarySticker.isHidden = true

        setUpView()
        setUpConstraint()
        
        configure()
        setupCollectionView()
        
        setTextToolBarAction()
            
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func stickerBtnDidTab() {
        print("ddd")
        textView.inputView = DiarySticker
        textView.reloadInputViews()
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
}
        //MARK: - Helpers_UITableViewDelegate, UITableViewDataSource

extension DiaryViewController: UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
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
            textView.setTextWithLineHeight(spaing: 25)
            textView.textColor = .black
            textView.font = UIFont.nbFont(ofSize: 15, weight: .medium)
        }
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y -= 275
        }
        
        diaryLine.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.setTextWithLineHeight(spaing: 25)
            textView.textColor = .silver_225
            textView.font = UIFont.nbFont(ofSize: 15, weight: .medium)
        }
    
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y = 0
        }
        
        diaryLine.isHidden = false
    }
}

