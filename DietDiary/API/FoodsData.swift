//
//  FoodsData.swift
//  foodlist
//
//  Created by Alicia on 2020/12/26.
//

import UIKit
import ObjectMapper

class FoodsData: BaseResponseData {
    var data: [Food]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

class Food: Mappable {
    var category: String?
    var name: String?
    var weight: Int?
    var calories: Int?
    var protein: Int?
    var fat: Int?
    var carbohydrate: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        category <- map["category"]
        name <- map["name"]
        weight <- map["weight"]
        calories <- map["calories"]
        protein <- map["protein"]
        fat <- map["fat"]
        carbohydrate <- map["carbohydrate"]
    }
}
