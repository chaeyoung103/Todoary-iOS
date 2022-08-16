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
import IRSticker_swift


class DiaryViewController : UIViewController , UIGestureRecognizerDelegate, IRStickerViewDelegate{
    
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
    
    var currentFont: DiaryFont = DiaryFont(fontName: .font1)
    
    var todoDataList : [GetTodoInfo]! = []
    
    var selectedSticker = false

    var animator: UIDynamicAnimator?
    
    //MARK: - UIComponenets


    var toolbar = DiaryToolbar().then{
        $0.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 92.0)
        $0.textBtn.addTarget(self, action: #selector(textBtnTab), for: .touchUpInside)
        $0.stickerBtn.addTarget(self, action: #selector(stickerBtnTab), for: .touchUpInside)
        $0.highlightBtn.addTarget(self, action: #selector(highlightBtnTab), for: .touchUpInside)
        $0.exitBtn.addTarget(self, action: #selector(exitBtnDidTab), for: .touchUpInside)
    }
    
    var DiarySticker = DiaryStickerView().then{
        $0.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 291)
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

        setUpView()
        setUpConstraint()
        
        configure()
        setupCollectionView()
        
        animator = UIDynamicAnimator.init(referenceView: view)
        
        setTextToolBarAction()
            
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - ToolbarBtnDidTab
    
    @objc func textBtnTab() {
        textView.inputView = nil
        textView.reloadInputViews()
    }
    
    @objc func stickerBtnTab() {
        textView.inputView = DiarySticker
        toolbar.textToolbar.isHidden = true
        toolbar.colorToolbar.isHidden = true
        textView.reloadInputViews()
        setupGestureRecognizerOnCollection()
    }
    
    @objc func highlightBtnTab() {
        textView.inputView = nil
        textView.reloadInputViews()
    }
    
    @objc func exitBtnDidTab() {
        toolbar.textToolbar.isHidden = true
        toolbar.fontToolbar.isHidden = true
        toolbar.colorToolbar.isHidden = true
        textView.inputView = nil
        textView.endEditing(true)
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
        DiaryTableView.showsVerticalScrollIndicator = false
        
        //cell 등록
        DiaryTableView.register(DiaryTabelViewCell.self, forCellReuseIdentifier: DiaryTabelViewCell.cellIdentifier)
    }
    
    //스티커뷰 선택 제스쳐
    func setupGestureRecognizerOnCollection() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapSticker(gestureRecognizer:)))
        tapGesture.delegate = self
        DiarySticker.collectionView?.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapSticker(gestureRecognizer: UIGestureRecognizer) {

        let p = gestureRecognizer.location(in: DiarySticker.collectionView)
        
        if let indexPath = DiarySticker.collectionView?.indexPathForItem(at: p) {
            
            let sticker1 = IRStickerView.init(frame: CGRect.init(x: 0, y: 0, width: 150, height: 150), contentImage: DiaryViewController.stickerData[indexPath.row]!)
            sticker1.center = self.view.center
            sticker1.enabledControl = false
            sticker1.enabledBorder = false
            sticker1.tag = 1
            sticker1.delegate = self
            self.textView.addSubview(sticker1)
            
            sticker1.performTapOperation()
        }
    }
    
    // MARK: - StickerViewDelegate
    func ir_StickerView(stickerView: IRStickerView, imageForRightTopControl recommendedSize: CGSize) -> UIImage? {
        return UIImage(named: "email")
    }
    
    func ir_StickerView(stickerView: IRStickerView, imageForLeftBottomControl recommendedSize: CGSize) -> UIImage? {
        return nil
    }
    
    func ir_StickerViewDidTapContentView(stickerView: IRStickerView) {
        if selectedSticker {
            stickerView.enabledBorder = false
            stickerView.enabledControl = false
            selectedSticker.toggle()
        }else{
            stickerView.enabledBorder = true
            stickerView.enabledControl = true
            selectedSticker.toggle()
        }
    }
    
}

//MARK: - Helpers_UITableViewDelegate, UITableViewDataSource

extension DiaryViewController: UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    func tableView(_ DiaryTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todoDataList.isEmpty{
            return 1
        }else {
            return todoDataList.count
        }
    }
    
    func tableView(_ DiaryTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = DiaryTableView.dequeueReusableCell(withIdentifier: DiaryTabelViewCell.cellIdentifier, for: indexPath) as? DiaryTabelViewCell else{
            fatalError()
        }
        
        if todoDataList.isEmpty{
            cell.titleLabel.text = "오늘은 투두가 없는 널널한 날이네요 *^^*"
            cell.titleLabel.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
            cell.categoryButton.isHidden = true
            cell.timeLabel.isHidden = true
        }else {
            cell.titleLabel.text = todoDataList[indexPath.row].title
            cell.timeLabel.text = todoDataList[indexPath.row].convertTime
            cell.checkBox.isSelected = todoDataList[indexPath.row].isChecked ?? false
            
            cell.categoryButton.setTitle(todoDataList[indexPath.row].categoryTitle, for: .normal)
            cell.categoryButton.layer.borderColor = UIColor.categoryColor[todoDataList[indexPath.row].color].cgColor
            cell.categoryButton.setTitleColor(UIColor.categoryColor[todoDataList[indexPath.row].color], for: .normal)
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

