//
//  ProfileViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/11.
//

import UIKit
import SnapKit
import Then
import Photos

class ProfileViewController : UIViewController {
    
    let imagePickerController = UIImagePickerController()
    
    var isphoto = false
    
    //MARK: - UIComponenets
    
    //navigation bar
    var navigationView : NavigationView!
    
    //profile
    
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "profile")
        $0.layer.cornerRadius = 85/2
        $0.clipsToBounds = true
    }
    
    let imagePicker = UIButton().then{
        $0.titleEdgeInsets = UIEdgeInsets(top: 1.5, left: 0, bottom: 0, right: 0)
        $0.setTitle("사진 변경", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.silver_115, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 12, weight: .semibold)
        $0.titleLabel?.textAlignment = .justified
        $0.layer.borderColor = UIColor.silver_115.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 26/2
        $0.addTarget(self, action: #selector(imagePickerDidTab), for: .touchUpInside)
    }
    
    let nickNameTitle = UILabel().then{
        $0.text = "닉네임"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let nickNameTf = UITextField().then{
        $0.text = "일이삼사오육칠팔구십"
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
    
    let introduceTf = UITextView().then{
        $0.text = "가가가가가가가가가가가가가가가가가가가가가ㅏ까ㅏ가가가가가"
        $0.font = UIFont.nbFont(type: .tableCell)
        $0.addLeftPadding()
        $0.textViewTypeSetting()
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.cornerRadius = 10
    }
    
    let confirmBtn = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .buttonColor
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.cornerRadius = 52/2
        $0.addTarget(self, action: #selector(confirmBtnDidTab), for: .touchUpInside)
    }
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView = NavigationView(frame: .zero , self.navigationController!).then{
            $0.navigationTitle.text = "계정"
        }
        
        self.view.backgroundColor = .white
        
        nickNameTf.addLeftPadding()
        
        setUpView()
        setUpConstraint()
        
        GetProfileDataManager().getProfileDataManger(self)
        
    }
    
    //MARK: - Actions
    @objc func imagePickerDidTab(_ sender: Any) {
        
        
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let removeAction = UIAlertAction(title: "현재 사진 삭제", style: .default, handler:
                                            {(UIAlertAction) in
            self.profileImage.image = UIImage(named: "profile")
        })
        let albumSelectAction = UIAlertAction(title: "갤러리에서 선택", style: .default, handler: { [self](UIAlertAction) in
            self.isphoto = self.PhotoAuth()
            
            if self.isphoto {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self //3
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                self.AuthSettingOpen(AuthString: "사진")
            }
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(removeAction)
        alert.addAction(albumSelectAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func confirmBtnDidTab() {
        let profileInput = ProfileInput(nickName: nickNameTf.text, introduce: introduceTf.text)
        ProfileDataManager().profileDataManager(self,profileInput)
        print("확인버튼")
    }
    
    //MARK: - Helpers
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.contentMode = .scaleAspectFill
            profileImage.image = pickedImage //4
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func PhotoAuth() -> Bool {
        // 포토 라이브러리 접근 권한
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        var isAuth = false
        
        switch authorizationStatus {
        case .authorized: return true // 사용자가 앱에 사진 라이브러리에 대한 액세스 권한을 명시 적으로 부여했습니다.
        case .denied: break // 사용자가 사진 라이브러리에 대한 앱 액세스를 명시 적으로 거부했습니다.
        case .limited: break // ?
        case .notDetermined: // 사진 라이브러리 액세스에는 명시적인 사용자 권한이 필요하지만 사용자가 아직 이러한 권한을 부여하거나 거부하지 않았습니다
            PHPhotoLibrary.requestAuthorization { (state) in
                if state == .authorized {
                    isAuth = true
                }
            }
            return isAuth
        case .restricted: break // 앱이 사진 라이브러리에 액세스 할 수있는 권한이 없으며 사용자는 이러한 권한을 부여 할 수 없습니다.
        default: break
        }
        
        return false;
    }
    
    func AuthSettingOpen(AuthString: String) {
        let AppName = "Todoary"
        let message = "\(AppName)이(가) \(AuthString)에 접근할 수 없습니다.\r\n 설정화면으로 가시겠습니까?"
        let alert = UIAlertController(title: "권한 설정하기", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .destructive) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)}
        let confirm = UIAlertAction(title: "확인", style: .default) { (UIAlertAction) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)}
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        self.present(alert, animated: true, completion: nil)
    }
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

extension ProfileViewController {
    func successAPI_profile(_ result : GetProfileResult) {
        nickNameTf.text = result.nickname
        introduceTf.text = result.introduce
    }
}

extension UITextView {
    func addLeftPadding() {
        self.textContainerInset = UIEdgeInsets(top: 14, left: 10, bottom: 0, right: 10)
        self.scrollIndicatorInsets = self.textContainerInset
    }
}

class AddPaddingButtton : UIButton
{
    var padding = UIEdgeInsets(top: 1.5, left: 10, bottom: 0, right: 10)
    
 
}
