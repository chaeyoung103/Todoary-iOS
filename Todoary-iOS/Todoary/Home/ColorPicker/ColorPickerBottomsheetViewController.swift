//
//  ColorPickerBottomsheetViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/27.
//

import Foundation
import UIKit

class ColorPickerBottomsheetViewController : UIViewController {
    // MARK: - Properties

    //바텀시트 높이
    let bottomHeight : CGFloat = 342
    
    // bottomSheet가 view의 상단에서 떨어진 거리
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    private var ColorPickerBottomsheetCollectionViewcellid = "ColorPickerBottomsheetCollectionViewcellid"
    
    private var ColorPickerBottomsheetCollectionView: ColorPickerBottomsheetCollectionView!
    
    var allColor : [UIColor] = [.category1, .category2, .category3, .category4, .category5, .category6, .category7, .category8, .category9, .category10, .category11, .category12, .category13, .category14, .category15, .category16, .category17, .category18]
    
    // MARK: - UIComponents
    
    let dimmedBackView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    let bottomSheetView = UIView().then{
        $0.backgroundColor = .calendarSelectColor
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    let categoryTextField = UITextField().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
        $0.placeholder = "카테고리 이름을 입력해 주세요"
        $0.setPlaceholderColor(.black)
        $0.font = UIFont.nbFont(ofSize: 13, weight: .bold)
        $0.addLeftPadding()
        $0.textFieldTypeSetting(type: .tableCell)
        
        $0.snp.makeConstraints{ make in
            make.height.equalTo(46)
        }
    }
    
    let confirmBtn = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addLetterSpacing(spacing: 0.3)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    let deleteBtn = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addLetterSpacing(spacing: 0.3)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setupGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }
    
    // MARK: - Layout
    private func setUpView() {
        
        view.addSubview(dimmedBackView)
        view.addSubview(bottomSheetView)
        
        view.addSubview(categoryTextField)
        
        view.addSubview(confirmBtn)
        view.addSubview(deleteBtn)
        
        dimmedBackView.alpha = 0.0
        setUpConstraint()
        
        configure()
        setupCollectionView()
    }
    
    private func setUpConstraint() {
        dimmedBackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmedBackView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedBackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
            
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint
        ])
        
        categoryTextField.snp.makeConstraints{ make in
            make.top.equalTo(bottomSheetView.snp.top).offset(30)
            make.centerX.equalTo(bottomSheetView)
            make.width.equalTo(328)
            make.height.equalTo(46)
            
        }
        
        confirmBtn.snp.makeConstraints{ make in
            make.top.equalTo(bottomSheetView.snp.top).offset(270)
            make.leading.equalTo(bottomSheetView.snp.leading).offset(66)
            make.width.equalTo(93)
            make.height.equalTo(38)
            
        }
        
        deleteBtn.snp.makeConstraints{ make in
            make.top.equalTo(bottomSheetView.snp.top).offset(270)
            make.trailing.equalTo(bottomSheetView.snp.trailing).offset(-66)
            make.width.equalTo(93)
            make.height.equalTo(38)
        }
    }
    
    //MARK: - Actions

    
    //MARK: - Helpers_BottomSheet
    
    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.1
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 바텀 시트 사라지는 애니메이션
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    // GestureRecognizer 세팅 작업
    private func setupGestureRecognizer() {
        // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedBackView.addGestureRecognizer(dimmedTap)
        dimmedBackView.isUserInteractionEnabled = true
        
        // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    
    // UITapGestureRecognizer 연결 함수 부분
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    // UISwipeGestureRecognizer 연결 함수 부분
    @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .down:
                hideBottomSheetAndGoBack()
            default:
                break
            }
        }
    }
    
    //MARK: - Helpers_ColorPicker
    
    private func configure() {
        let collectionViewLayer = UICollectionViewFlowLayout()
        collectionViewLayer.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)

        ColorPickerBottomsheetCollectionView = Todoary.ColorPickerBottomsheetCollectionView(frame: .zero, collectionViewLayout: collectionViewLayer)
        ColorPickerBottomsheetCollectionView.isScrollEnabled = false
        ColorPickerBottomsheetCollectionView.backgroundColor = .transparent
        
        view.addSubview(ColorPickerBottomsheetCollectionView)

        ColorPickerBottomsheetCollectionView.snp.makeConstraints { make in
                make.top.equalTo(bottomSheetView).offset(102)
                make.leading.equalTo(bottomSheetView).offset(45)
                make.width.equalTo(290)
                make.height.equalTo(150)
                make.centerX.equalTo(bottomSheetView)
           }
       }

    
    private func setupCollectionView() {
        ColorPickerBottomsheetCollectionView.delegate = self
        ColorPickerBottomsheetCollectionView.dataSource = self
        
        //cell 등록
        ColorPickerBottomsheetCollectionView.register(ColorPickerCollectionViewCell.self, forCellWithReuseIdentifier: ColorPickerBottomsheetCollectionViewcellid)
        
    }
}

//MARK: - UICollectionViewDataSource



extension ColorPickerBottomsheetViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ColorPickerBottomsheetCollectionViewcellid, for : indexPath) as? ColorPickerCollectionViewCell else {
            fatalError("셀 타입 케스팅 실패")
        }
    
        cell.layer.cornerRadius = 30/2
        cell.backgroundColor = allColor[indexPath.row]
        cell.colorBtnpick.layer.borderColor = allColor[indexPath.row].cgColor
    
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(25)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(20)
    }



//MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at:indexPath) as? ColorPickerCollectionViewCell else{
        fatalError()
        }
        cell.colorBtnpick.isHidden = false
        cell.colorBtnpick.layer.borderWidth = 2
        cell.colorBtnpick.layer.cornerRadius = 40/2
        cell.colorBtnpick.isUserInteractionEnabled = true
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at:indexPath) as? ColorPickerCollectionViewCell else{
            fatalError()
        }
        cell.colorBtnpick.isHidden = true
        cell.colorBtnpick.layer.borderWidth = 2
        cell.colorBtnpick.layer.cornerRadius = 40/2
        cell.colorBtnpick.isUserInteractionEnabled = true
    }
}





