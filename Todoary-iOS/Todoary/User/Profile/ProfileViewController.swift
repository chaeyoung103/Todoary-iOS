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

class ProfileViewController : UIViewController, UITextFieldDelegate,UITextViewDelegate {
    
    let imagePickerController = UIImagePickerController()
    
    var isPhoto = false
    
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
        
        NotificationCenter.default.addObserver(self,
                                            selector: #selector(textFieldDidChange(_:)),
                                            name: UITextField.textDidChangeNotification,
                                            object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 1){
            self.view.window?.frame.origin.y = 0
        }
    }
    
    //MARK: - Actions
    
    @objc func imagePickerDidTab(_ sender: Any) {
        
        PhotoAuth()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let removeAction = UIAlertAction(title: "현재 사진 삭제", style: .default, handler:
                                            {(UIAlertAction) in
            self.profileImage.image = UIImage(named: "profile")
        })
        
        let albumSelectAction = UIAlertAction(title: "갤러리에서 선택", style: .default, handler: { [self](UIAlertAction) in
            
            isPhoto = PhotoAuth()
            
            if self.isPhoto {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                print("접근권한x")
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
        let profileInput = ProfileInput(nickname: nickNameTf.text, introduce: introduceTf.text)
        ProfileDataManager().profileDataManager(self,profileInput)
        
        profileImgDataManager().profileImgData(self, profileImage.image!)
    }
    
    //MARK: - Helpers
    
    @objc
    private func textFieldDidChange(_ notification: Notification) {
            if let textField = notification.object as? UITextField {
                switch textField {
                case nickNameTf:
                    if let text = nickNameTf.text {
                        if text.count > 10 {
                            // 🪓 주어진 인덱스에서 특정 거리만큼 떨어진 인덱스 반환
                            let maxIndex = text.index(text.startIndex, offsetBy: 10)
                            // 🪓 문자열 자르기
                            let newString = text.substring(to: maxIndex)
                            nickNameTf.text = newString
                        }
                    }
                default:
                    return
                }
            }
        }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            let newLength = (textField.text.characters.count)! + string.characters.count - range.length
//            return !(newLength > 10)
//        }
//    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementString text: String) -> Bool {
//        let currentText = textView.text ?? ""
//        guard let stringRange = Range(range, in: currentText) else { return false }
//        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
//        
//        return changedText.count <= 31
//    }
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
        
        var isAuth = false
        
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            return true // 사용자가 앱에 사진 라이브러리에 대한 액세스 권한을 명시 적으로 부여했습니다.
        case .denied:
            return false // 사용자가 사진 라이브러리에 대한 앱 액세스를 명시 적으로 거부했습니다.
        case .limited:
            return true // 사진 선택
        case .notDetermined: // 사진 라이브러리 액세스에는 명시적인 사용자 권한이 필요하지만 사용자가 아직 이러한 권한을 부여하거나 거부하지 않았습니다
            PHPhotoLibrary.requestAuthorization { (state) in
                if state == .authorized {
                    isAuth = true
                }
            }
            return isAuth
        case .restricted:
            return false // 앱이 사진 라이브러리에 액세스 할 수있는 권한이 없으며 사용자는 이러한 권한을 부여 할 수 없습니다.
        default: return false
        }
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

extension ProfileViewController {
    func successAPI_profile(_ result : GetProfileResult) {
        nickNameTf.text = result.nickname
        introduceTf.text = result.introduce
        let url = URL(string: result.profileImgUrl!)
        profileImage.load(url: url!)
    }
}

extension UITextView {
    func addLeftPadding() {
        self.textContainerInset = UIEdgeInsets(top: 14, left: 10, bottom: 0, right: 10)
        self.scrollIndicatorInsets = self.textContainerInset
    }
}

class AddPaddingButtton : UIButton {
    var padding = UIEdgeInsets(top: 1.5, left: 10, bottom: 0, right: 10)
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
