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
    
    //MARK: - Properties
    
    private var ColorPickerCollectionViewCellid = "ColorPickerCollectionViewCellid"
    
    private var ColorPickerCollectionView: ColorPickerCollectionView!
    
    //선택된 컬러값
    var selectColor : Int!
    
    //id 데이터가 있을때 카테고리id값
    var categoryId : Int!
    
    //데이터가 넘겨왔을 경우에 data를 담는 struct
    var categoryData : CategoryData!

    var navigationView:NavigationView!
    
    //MARK: - UIComponenets
    
    let categoryTitle = UITextField().then{
        $0.placeholder = "카테고리 이름을 입력해주세요"
        $0.font = UIFont.nbFont(ofSize: 15, weight: .medium)
        $0.addLeftPadding(padding: 11)
        $0.borderStyle = .none
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.cornerRadius = 10
        $0.setPlaceholderColor(.todoaryGrey)
    }
    
    let deleteBtn = UIButton().then{
        $0.setImage(UIImage (named: "category_trash"), for: .normal)
        $0.addTarget(self, action: #selector(deleteBtnDidTap), for: .touchUpInside)
    }
    
    let colorview = UIView().then{
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
    }
    
    let completeBtn = UIButton().then{
        $0.setTitle("완료", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 18, weight: .semibold)
        $0.layer.cornerRadius = 15
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.borderWidth = 1
        $0.addTarget(self, action: #selector(completeBtnDidTap), for: .touchUpInside)
    }
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        navigationView = NavigationView(frame: .zero , self.navigationController!)
        self.view.backgroundColor = .white
        
        setUpView()
        setUpConstraint()
        
        configure()
        setupCollectionView()
        
        categoryReceive()
        
    }
    
    //MARK: - Actions
    
    //완료버튼 누르기 -> 뒤로가기, api 호출
    @objc private func completeBtnDidTap() {
        
        //데이터가 없는 경우, 있는 경우에 따라 생성, 수정 api로 변경
        //제목이나 컬러값을 유저가 넣지 않았을때 팝업 띄우기
        if categoryData != nil {
            /*
            if categoryTitle.text != "" {
                print(selectColor!)
                let categoryModifyInput = CategoryModifyInput(title: categoryTitle.text!, color: selectColor)
                CategoryModifyDataManager().categoryModifyDataManager(self,categoryModifyInput,categoryId: categoryId)
                
                self.navigationController?.popViewController(animated: true)
            }else {
                let alert = UIAlertController(title: "제목을 넣어주세요", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                    
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
             */
            
            //수정본
            if(categoryTitle.text == "" ){
                let alert = UIAlertController(title: "제목을 넣어주세요", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                    
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }else if(categoryTitle.text!.count > 5){
                let alert = UIAlertController(title: nil, message: "카테고리명을 5글자 이하로 설정해주세요.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                    
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }else{
                print(selectColor!)
                let categoryModifyInput = CategoryModifyInput(title: categoryTitle.text!, color: selectColor)
                CategoryModifyDataManager().categoryModifyDataManager(self,categoryModifyInput,categoryId: categoryId)
                
                self.navigationController?.popViewController(animated: true)
            }
            
            
        }else {

            if(selectColor == nil){
                let alert = UIAlertController(title: "색상을 선택해주세요", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                    
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }else if(categoryTitle.text == ""){
                let alert = UIAlertController(title: "제목을 넣어주세요", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                    
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }else if(categoryTitle.text!.count > 5){
                let alert = UIAlertController(title: nil, message: "카테고리명을 5글자 이하로 설정해주세요", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                    
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }else{
                print(selectColor!)
                let categoryMakeInput = CategoryMakeInput(title: categoryTitle.text!, color: selectColor)
                CategoryMakeDataManager().categoryMakeDataManager(self,categoryMakeInput)
                
                self.navigationController?.popViewController(animated: true)
            }
            

        }
    }
    
    //카테고리 삭제 버튼 -> 카테고리 삭제 api 호출
    @objc func deleteBtnDidTap(){
        CategoryDeleteDataManager().categoryDeleteDataManager(self, categoryId: categoryId)
    }
    
    //MARK: - Helpers
    
    //정보가 있을 경우에 카테고리정보받아오기
    func categoryReceive(){
        if categoryData != nil {
            categoryTitle.text = categoryData.title
            categoryId = categoryData.id
            selectColor = categoryData.color
            ColorPickerCollectionView?.reloadData()
        }
    }
    
    //컬렉션뷰 layout
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

    //컬렉션뷰 등록
    private func setupCollectionView() {
        ColorPickerCollectionView.delegate = self
        ColorPickerCollectionView.dataSource = self
        
        ColorPickerCollectionView.register(ColorPickerCollectionViewCell.self, forCellWithReuseIdentifier: ColorPickerCollectionViewCellid)
    }
}



    //MARK: - UICollectionViewDataSource

extension ColorPickerViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    //셀 초기값 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ColorPickerCollectionViewCellid,
            for: indexPath) as? ColorPickerCollectionViewCell else {
                fatalError("셀 타입 케스팅 실패")
            }
        
        cell.layer.cornerRadius = 30/2
        cell.backgroundColor = .categoryColor[indexPath.row]
        cell.colorBtnpick.layer.borderColor = UIColor.categoryColor[indexPath.row].cgColor
        
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
        return CGSize(width: 30, height: 30)
    }
    
    //셀 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(25)
    }
    
    //셀 양옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(20)
    }
    

    
    //MARK: - UICollectionViewDelegate
    
    //셀 선택o
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at:indexPath) as? ColorPickerCollectionViewCell else{
            fatalError()
        }
        selectColor = indexPath.row
        cell.colorBtnpick.isHidden = false
        cell.colorBtnpick.layer.borderWidth = 2
        cell.colorBtnpick.layer.cornerRadius = 40/2
        cell.colorBtnpick.isUserInteractionEnabled = true
    }
    
    //셀 선택x
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


