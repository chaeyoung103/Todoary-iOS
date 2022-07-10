//
//  ProfileViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/11.
//

import UIKit
import SnapKit
import Then

class ProfileViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    //navigation bar
    var navigationView : NavigationView!
    
    //profile
    
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "profile")
        $0.layer.cornerRadius = 85/2
        $0.clipsToBounds = true
    }
    
    let imagePicker = UILabel().then{
        $0.text = "사진 변경"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let nickNameTitle = UILabel().then{
        $0.text = "닉네임"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let nickNameTf = UITextField().then{
        $0.text = "베어"
        $0.textFieldTypeSetting(type: .tableCell)
        $0.font = UIFont.nbFont(type: .tableCell)
        $0.borderStyle = .none
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.cornerRadius = 10
    }
    
    let introduceTitle = UILabel().then{
        $0.text = "한줄소개"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let introduceTf = UITextField().then{
        $0.text = "J가 되고싶은 P"
        $0.textFieldTypeSetting(type: .tableCell)
        $0.font = UIFont.nbFont(type: .tableCell)
        $0.borderStyle = .none
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.cornerRadius = 10
    }
    
    
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView = NavigationView(frame: .zero , self.navigationController!).then{
            $0.navigationTitle.text = "계정"
        }
        

        self.view.backgroundColor = .white
        
        nickNameTf.addLeftPadding()
        introduceTf.addLeftPadding()
        
        setUpView()
        setUpConstraint()
    }
    
    //MARK: - Actions
    
    //MARK: - Helpers
}

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
    func addleftimage(image:UIImage) {
            let leftimage = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            leftimage.image = image
            self.leftView = leftimage
            self.leftViewMode = .always
        }
}
