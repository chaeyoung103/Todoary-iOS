//
//  DiaryTestViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/30.
//

import Foundation
import UIKit
import StickerView

class DiaryViewController: BaseViewController , UIGestureRecognizerDelegate{
    
    let mainView = DiaryView()
    
    //MARK: - StickerProperties
    
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
    
    var create : [Sticker] = []
    var modify : [Sticker] = []
    var delete : [Int] = []
    var createdApi : [CreatedDiarySticker] = []
    var modifiedApi : [ModifiedDiarySticker] = []
    var tag = 3000
    
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
    
    var DiarySticker = DiaryStickerView().then{
        $0.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 291)
        }
    
    let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    
    
    //MARK: - TextProperties
    
    var currentFont: DiaryFont = DiaryFont(fontName: .font1)
    
    var todoDataList : [GetTodoInfo]! = []
    
    var diaryData: GetDiaryInfo?
    
    var pickDate: ConvertDate?
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        DiaryDataManager().getDiarySticker(viewController: self, createdDate: self.pickDate!.dateSendServer)
    }
    
    override func style(){
        super.style()
        setRightButtonWithText("저장")
    }
    
    override func layout(){
        
        super.layout()
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func initialize() {
        rightButton.addTarget(self, action: #selector(registerBtnDidClicked), for: .touchUpInside)
        
        mainView.toolbar.cameraBtn.addTarget(self, action: #selector(cameraBtnTab), for: .touchUpInside)
        mainView.toolbar.textBtn.addTarget(self, action: #selector(textBtnTab), for: .touchUpInside)
        mainView.toolbar.stickerBtn.addTarget(self, action: #selector(stickerBtnTab), for: .touchUpInside)
        mainView.toolbar.highlightBtn.addTarget(self, action: #selector(highlightBtnTab), for: .touchUpInside)
        mainView.toolbar.exitBtn.addTarget(self, action: #selector(exitBtnDidTab), for: .touchUpInside)
        
        mainView.toolbar.yellowBtn.addTarget(self, action: #selector(yellowBtnDidClicked), for: .touchUpInside)
        mainView.toolbar.orangeBtn.addTarget(self, action: #selector(orangeBtnDidClicked), for: .touchUpInside)
        mainView.toolbar.redBtn.addTarget(self, action: #selector(redBtnDidClicked), for: .touchUpInside)
        mainView.toolbar.greenBtn.addTarget(self, action: #selector(greenBtnDidClicked), for: .touchUpInside)
        mainView.toolbar.blueBtn.addTarget(self, action: #selector(blueBtnDidClicked), for: .touchUpInside)
        mainView.toolbar.grayBtn.addTarget(self, action: #selector(grayBtnDidClicked), for: .touchUpInside)
        
        mainView.todoTableView.delegate = self
        mainView.todoTableView.dataSource = self
        mainView.todoTableView.separatorStyle = .none
        
        mainView.textView.delegate = self
        
        setTextToolBarAction()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.selectedStickerView = nil
    }
    
    @objc func registerBtnDidClicked(){
        checkTextValidationAndRequestApi()
        checkStickerStateAndRequestApi()
    }
}

