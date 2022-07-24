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
//    var ColorPickerCollectionView = UICollectionView().then{
//        $0.backgroundColor = .red
//    }
//
    
    let categoryTitle = UITextField().then{
        $0.placeholder = "카테고리 이름을 입력해주세요"
        $0.font = UIFont.nbFont(type: .tableCell)
        $0.addLeftPadding()
        $0.textFieldTypeSetting(type: .tableCell)
        $0.borderStyle = .none
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.cornerRadius = 10
    }
    
    let colorview = UIView().then{
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
    }
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        setUpView()
        setUpConstraint()
        
        configure()
        setupCollectionView()

    }
    //MARK: - Helpers
    
    private func configure() {

           let collectionViewLayer = UICollectionViewFlowLayout()
//           collectionViewLayer.sectionInset = UIEdgeInsets(top: 20, left: 23, bottom: 21, right: 23)
//           collectionViewLayer.minimumLineSpacing = 22
//           collectionViewLayer.minimumInteritemSpacing = 14
           //collectionViewLayer.estimatedItemSize = .zero
        

        ColorPickerCollectionView = Todoary.ColorPickerCollectionView(frame: .zero, collectionViewLayout: collectionViewLayer)
        
           view.addSubview(ColorPickerCollectionView)

            ColorPickerCollectionView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(208)
                make.centerX.equalToSuperview()
                make.width.equalTo(271)
                make.height.equalTo(236)
           }
       }

    
    private func setupCollectionView() {
        ColorPickerCollectionView.delegate = self
        ColorPickerCollectionView.dataSource = self
        
        //cell 등록
        ColorPickerCollectionView.register(ColorPickerCollectionViewCell.self, forCellWithReuseIdentifier: ColorPickerCollectionViewCellid)
        
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ColorPickerViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ColorPickerCollectionViewCellid,
            for: indexPath) as? ColorPickerCollectionViewCell else {
                fatalError("셀 타입 케스팅 실패")
            }
        return cell
    }


        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let collectionViewWidth = collectionView.bounds.width
//            let cellItemForRow: CGFloat = 5
//            let minimumSpacing: CGFloat = 14
//            let width = (collectionViewWidth - (cellItemForRow - 1) * minimumSpacing) / cellItemForRow
//
            return CGSize(width: 35, height: 35)
//            return CGSize(width: 45, height: 45)

            }
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//           return UIEdgeInsets(top: 20, left: 23, bottom: 21, right: 23)
//        }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return CGFloat(22)

       }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return CGFloat(14)
        }
      
    
    
}
