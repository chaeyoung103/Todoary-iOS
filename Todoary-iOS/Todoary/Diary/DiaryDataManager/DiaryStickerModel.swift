//
//  DiaryStickerModel.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/24.
//

struct DiaryStickerModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [Int]
}
