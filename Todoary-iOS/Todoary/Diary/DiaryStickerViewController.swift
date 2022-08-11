//
//  DiaryStickerViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/08/11.
//

import Foundation
import UIKit
import SnapKit
import Then

class DiaryStickerViewController : UIViewController {

    //MARK: - Properties

    private var DiaryStickerCollectionViewCellid = "DiaryStickerCollectionViewCellid"

    private var DiaryStickerCollectionView: DiaryStickerCollectionView!

    //선택된 컬러값
    var selectColor : Int!
 

    //MARK: - UIComponenets


    //MARK: - Lifecycles

    override func viewDidLoad() {

        super.viewDidLoad()
        
//        setUpView()
//        setUpConstraint()
//
//        configure()
//        setupCollectionView()
//
    }

    //MARK: - Helper

    //컬렉션뷰 layout
    private func configure() {

           let collectionViewLayer = UICollectionViewFlowLayout()
           collectionViewLayer.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)

        DiaryStickerCollectionView = Todoary.DiaryStickerCollectionView(frame: .zero, collectionViewLayout: collectionViewLayer)
        DiaryStickerCollectionView.isScrollEnabled = true
        
//        view.addSubview(DiaryStickerCollectionView)

        DiaryStickerCollectionView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(208)
                make.leading.equalToSuperview().offset(50)
                make.width.equalTo(300)
                make.height.equalTo(150)
                make.centerX.equalToSuperview()
           }
       }

    //컬렉션뷰 등록
    private func setupCollectionView() {
        DiaryStickerCollectionView.delegate = self
        DiaryStickerCollectionView.dataSource = self
        
        DiaryStickerCollectionView.register(DiaryStickerCollectionViewCell.self, forCellWithReuseIdentifier: DiaryStickerCollectionViewCellid)
    }
    }



    //MARK: - UICollectionViewDataSource

    extension DiaryStickerViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }

    //셀 초기값 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DiaryStickerCollectionViewCellid,
            for: indexPath) as? DiaryStickerCollectionViewCell else {
                fatalError("셀 타입 케스팅 실패")
            }
        
//        cell.Image = .categoryColor[indexPath.row]
        cell.backgroundColor = UIColor (
            red: 230/255,
            green: 230/255,
            blue: 230/255,
            alpha: 1
        )
        
        if(selectColor != nil){
            if indexPath.row == selectColor {
                collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
                cell.isSelected = true
            }
        }
        
        return cell
    }

    //셀 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 97.5, height: 101.5)
    }

    //셀 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }

    //셀 양옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }



    //MARK: - UICollectionViewDelegate

    //셀 선택o
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at:indexPath) as? DiaryStickerCollectionViewCell else{
            fatalError()
        }
        selectColor = indexPath.row
       
    }

    //셀 선택x
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at:indexPath) as? DiaryStickerCollectionViewCell else{
            fatalError()
        }
    }
}
