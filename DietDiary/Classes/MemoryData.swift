//
//  Data.swift
//  foodlist
//
//  Created by Kevin on 2020/12/26.
//

import Foundation

class MemoryData {
    static var foods: [Food] = []
    static var userInfo: UserInformation?
    static var record = Record()
    
}




//        let myDatePicker = UIDatePicker()
//        myDatePicker.datePickerMode = .time
//        myDatePicker.date = Date()
//
//        // 設置 UIDatePicker 改變日期時會執行動作的方法
//        myDatePicker.addTarget(
//        self,
//        action: #selector(self.datePickerChanged),
//        for: .valueChanged)
//        // 將 UITextField 原先鍵盤的視圖更換成 UIDatePicker
//        timeTxt.inputView = myDatePicker
//        timeTxt.tag = 200

//    @objc func datePickerChanged(datePicker:UIDatePicker) {
//            // 依據元件的 tag 取得 UITextField
//            let myTextField =
//                self.view?.viewWithTag(200) as? UITextField
//            // 將 UITextField 的值更新為新的日期
////            myTextField?.text =
////                formatter.string(from: datePicker.date)
//        }
