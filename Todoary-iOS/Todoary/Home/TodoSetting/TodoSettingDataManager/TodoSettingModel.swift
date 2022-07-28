//
//  TodoSettingModel.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/27.
//

struct TodoSettingModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result :TodoSettingResult?
}

struct TodoSettingResult : Decodable {
    var nickname : String?
    var introduce : String?
}
