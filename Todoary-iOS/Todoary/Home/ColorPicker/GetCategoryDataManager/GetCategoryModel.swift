//
//  GetCategoryModel.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/31.
//
struct GetCategoryModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result :[GetCategoryResult]
}

struct GetCategoryResult : Decodable {
    var id : Int
    var title : String
    var color : Int
}
