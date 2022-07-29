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
}
