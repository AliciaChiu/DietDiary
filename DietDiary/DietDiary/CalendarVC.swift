//
//  CalendarVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/19.
//

import UIKit

protocol CalendarVCDelegate {
    func loadSelectedDateRecords(date: Date)
}

class CalendarVC: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var date: Date?
    
    var delegate: CalendarVCDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        datePicker.date = self.date ?? Date()
    }
    
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func selectDate(_ sender: UIDatePicker) {

        self.date = sender.date
        print(self.date)
        self.delegate?.loadSelectedDateRecords(date: self.date!)
        self.dismiss(animated: true, completion: nil)
        
        

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
