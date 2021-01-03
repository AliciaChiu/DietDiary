//
//  Extensions.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/27.
//

import Foundation
import UIKit

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
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func convertBase64StringToImage () -> UIImage? {
        let imageData = Data.init(base64Encoded: self, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image
    }
}

//extension UITextField {
//
//
//
//    func datePicker<T>(target: T,
//                       doneAction: Selector,
//                       cancelAction: Selector,
//                       datePickerMode: UIDatePicker.Mode = .date) {
//
//        let screenWidth = UIScreen.main.bounds.width
//
//        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
//            let buttonTarget = style == .flexibleSpace ? nil : target
//            let action: Selector? = {
//                switch style {
//                case .cancel:
//                    return cancelAction
//                case .done:
//                    return doneAction
//                default:
//                    return nil
//                }
//            }()
//
//            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
//                                                target: buttonTarget,
//                                                action: action)
//
//            return barButtonItem
//        }
//
//        let datePicker = UIDatePicker(frame: CGRect(x: 0,
//                                                    y: 0,
//                                                    width: screenWidth,
//                                                    height: 216))
//        datePicker.datePickerMode = datePickerMode
//        datePicker.preferredDatePickerStyle = .wheels
//        self.inputView = datePicker
//
//        let toolBar = UIToolbar(frame: CGRect(x: 0,
//                                              y: 0,
//                                              width: screenWidth,
//                                              height: 44))
//        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
//                          buttonItem(withSystemItemStyle: .flexibleSpace),
//                          buttonItem(withSystemItemStyle: .done)],
//                         animated: true)
//        self.inputAccessoryView = toolBar
//        
//    }
//
//
//}
