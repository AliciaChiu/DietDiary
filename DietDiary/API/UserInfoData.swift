//
//  UserInfo.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/27.
//

import UIKit
import ObjectMapper

class UserInfoData: BaseResponseData {
    
    var data: UserInformation?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

enum Gender: Int {
    case Male = 1
    case Female = 2
}

enum ExerciseDegree: Int {
    case LowActivity = 1
    case MiddleActivity = 2
    case HighActivity = 3
}

class UserInformation: Mappable {
    
    var unique_id: String?
    var profile_url: String?
    var user_name: String?
    var gender: Int?
    var birthday: String?
    var nowHeight: Double?
    var nowWeight: Double?
    var goalWeight: Double?
    var monthlyDecrease: Double?
    var exerciseDegree: Int?

    
    required init?(map: Map) {}
    required init() {}
    
    func mapping(map: Map) {
        
        unique_id <- map["unique_id"]
        profile_url <- map["profile_url"]
        user_name <- map["user_name"]
        gender <- map["gender"]
        birthday <- map["birthday"]
        nowHeight <- map["nowHeight"]
        nowWeight <- map["nowWeight"]
        goalWeight <- map["goalWeight"]
        monthlyDecrease <- map["monthlyDecrease"]
        exerciseDegree <- map["exerciseDegree"]
    }

    var age: Int {
        get {
            if let birthday = self.birthday {
                return birthday.calculateAge(format: "yyyy-MM-dd")
            }
            return 1
        }
    }
    var timeNeeded: Int? {
        get {
            return calculateTimeNeeded()
        }
    }
    var dailyCalories: Double? {
        get {
            return calculateBMR()
        }
    }
    
    var grainsAmount: Double?
    var meatsAmount: Double?
    var oilsAmount: Double?
    var milkAmount: Double?
    var fruitsAmount: Double?
    var vegetablesAmount: Double?
    
   
    
    var planName: String {
        get {
            if let weight = self.nowWeight, let goalWeight = self.goalWeight {
                if weight - goalWeight > 0 {
                    return "減重"
                } else if weight - goalWeight < 0{
                    return "增重"
                } else {
                    return "維持體重"
                }
            } else {
                return ""
            }
        }
    }
    
    func calculateTimeNeeded() -> Int {
        
        if let weight = self.nowWeight, let goalWeight = self.goalWeight, let monthlyDecrease = self.monthlyDecrease {
            
            let hopeLost = weight - goalWeight
            if monthlyDecrease != 0 {
                if hopeLost >= 0  {
                    let day = (hopeLost / monthlyDecrease) * 30
                    return Int(day)
                } else {
                    let day = (-hopeLost / monthlyDecrease) * 30
                    return Int(day)
                }
            }
        }
        return 0
    }
    
    func calculateBMR() -> Double {
        
        var base = 1.3
        var ree = 0.0
        var bmr = 0.0

        if let weight = self.nowWeight,
           let height = self.nowHeight,
           let goalWeight = self.goalWeight,
           let monthlyDecreaseWeight = self.monthlyDecrease {
            
            let dailyDecreaseCalories = monthlyDecreaseWeight * 7700 / 30
            let weighPara = 10 * weight
            let heightPara = 6.25 * height
            let agePara = Double(5 * age)

            if gender == Gender.Female.rawValue {
                ree = weighPara + heightPara - agePara - 161
            } else {
                ree = weighPara + heightPara - agePara + 5
            }
            
            if exerciseDegree == ExerciseDegree.LowActivity.rawValue {
                base = 1.3
            }else if exerciseDegree == ExerciseDegree.MiddleActivity.rawValue {
                base = 1.5
            }else if exerciseDegree == ExerciseDegree.HighActivity.rawValue {
                base = 1.7
            }
            
            if weight - goalWeight > 0 {
                bmr = base * ree - dailyDecreaseCalories
            } else {
                bmr = base * ree + dailyDecreaseCalories
            }
            
            return bmr
        }else{
            return 0
        }
    }
    
    func calculateAmount(){
        if let calories = self.dailyCalories {
            if calories >= 1200 &&  calories < 1500 {
                self.grainsAmount = 1.5
                self.meatsAmount = 3
                self.milkAmount = 1.5
                self.vegetablesAmount = 3
                self.fruitsAmount = 2
                self.oilsAmount = 4
            } else if calories >= 1500 &&  calories < 1800 {
                self.grainsAmount = 2.5
                self.meatsAmount = 4
                self.milkAmount = 1.5
                self.vegetablesAmount = 3
                self.fruitsAmount = 2
                self.oilsAmount = 4
            } else if calories >= 1800 &&  calories < 2000 {
                self.grainsAmount = 3
                self.meatsAmount = 5
                self.milkAmount = 1.5
                self.vegetablesAmount = 3
                self.fruitsAmount = 2
                self.oilsAmount = 5
            } else if calories >= 2000 &&  calories < 2200 {
                self.grainsAmount = 3
                self.meatsAmount = 6
                self.milkAmount = 1.5
                self.vegetablesAmount = 4
                self.fruitsAmount = 3
                self.oilsAmount = 6
            } else if calories >= 2200 &&  calories < 2500 {
                self.grainsAmount = 3.5
                self.meatsAmount = 6
                self.milkAmount = 1.5
                self.vegetablesAmount = 4
                self.fruitsAmount = 3.5
                self.oilsAmount = 6
            } else if calories >= 2500 &&  calories < 2700 {
                self.grainsAmount = 4
                self.meatsAmount = 7
                self.milkAmount = 1.5
                self.vegetablesAmount = 5
                self.fruitsAmount = 4
                self.oilsAmount = 7
            } else if calories >= 2700 {
                self.grainsAmount = 4
                self.meatsAmount = 8
                self.milkAmount = 2
                self.vegetablesAmount = 5
                self.fruitsAmount = 4
                self.oilsAmount = 8
            }
        }
    }

    
    
    
}



    
    
/*
女性REE = (10 × 體重) ＋ (6.25 × 身高) - (5 × 年齡) - 161
男性REE = (10 × 體重) ＋ (6.25 × 身高) - (5 × 年齡) ＋ 5
每天所需的熱量 = REE × 活動係數 = ＿＿(大卡)
臥床（全天） 1.2
輕活動生活模式（多坐或緩步） 1.3
一般活動度 1.5~1.75
活動量大的生活模式（重工作者） 2.0
你目前的體重是：＿＿公斤。
你的目標體重是：＿＿公斤。
你想減掉的體重 = (1) - (2) = ＿＿公斤。
減肥期間必須減少攝取的總熱量 = (3) × 7700 = ＿＿大卡。
每天必須減少攝食的熱量 = (4) ÷ 減肥期間(天) = ＿＿大卡。
減肥期間每天必須攝取的熱量 = REE × 活動係數 - (5) = ＿＿大卡。
*/
