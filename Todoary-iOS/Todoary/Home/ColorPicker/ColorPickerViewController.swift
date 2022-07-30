//
//  ColorPickerViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class ColorPickerViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    private var ColorPickerCollectionViewCellid = "ColorPickerCollectionViewCellid"
    
    private var ColorPickerCollectionView: ColorPickerCollectionView!
    
    var allColor : [UIColor] = [.category1, .category2, .category3, .category4, .category5, .category6, .category7, .category8, .category9, .category10, .category11, .category12, .category13, .category14, .category15, .category16, .category17, .category18]

    var navigationView:NavigationView!
    
    let categoryTitle = UITextField().then{
        $0.placeholder = "카테고리 이름을 입력해주세요"
        $0.font = UIFont.nbFont(ofSize: 15, weight: .medium)
        $0.setPlaceholderColor(.black)
        $0.addLeftPadding(padding: 11)
        $0.borderStyle = .none
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.cornerRadius = 10
    }
    
    let deleteBtn = UIButton().then{
        $0.setImage(UIImage (named: "category_trash"), for: .normal)
    }
    
    let colorview = UIView().then{
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
    }
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        navigationView = NavigationView(frame: .zero , self.navigationController!)
        
        setUpView()
        setUpConstraint()
        
        configure()
        setupCollectionView()

        //바텀시트 테스트
//        let ColorPickerBottomsheetVC = ColorPickerBottomsheetViewController()
//        ColorPickerBottomsheetVC.modalPresentationStyle = .overFullScreen
//        self.present(ColorPickerBottomsheetVC, animated: false, completion: nil)
    }
    
    //MARK: - Helpers
    
    private func configure() {

           let collectionViewLayer = UICollectionViewFlowLayout()
           collectionViewLayer.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)

        ColorPickerCollectionView = Todoary.ColorPickerCollectionView(frame: .zero, collectionViewLayout: collectionViewLayer)
        ColorPickerCollectionView.isScrollEnabled = false
        
        view.addSubview(ColorPickerCollectionView)

            ColorPickerCollectionView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(208)
                make.leading.equalToSuperview().offset(50)
                make.width.equalTo(300)
                make.height.equalTo(150)
                make.centerX.equalToSuperview()
           }
       }

    
    private func setupCollectionView() {
        ColorPickerCollectionView.delegate = self
        ColorPickerCollectionView.dataSource = self
        
        //cell 등록
        ColorPickerCollectionView.register(ColorPickerCollectionViewCell.self, forCellWithReuseIdentifier: ColorPickerCollectionViewCellid)
        
    }
  
}



    //MARK: - UICollectionViewDataSource

extension ColorPickerViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ColorPickerCollectionViewCellid,
            for: indexPath) as? ColorPickerCollectionViewCell else {
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
