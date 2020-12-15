//
//  UserInfo.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/15.
//

import Foundation
import UIKit

enum Gender {
    case Male
    case Female
}

enum ActivityLevel {
    case LowActivity
    case MiddleActivity
    case HighActivity
}

class UserInfo {
    
    var age: String?
    var height: Double?
    var weight: Double?
    var goalWeight: Double?
    
    var monthlyDecrease: Double?
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
                } else {
                    return "增重"
                }
            }else{
                return "error"
            }
        }
    }
    
//    func setPlan() ->  {
//        if self.weight - self.goalWeight > 0 {
//            self.planName = "減重"
//        } else {
//            self.planName = "增重"
//        }
//    }
    
    func calculateBMR(weight: Double, height: Double, age: Double, activityLevel: ActivityLevel) -> Double {

        let weighPara = 10 * weight
        let heightPara = 6.25 * height
        let agePara = 5 * age
        var base = 1.3
        var ree = 0.0
        if gender == .Female {
            ree = weighPara + heightPara - agePara - 161
        } else {
            ree = weighPara + heightPara - agePara + 5
        }
    
        if activityLevel == .LowActivity {
            base = 1.3
        }else if activityLevel == .MiddleActivity {
            base = 1.4
        }else if activityLevel == .HighActivity {
            base = 1.5
        }
        
        let bmr = base * ree
        return bmr
        
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


    

