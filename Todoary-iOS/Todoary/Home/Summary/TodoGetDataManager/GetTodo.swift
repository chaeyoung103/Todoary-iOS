//
//  TodoGetInput.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import Foundation
import UIKit

struct GetTodoModel: Decodable{
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [GetTodoInfo]?
}

struct GetTodoInfo: Decodable, Equatable{
    let todoId: Int
    var isPinned: Bool
    var isChecked: Bool
    var title: String
    var isAlarmEnabled: Bool
    var targetTime: String?
    var createdTime: String
    var categories: [GetTodoCategories]
    
    static func ==(lhs: GetTodoInfo, rhs: GetTodoInfo) -> Bool {
        return lhs.todoId == rhs.todoId
//        && lhs.isPinned == rhs.isPinned && lhs.isChecked == rhs.isChecked && lhs.title == rhs.title && lhs.isAlarmEnabled == rhs.isAlarmEnabled && lhs.targetTime == rhs.targetTime && lhs.createdTime == rhs.createdTime && lhs.categories == rhs.categories
    }
    
//    func dateUseAtFrontType() -> String{
//        //18:00 형태
//        
//        guard let time = targetTime else{
//            fatalError()
//        }
//
//        //12:00 이전 -> AM
//        //10:00 이전 -> index 조절 필요
//
//        let startIndex = time.index(time.startIndex, offsetBy: 1)
//        let endIndex = time.endIndex
//        let range = startIndex..<endIndex
//
//        if(time < "12:00"){
//            if(){
//
//            }else{
//
//            }
//            return "AM "
//        }else{
//            return "PM "
//        }
//    }
}

struct GetTodoCategories: Decodable{
    let id: Int
    let title: String
    let color: String
    
    func changeUIColor() -> UIColor{
        
        switch self.color{
        case "FA9031":
            return .category1
        case "F8C32C":
            return .category2
        case "9F843C":
            return .category3
        case "347251":
            return .category4
        case "244B3A":
            return .category5
        case "B94949":
            return .category6
        case "34AFB8":
            return .category7
        case "9DB09B":
            return .category8
        case "E9D090":
            return .category9
        case "DD8D43":
            return .category10
        case "B45F12":
            return .category11
        case "F69E58":
            return .category12
        case "3773D4":
            return .category13
        case "24354A":
            return .category14
        case "626E80":
            return .category15
        case "9FA7AF":
            return .category16
        case "D7ABB5":
            return .category17
        case "E97590":
            return .category18
        default:
            fatalError()
        }
    }
}
