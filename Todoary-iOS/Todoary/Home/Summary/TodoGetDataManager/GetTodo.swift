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
    var isPinned: Bool?
    var isChecked: Bool?
    var title: String
    var targetDate: String?
    var isAlarmEnabled: Bool
    var targetTime: String?
    var createdTime: String
    var categories: [GetTodoCategories]
    
    static func ==(lhs: GetTodoInfo, rhs: GetTodoInfo) -> Bool {
        return lhs.todoId == rhs.todoId
//        && lhs.isPinned == rhs.isPinned && lhs.isChecked == rhs.isChecked && lhs.title == rhs.title && lhs.isAlarmEnabled == rhs.isAlarmEnabled && lhs.targetTime == rhs.targetTime && lhs.createdTime == rhs.createdTime && lhs.categories == rhs.categories
    }
    
    var convertTime: String?{

        guard let time = targetTime else{
            return nil
        }
        
        var startIndex: String.Index!
        var endIndex : String.Index!

        if(time < "12:00"){
            
            startIndex = time < "10:00" ? time.startIndex : time.index(time.startIndex, offsetBy: 1)
            endIndex = time.endIndex
            
            return "AM \(time[startIndex..<endIndex])"
            
        }else if(time < "13:00"){
            
            return "PM \(time)"
            
        }else{
            
            startIndex = time.startIndex
            endIndex = time.index(time.startIndex, offsetBy: 2)
            
            let changeHour = Int(time[startIndex..<endIndex])! - 12
            
            return "PM \(changeHour)\(time[endIndex..<time.endIndex])"
        }
    }
    
    var convertDate: String{
        
        //2022-07-24 -> 7월 24일
        let dateArr = targetDate!.components(separatedBy: "-")
        
        return "\(Int(dateArr[1])!)월 \(Int(dateArr[2])!)일"
    }
}

struct GetTodoCategories: Decodable{
    let id: Int
    let title: String
    let color: Int
}
