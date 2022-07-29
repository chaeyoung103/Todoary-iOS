//
//  ProfileImgDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Alamofire

class ProfileImgDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
//    let parameters = Parameters
//    
//    let URL = "http://todoary.com/users/profile-img"
//    
//    func profileImgDelete(_ veiwController : ProfileViewController) {
//        AF.upload(multipartFormData: {multipartFormData in
//            for (key, value) in parameters {
//                            multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//                        }
//                        if let image = imageData?.pngData() {
//                            multipartFormData.append(image, withName: "activityImage", fileName: "\(image).png", mimeType: "image/png")
//                        }
//                    }, to: URL, usingThreshold: UInt64.init(), method: .patch, headers: headers).response { response in
//                    }
//        }
//    }
//}
}
