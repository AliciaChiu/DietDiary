//
//  CalendarVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/19.
//

import UIKit
import FSCalendar
import Alamofire

protocol CalendarVCDelegate {
    func loadSelectedDateRecords(date: Date)
}

class CalendarVC: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)

    @IBOutlet weak var calendar: FSCalendar!
    
    var posts:[Post] = []
    var date: Date?
    var delegate: CalendarVCDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //calendar.locale = Locale.init(identifier: "zh_TW")

        let parameters: [String: Any] = [
            "user_unique_id": MemoryData.userInfo?.unique_id ?? "",
        ]
        
        // 呼叫API
        print(parameters)
        
        Alamofire.request(URLs.mealPostURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<PostData>) in
            
            if response.result.isSuccess {
                if let postData = response.result.value?.data{
                    print(postData)
                    self.posts = postData
                    print(self.posts)
                }
                self.calendar.reloadData()
            }
        }
    }
    
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.date = calendar.selectedDate
        //print(self.date)
        self.delegate?.loadSelectedDateRecords(date: self.date!)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:- FSCalendarDataSource
        
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        if self.gregorian.isDateInToday(date) {
            return "今日"
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        
        
        
        
        
        
        
        
        let dateStr = date.getFormattedDate(format: "yyyy-MM-dd")
        print(dateStr)
        var count = 0
        print(self.posts)
        for postDateCount in self.posts {
            print(postDateCount.date)
            
            if postDateCount.date == dateStr {
                count = (postDateCount.post_count ?? 0 > 0) ? 1 : 0  // 不管有幾篇都顯示一個點，沒有則不顯示。
            }
        }
        return count
    }
    
    // MARK:- FSCalendarDelegate
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
        
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {

        return [appearance.eventDefaultColor]
    }


    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
