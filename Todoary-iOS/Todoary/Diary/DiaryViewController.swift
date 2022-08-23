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
import StickerView


class DiaryViewController : UIViewController , UIGestureRecognizerDelegate, StickerViewDelegate{
    
    
    
    //MARK: - Properties
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
    
    var diaryData: GetDiaryInfo?
    
    var pickDate: ConvertDate?
    
    var isEnterPressed = false
    
    var _selectedStickerView:StickerView?
        var selectedStickerView:StickerView? {
            get {
                return _selectedStickerView
            }
            set {
                // if other sticker choosed then resign the handler
                if _selectedStickerView != newValue {
                    if let selectedStickerView = _selectedStickerView {
                        selectedStickerView.showEditingHandlers = false
                    }
                    _selectedStickerView = newValue
                }
                // assign handler to new sticker added
                if let selectedStickerView = _selectedStickerView {
                    selectedStickerView.showEditingHandlers = true
                    selectedStickerView.superview?.bringSubviewToFront(selectedStickerView)
                }
            }
        }
    
    //MARK: - UIComponenets
    
    let registerBtn = UIButton().then{
        $0.setTitle("저장", for: .normal)
        $0.addLetterSpacing(spacing: 0.36)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 18, weight: .medium)
        $0.addTarget(self, action: #selector(registerBtnDidClicked), for: .touchUpInside)
    }


    var toolbar = DiaryToolbar().then{
        $0.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 92.0)
        $0.cameraBtn.addTarget(self, action: #selector(cameraBtnTab), for: .touchUpInside)
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
    
    //다이어리 제목
    let diaryTitle = UITextField().then{
        $0.placeholder = "오늘의 일기 제목"
        $0.font = UIFont.nbFont(ofSize: 18, weight: .bold)
        $0.setPlaceholderColor(.silver_225)
        $0.addLeftPadding(padding: 5.3)
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
        
        setTextToolBarAction()
        setHighlightToolBarAction()
            
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - ToolbarBtnDidTab
    
    @objc func cameraBtnTab() {
        
        textView.inputView = nil
        textView.endEditing(true)
        textView.reloadInputViews()
        
        let alert = UIAlertController(title: nil, message: "현재 제공하고 있지 않은 기능입니다.\n다음 업데이트에 만나요!", preferredStyle: .alert)

        let okBtn = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okBtn)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func textBtnTab() {
        textView.inputView = nil
        textView.reloadInputViews()
    }
    
    @objc func stickerBtnTab() {
        textView.inputView = DiarySticker
        toolbar.textToolbar.isHidden = true
        toolbar.colorToolbar.isHidden = true
        toolbar.fontToolbar.isHidden = true
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
    
    @objc
    func registerBtnDidClicked(){
        
        if(textView.text == textViewPlaceHolder || diaryTitle.text!.isEmpty){
            
            let alert = UIAlertController(title: nil, message: "다이어리 제목과 1자 이상의 내용 입력은 필수입니다.", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            
            alert.addAction(okBtn)
            
            self.present(alert, animated: true, completion: nil)
        }else{
            let text = NSAttributedString(attributedString: textView.attributedText)
            
            let input = DiaryInput(title: diaryTitle.text!,
                                   content: text.attributedString2Html!)
            
            DiaryDataManager().posts(viewController: self, createdDate: self.pickDate!.dateSendServer, parameter: input)
        }
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
            
            let testImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
            testImage.image = DiaryViewController.stickerData[indexPath.row]
            testImage.contentMode = .scaleAspectFit
            let stickerView = StickerView.init(contentView: testImage)
            stickerView.center = CGPoint.init(x: 150, y: 150)
            stickerView.delegate = self
            stickerView.setImage(UIImage.init(named: "close")!, forHandler: StickerViewHandler.close)
            stickerView.setImage(UIImage.init(named: "rotate")!, forHandler: StickerViewHandler.rotate)
            stickerView.setImage(UIImage.init(named: "flip")!, forHandler: StickerViewHandler.flip)
            stickerView.showEditingHandlers = false
            stickerView.layer.borderColor = UIColor(red: 134/255, green: 182/255, blue: 255/255, alpha: 1).cgColor
            stickerView.tag = 1
            self.textView.addSubview(stickerView)
            self.selectedStickerView = stickerView
        }
    }
    
    // MARK: - StickerViewDelegate
    
    func stickerViewDidTap(_ stickerView: StickerView) {
        if stickerView.showEditingHandlers == false {
            self.selectedStickerView = stickerView
            stickerView.showEditingHandlers = true
        }else {
            stickerView.showEditingHandlers = false
        }
    }
    func stickerViewDidChangeMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidBeginRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidChangeRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidBeginMoving(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidClose(_ stickerView: StickerView) {
        
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
            cell.categoryButton.snp.makeConstraints{ make in
                let offset = todoDataList[indexPath.row].categoryTitle.count == 5 ? 12 : 24
                make.width.equalTo(cell.categoryButton.titleLabel!).offset(offset)
            }
            cell.titleLabel.snp.makeConstraints{ make in
                make.trailing.equalToSuperview().offset(-145)
            }
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

