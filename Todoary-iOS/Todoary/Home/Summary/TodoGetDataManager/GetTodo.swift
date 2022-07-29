//
//  TodoGetInput.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import Foundation

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
    var categories: [GetTodoCategories]?
    
    static func ==(lhs: GetTodoInfo, rhs: GetTodoInfo) -> Bool {
        return lhs.todoId == rhs.todoId
//        && lhs.isPinned == rhs.isPinned && lhs.isChecked == rhs.isChecked && lhs.title == rhs.title && lhs.isAlarmEnabled == rhs.isAlarmEnabled && lhs.targetTime == rhs.targetTime && lhs.createdTime == rhs.createdTime && lhs.categories == rhs.categories
    }
}

struct GetTodoCategories: Decodable{
    let id: Int?
    let title: String?
    let color: String?
}
