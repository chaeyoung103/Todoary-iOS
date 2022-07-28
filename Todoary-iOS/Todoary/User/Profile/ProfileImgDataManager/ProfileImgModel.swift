//
//  ProfileImgModel.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Foundation

struct ProfileImgModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : ProfileImgModelResult?
    
}

struct ProfileImgModelResult : Decodable {
    var userId : String
    var profileImgUrl : String
}
