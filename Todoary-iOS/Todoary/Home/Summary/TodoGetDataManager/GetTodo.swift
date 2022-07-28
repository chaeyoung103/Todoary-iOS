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

struct GetTodoInfo: Decodable{
    let todoId: Int?
    let isChecked: Bool?
    let title: String?
    let isAlarmEnabled: Bool?
    let targetTime: Bool?
    let createdTime: String?
    let categories: GetTodoCategories?
}

struct GetTodoCategories: Decodable{
    let id: Int?
    let title: String?
    let color: String?
}
