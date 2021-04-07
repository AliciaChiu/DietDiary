//
//  URLS.swift
//  foodlist
//
//  Created by Alicia on 2020/12/26.
//

import Foundation

struct URLs {
    
    static var domain = "https://dietdiary.tw"
    
    static let categoryURL = "\(URLs.domain)/api/categories"
    
    static let foodURL = "\(URLs.domain)/api/foods"
    
    static let userInfoURL = "\(URLs.domain)/api/userinfos"
    
    static let mealRecordsURL = "\(URLs.domain)/api/meal_records"

    static let mealPostURL = "\(URLs.domain)/api/meal_post_counts"
}
