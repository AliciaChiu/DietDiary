//
//  Extensions.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/27.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

extension String {
    // 從字串轉換成Date
    func getDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_TW") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = format
        return dateFormatter.date(from:self)
    }
    
    func calculateAge(format: String) -> Int {
        let birthdayDate = self.getDate(format: format) // 從字串轉換成Date
        
        // 計算年齡
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        
        // 回傳
        return age ?? 1
    }
}
