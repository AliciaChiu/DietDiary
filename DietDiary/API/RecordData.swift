//
//  RecordData.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/28.
//

import Foundation
import ObjectMapper

class RecordData: BaseResponseData {
    var data: [Record]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

//飲食帖
class Record: Mappable,Equatable {
    
    static func ==(lhs: Record, rhs: Record) -> Bool {
        return lhs === rhs
    }
    
    var id: Int?
    var date: String?
    var meal: Int?
    var user_unique_id: String?
    var note: String?
    var delete_meal_records: [Int]?
    var delete_meal_images: [Int]?
    var meal_images: [MealImage]?
    var meal_records: [MealRecord]?
    
    required init?(map: Map) {}
    required init() {}
    
    func mapping(map: Map) {
        id <- map["id"]
        date <- map["date"]
        meal <- map["meal"]
        user_unique_id <- map["user_unique_id"]
        note <- map["note"]
        delete_meal_records <- map["delete_meal_records"]
        delete_meal_images <- map["delete_meal_images"]
        meal_images <- map["meal_images"]
        meal_records <- map["meal_records"]
        
        
    }
    
    func getMealName() -> String {
        var mealName = ""
        switch self.meal {
        case 1:
            mealName = "早餐"
        case 2:
            mealName = "午餐"
        case 3:
            mealName = "晚餐"
        case 4:
            mealName = "點心"
        default:
            mealName = ""
        }
        return mealName
    }
}

class MealImage: Mappable {
    
    var id: Int?
    var post_id: Int?
    var image_content: String?

    
    required init?(map: Map) {}
    required init() {}
    
    func mapping(map: Map) {
        id <- map["id"]
        post_id <- map["post_id"]
        image_content <- map["image_content"]
 
    }
}

//吃了哪些食物
class MealRecord: Mappable {
    
    var id: Int?
    var post_id: Int?
    var food_name: String?
    var eaten_calories: Double?
    var grains: Double?
    var meats: Double?
    var oils: Double?
    var milk: Double?
    var vegetables: Double?
    var fruits: Double?
    var threeCalories: Double?
    var carbohydrate: Double?
    var protein: Double?
    var fat: Double?
    
    required init?(map: Map) {}
    required init() {}
    
    func mapping(map: Map) {
        id <- map["id"]
        post_id <- map["post_id"]
        food_name <- map["food_name"]
        eaten_calories <- map["eaten_calories"]
        grains <- map["grains"]
        meats <- map["meats"]
        oils <- map["oils"]
        milk <- map["milk"]
        vegetables <- map["vegetables"]
        fruits <- map["fruits"]
        threeCalories <- map["threeCalories"]
        carbohydrate <- map["carbohydrate"]
        protein <- map["protein"]
        fat <- map["fat"]
        
    }
}
