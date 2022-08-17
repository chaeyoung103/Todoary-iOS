//
//  GetDiary.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/17.
//

import Foundation

struct GetDiaryModel: Decodable{
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [GetTodoInfo]?
}

struct GetDiaryInfo: Decodable{
    let diaryId: Int
    var title: String
    var content: String
    var createdTime: String
}
