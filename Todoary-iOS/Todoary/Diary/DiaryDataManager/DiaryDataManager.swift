//
//  DiaryDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/17.
//

import UIKit
import Alamofire

class DiaryDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    //다이어리 생성/수정
    func posts(viewController: DiaryViewController, createdDate: String, parameter: DiaryInput){
        
        AF.request("http://todoary.com:9000/diary/\(createdDate)", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: ApiModel.self) { response in
            switch response.result {
            case .success(let result):
                if(result.code == 1000){
                    print("성공")
                    viewController.navigationController?.popViewController(animated: true)
                }else{
                    let alert = DataBaseErrorAlert()
                    viewController.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                print("실패")
                print(error.localizedDescription)
            }
        }
    }
    
    //다이어리 삭제
    func delete(viewController: DiaryViewController, createdDate: String){
        
        AF.request("https://todoary.com/diary/\(createdDate)",
                   method: .delete,
                   parameters: [:],
                   headers: headers)
            .validate()
            .responseDecodable(of: ApiModel.self) { response in
                switch response.result {
                case .success(let result):
                    if(result.code == 1000){
                        viewController.navigationController?.popViewController(animated: true)
                    }
                    return
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    //다이어리 조회
    func gets(_ date: String){

        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        AF.request("https://todoary.com/todo/date/\(date)", method: .get, parameters: nil, headers: headers).validate().responseDecodable(of: GetTodoModel.self) { response in
            switch response.result {
            case .success(let result):
                HomeViewController.bottomSheetVC.checkGetTodoApiResultCode(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
