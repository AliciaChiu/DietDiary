//
//  UserInfo.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/15.
//

import Foundation
import UIKit

class UserInfo {
    
    static let shared = UserInfo()
    
    private init(){}
    
    var age: String?
    var height: Double?
    var weight: Double?
    var goalWeight: Double?
    
    var monthlyDecreaseWeight: Double = 0.0
    var timeNeeded: Double?
    var dailyCalories: Double?
    var dailyWater: Double?
    
    var gender: Gender = .Female
    var activityLevel: ActivityLevel = .LowActivity
    
    var planName: String {
        get {
            if let weight = self.weight, let goalWeight = self.goalWeight {
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
    
    func caculateAge() -> Double {
        return 29.0
    }
    
    func caculateTimeNeeded(weight: Double, goalWeight: Double, monthlyDecreaseWeight: Double) -> Double {
        
        let hopeLost = weight - goalWeight
        let day = (hopeLost / monthlyDecreaseWeight) * 30
        return day
        
    }
    
    func calculateBMR(weight: Double, goalWeight: Double, height: Double, age: Double, activityLevel: ActivityLevel) -> Double {

        let weighPara = 10 * weight
        let heightPara = 6.25 * height
        let agePara = 5 * age
        var base = 1.3
        var ree = 0.0
        var bmr = 0.0
        
        if gender == .Female {
            ree = weighPara + heightPara - agePara - 161
        } else {
            ree = weighPara + heightPara - agePara + 5
        }
    
        if activityLevel == .LowActivity {
            base = 1.3
        }else if activityLevel == .MiddleActivity {
            base = 1.5
        }else if activityLevel == .HighActivity {
            base = 1.7
        }
        
        let monthlyDecreaseWeight = self.monthlyDecreaseWeight
        
        let dailyDecreaseCalories = monthlyDecreaseWeight * 7700 / 30
        
        if weight - goalWeight > 0 {
            bmr = base * ree - dailyDecreaseCalories
        } else {
            bmr = base * ree + dailyDecreaseCalories
        }
        return bmr
    }
}
    
enum Gender {
    case Male
    case Female
}

enum ActivityLevel {
    case LowActivity
    case MiddleActivity
    case HighActivity
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


    

