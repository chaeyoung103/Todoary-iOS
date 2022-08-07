//
//  TodoSettingDataManager.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/27.
//

import Alamofire

class TodoSettingDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func todoSettingDataManager( _ viewController : UIViewController , _ parameter: TodoSettingInput) {
        AF.request("https://todoary.com/todo", method: .post, parameters: parameter,  encoder: JSONParameterEncoder.default , headers: headers).validate().responseDecodable(of: TodoSettingModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code {
                case 1000:
                    print("투두생성성공")
                    if let vc = viewController as? TodoSettingViewController{
                        vc.navigationController?.popViewController(animated: true)
                    }else if let vc = viewController as? SummaryBottomViewController{
                        vc.todoTf.resignFirstResponder()
                        vc.todoEasySettingView.isHidden = true
                        vc.todoTf.isHidden = true
                        vc.collectionView.isHidden = true
                        
                        let result = parameter.targetDate.components(separatedBy: "-")
                        
                        let year = result[0]
                        let month = result[1]
                        
                        GetCalendataManager().getCalendataManager(HomeViewController(), yearMonth: "\(year)-\(month)")
                        
                        HomeViewController().collectionView.reloadData()
                        
                        GetTodoDataManager().gets(HomeViewController.bottomSheetVC.todoDate.dateSendServer)
                    }
                case 2201:
                    print("중복된 닉네임입니다")
                default:
                    print(result.message)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

