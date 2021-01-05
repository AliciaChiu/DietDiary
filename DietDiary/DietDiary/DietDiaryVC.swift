//
//  dietDiaryVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/13.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class DietDiaryVC: UIViewController, UIPopoverPresentationControllerDelegate, NewRecordVCDelegate, CalendarVCDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var records: [Record] = []
    
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        self.navigationItem.hidesBackButton = true
        
        // default
        self.title = self.date.getFormattedDate(format: "今天MM/dd")
        
        addBtn.layer.cornerRadius = 15.0
        addBtn.layer.masksToBounds = false
        
        obtainRecord()
        
    }
    
    // MARK: - Get Weekday.
    
    @IBAction func weekdayMayChanged(_ sender: UISegmentedControl) {
        
        let now_index = self.date.getWeekdayIndex()
        print(sender.selectedSegmentIndex, "-", now_index)
        if sender.selectedSegmentIndex == now_index {
            return
        }
        
        let day_diff = sender.selectedSegmentIndex - now_index
        
        var dateComponent = DateComponents()
        dateComponent.day = day_diff
        self.date = Calendar.current.date(byAdding: dateComponent, to: self.date)!
        self.title = self.date.getFormattedDate(format: "MM/dd")
        obtainRecord()
    }
    
    //MARK: Call API, obtain records.
    
    func obtainRecord() {
        
        segmentedControl.selectedSegmentIndex = self.date.getWeekdayIndex()
        
        // 準備參數
        let parameters: [String: Any] = [
            "user_unique_id": MemoryData.userInfo?.unique_id ?? "",
            "start_date": self.date.getFormattedDate(format: "yyyy-MM-dd"),
            "end_date": self.date.getFormattedDate(format: "yyyy-MM-dd 23:59:59")
        ]
        print("parameters", parameters)
        // 呼叫API
        Alamofire.request(URLs.mealRecordsURL, parameters: parameters).responseObject { (response: DataResponse<RecordData>) in
            if response.result.isSuccess {
                let recordData = response.result.value
                self.records = recordData?.data ?? []
                print("get records length => \(self.records.count)")

                //let recordJSON = recordData?.toJSON()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - NewRecordVCDelegate Method
    
    func didFinishUpdate(record : Record)  {
        obtainRecord()
    }

    // MARK: - CalendarVCDelegate Method
    
    func loadSelectedDateRecords(date: Date) {
        self.date = date
        self.title = self.date.getFormattedDate(format: "MM/dd")
        obtainRecord()
    }
    


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        segue.destination.preferredContentSize = CGSize(width: 390, height: 400)
        segue.destination.popoverPresentationController?.delegate = self
        
        if segue.identifier == "addSegue"{
            let newVC = segue.destination as! NewRecordVC
            newVC.delegate = self
        } else if segue.identifier == "calendarSegue"{
            let newVC = segue.destination as! CalendarVC
            newVC.delegate = self
            newVC.date = self.date
        }
    }

    //MARK: - UIPresentationController
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
       return .none
    }

}

extension DietDiaryVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return self.records.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientsCell", for: indexPath) as! NutrientsTableViewCell
            cell.displayNutrientsValue()
            return cell
        } else {
            let data = self.records[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "diaryCell", for: indexPath) as! DiaryTableViewCell
            let mealName = data.getMealName()
            let time = data.date?.substring(with: 11..<16)
            cell.mealLabel.text = mealName + "  " + time!
            let image = data.meal_images?.first?.image_content?.convertBase64StringToImage()
            
            if image != nil {
                cell.foodLabel.isHidden = true
                cell.foodPicture.image = image
            } else {
                cell.foodLabel.isHidden = false
                var foodNames = ""
                data.getEatenFoodDetails()
                for t in data.foodNames {
                    foodNames = foodNames + "\n" + t
                }
                print(foodNames)
                cell.foodLabel.text = foodNames
            }
            
            if data.note != nil {
                cell.noteTextView.text = self.records[indexPath.row].note
                cell.noteTextView.isHidden = false
            }else{
                cell.noteTextView.text = nil
                cell.noteTextView.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
