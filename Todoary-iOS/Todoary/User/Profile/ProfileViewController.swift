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

class ProfileViewController : BaseViewController {
    
    //MARK: - Properties
    
    let imagePickerController = UIImagePickerController()
    
    var isPhoto = false
    
    //MARK: - UIComponenets
    
    //profile
    
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "profile")
        $0.contentMode = .scaleAspectFill
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1).cgColor
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
        $0.font = UIFont.nbFont(type: .tableCell)
        $0.addLeftPadding()
        $0.addLetterSpacing(spacing: 0.28)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.cornerRadius = 10
    }
    
    let nickNameCount = UILabel().then{
        $0.text = "0/10"
        $0.textColor = .todoaryGrey
        $0.font = UIFont.nbFont(ofSize: 12, weight: .medium)
    }
    
    let nickNameNotice = UILabel().then{
        $0.isHidden = true
        $0.text = "이미 사용중인 닉네임입니다."
        $0.textColor = .todoaryGrey
        $0.font = UIFont.nbFont(ofSize: 12, weight: .medium)
    }
    
    let introduceTitle = UILabel().then{
        $0.text = "한줄소개"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let introduceTf = UITextView().then{
        $0.text = "소개글을 입력해주세요"
        $0.font = UIFont.nbFont(type: .tableCell)
        $0.addLeftPadding()
        $0.textViewTypeSetting()
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.cornerRadius = 10
    }
    
    let introduceCount = UILabel().then{
        $0.text = "0/30"
        $0.textColor = .todoaryGrey
        $0.font = UIFont.nbFont(ofSize: 12, weight: .medium)
    }
    
    let confirmBtn = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(confirmBtnDidTab), for: .touchUpInside)
    }
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationTitle.text = "계정"
        
        self.view.backgroundColor = .white
        
        setUpView()
        setUpConstraint()
    
        GetProfileDataManager().getProfileDataManger(self)
        
        //닉네임 textfield 10자 글자수제한 + observer
        NotificationCenter.default.addObserver(self,
                                            selector: #selector(textFieldDidChange(_:)),
                                            name: UITextField.textDidChangeNotification,
                                            object: nil)
        
        //한줄소개 textview 30자 글자수제한 + observer
        NotificationCenter.default.addObserver(self,
                                            selector: #selector(textViewDidChange(_:)),
                                            name: UITextView.textDidChangeNotification,
                                            object: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 1){
            self.view.window?.frame.origin.y = 0
        }
    }
    
    //MARK: - Actions
    
    //사진변경 버튼 누르기 -> 현재사진삭제 or 갤러리선택
    @objc func imagePickerDidTab(_ sender: Any) {
        
        //사진 접근권한 메시지 보여주기 (처음에만)
        PhotoAuth()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let removeAction = UIAlertAction(title: "현재 사진 삭제", style: .default, handler:
                                            {(UIAlertAction) in
            self.profileImage.image = UIImage(named: "profile")
        })
        
        let albumSelectAction = UIAlertAction(title: "갤러리에서 선택", style: .default, handler: { [self](UIAlertAction) in
            
            //접근권한 있는지 없는지 체크
            isPhoto = PhotoAuth()
            
            if self.isPhoto { //권한 있는 경우 사진 고르기
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            } else {//권한 없는 경우 팝업 띄우기
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
    
    @objc func textFieldDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            switch textField {
            case nickNameTf:
                if let text = nickNameTf.text {
                    
                    if nickNameTf.text!.count < 11 {
                        nickNameCount.text = "\(text.count)/10"
                    }
                    
                    if text.count >= 10 {
                        //주어진 인덱스에서 특정 거리만큼 떨어진 인덱스 반환
                        let maxIndex = text.index(text.startIndex, offsetBy: 10)
                        //문자열 자르기
                        let newString = text.substring(to: maxIndex)
                        nickNameTf.text = newString
                    }
                }
            default:
                return
            }
        }
    }
    
    @objc func textViewDidChange(_ notification: Notification) {
        if let textView = notification.object as? UITextView {
            switch textView {
            case introduceTf:
                if let text = introduceTf.text {
                    
                    if introduceTf.text!.count < 31 {
                        introduceCount.text = "\(text.count)/30"
                    }
                    
                    if text.count >= 30 {
                        //주어진 인덱스에서 특정 거리만큼 떨어진 인덱스 반환
                        let maxIndex = text.index(text.startIndex, offsetBy: 30)
                        //문자열 자르기
                        let newString = text.substring(to: maxIndex)
                        introduceTf.text = newString
                    }
                }
            default:
                return
            }
        }
    }
    
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
            return true // 모든 권한 허용
        case .denied:
            return false // 권한 거부
        case .limited:
            return true // 사진 선택적으로 허용
        case .notDetermined: // 아직 결정된 것이 없는 경우
            PHPhotoLibrary.requestAuthorization { (state) in
                if state == .authorized {
                    isAuth = true
                }
            }
            return isAuth
        case .restricted:
            return false // 권한 x
        default: return false
        }
    }
    
    func AuthSettingOpen(AuthString: String) {
        let AppName = "Todoary"
        let message = "\(AppName)이(가) \(AuthString)에 접근할 수 없습니다.\r\n 설정화면으로 가시겠습니까?"
        let alert = UIAlertController(title: "권한 설정하기", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        // 권한이 없는 경우 설정 화면으로 갈 수있는 팝업 띄우기
        let confirm = UIAlertAction(title: "확인", style: .default) { (UIAlertAction) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)}
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProfileViewController {
    // 프로필 조회 성공시에 불리는 함수
    func successAPI_profile(_ result : GetProfileResult) {
        nickNameTf.text = result.nickname
        introduceTf.text = result.introduce
        nickNameCount.text = "\(result.nickname!.count)/10"
        if ((result.introduce != nil)){
            introduceCount.text = "\(result.introduce!.count)/30"
        }
        let url = URL(string: result.profileImgUrl!)
        profileImage.load(url: url!)
    }
}

//텍스트뷰에 패딩 넣기
extension UITextView {
    func addLeftPadding() {
        self.textContainerInset = UIEdgeInsets(top: 14, left: 5, bottom: 0, right: 10)
        self.scrollIndicatorInsets = self.textContainerInset
    }
}

// 버튼에 패딩 넣기
class AddPaddingButtton : UIButton {
    var padding = UIEdgeInsets(top: 1.5, left: 10, bottom: 0, right: 10)
}

//url로 이미지 불러오기
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
