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
    var weight: Float?
    var calories: Float?
    var protein: Float?
    var fat: Float?
    var carbohydrate: Float?
    
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
    
    var grains: Float?
    var meats: Float?
    var oils: Float?
    var milk: Float?
    var vegetables: Float?
    var fruits: Float?

    
    func getNutrientsAmoumt() {
        switch category {
        case "穀物類", "澱粉類", "飲料類":
            grains = (carbohydrate ?? 0)/15
            meats = 0.0
            oils = 0.0
            milk = 0.0
            vegetables = 0.0
            fruits = 0.0
        case "堅果及種子類", "油脂類":
            grains = 0.0
            meats = 0.0
            oils = (fat ?? 0)/5
            milk = 0.0
            vegetables = 0.0
            fruits = 0.0
        case "水果類":
            grains = 0.0
            meats = 0.0
            oils = 0.0
            milk = 0.0
            vegetables = 0.0
            fruits = (carbohydrate ?? 0)/15
        case "蔬菜類", "藻類", "菇類":
            grains = 0.0
            meats = 0.0
            oils = 0.0
            milk = 0.0
            vegetables = (carbohydrate ?? 0)/5
            fruits = 0.0
        case "豆類", "肉類", "魚貝類", "蛋類":
            grains = 0.0
            meats = (protein ?? 0)/7
            oils = 0.0
            milk = 0.0
            vegetables = 0.0
            fruits = 0.0
        case "乳品類":
            grains = 0.0
            meats = 0.0
            oils = 0.0
            milk = (protein ?? 0)/8
            vegetables = 0.0
            fruits = 0.0
        case "糕餅點心類":
            grains = (carbohydrate ?? 0)/15
            meats = 0.0
            oils = (fat ?? 0)/5
            milk = 0.0
            vegetables = 0.0
            fruits = 0.0
        case "加工調理食品類":
            grains = (carbohydrate ?? 0)/15
            meats = (protein ?? 0)/7
            oils = (fat ?? 0)/5
            milk = 0.0
            vegetables = 0.0
            fruits = 0.0
        default:
            grains = 0.0
            meats = 0.0
            oils = 0.0
            milk = 0.0
            vegetables = 0.0
            fruits = 0.0
        }
    }
}
