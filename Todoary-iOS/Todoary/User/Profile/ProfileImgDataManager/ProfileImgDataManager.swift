//
//  ProfileImgDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Alamofire

class profileImgDataManager {
    
    let headers : HTTPHeaders = [.contentType("multipart/form-data"),.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func profileImgData(_ veiwController : ProfileViewController, _ Input: UIImage) {
        AF.upload(multipartFormData: { (multipartFormData) in
            
            print("실행?")
            
            if let image = Input.jpegData(compressionQuality: 0.1) {
                multipartFormData.append(image, withName: "profile-img", fileName: "\(image).jpeg", mimeType: "image/ipeg")
            }
            
        }, to: "https://todoary.com/users/profile-img", usingThreshold: UInt64.init(), method: .patch, headers: headers).validate().responseDecodable(of: ProfileImgModel.self)
        { response in
            
            switch response.result {
            case .success(let result) :
                switch result.code {
                    
                case 1000 :
                    print("사진바꾸기")
                case 5001 :
                    let alert = DataBaseErrorAlert()
                    veiwController.present(alert, animated: true, completion: nil)
                default:
                    print(result.message)
                }
                print(result.message)
                print("????????")
            case .failure(let error) :
                print(error.localizedDescription)
                print("!!!")
            }
        }
        
    }
}
