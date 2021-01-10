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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var records: [Record] = []
    
    let userInfoCalories = MemoryData.userInfo?.dailyCalories ?? 0
    let userInfoGrains = MemoryData.userInfo?.grainsAmount ?? 0
    let userInfoMeats = MemoryData.userInfo?.meatsAmount ?? 0
    let userInfoMilk = MemoryData.userInfo?.milkAmount ?? 0
    let userInfoVegetables = MemoryData.userInfo?.vegetablesAmount ?? 0
    let userInfoFruits = MemoryData.userInfo?.fruitsAmount ?? 0
    let userInfoOils = MemoryData.userInfo?.oilsAmount ?? 0
    
    var dailyTotalCalories: Float = 0.0
    var dailyTotalGrains: Float = 0.0
    var dailyTotalMeats: Float = 0.0
    var dailyTotalOils: Float = 0.0
    var dailyTotalMilk: Float = 0.0
    var dailyTotalVegetables: Float = 0.0
    var dailyTotalFruits: Float = 0.0
    var dailyTotalThreeCalories: Float = 0.0
    var dailyTotalCarbohydrate: Float = 0.0
    var dailyTotalProtein: Float = 0.0
    var dailyTotalFat: Float = 0.0
    
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        self.navigationItem.hidesBackButton = true
        
        // default
        self.title = self.date.getFormattedDate(format: "今天MM/dd")
        
        self.tableView.separatorStyle = .none
        
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
        
        let dateString = self.date.getFormattedDate(format: "yyyy-MM-dd")
        let todayString = Date().getFormattedDate(format: "yyyy-MM-dd")
        if  dateString == todayString {
            self.title = self.date.getFormattedDate(format: "今天MM/dd")
        }else{
            self.title = self.date.getFormattedDate(format: "MM/dd")
        }
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
        
        self.activityIndicator.startAnimating()
        
        // 呼叫API
        Alamofire.request(URLs.mealRecordsURL, parameters: parameters).responseObject { (response: DataResponse<RecordData>) in
            self.activityIndicator.stopAnimating()
            if response.result.isSuccess {
                let recordData = response.result.value
                self.records = recordData?.data ?? []
                
                self.getDailyTotalAmount()
                //let recordJSON = recordData?.toJSON()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARk: - Get daily total amounts.
    func getDailyTotalAmount() {
        
        dailyTotalCalories = 0.0
        dailyTotalGrains = 0.0
        dailyTotalMeats = 0.0
        dailyTotalOils = 0.0
        dailyTotalMilk = 0.0
        dailyTotalVegetables = 0.0
        dailyTotalFruits = 0.0
        dailyTotalThreeCalories = 0.0
        dailyTotalCarbohydrate = 0.0
        dailyTotalProtein = 0.0
        dailyTotalFat = 0.0
  
        for record in self.records {
            
            record.getEatenFoodDetails()
            dailyTotalCalories = dailyTotalCalories + record.eatenCalories
            dailyTotalGrains = dailyTotalGrains + record.eatenGrains
            dailyTotalMeats = dailyTotalMeats + record.eatenMeats
            dailyTotalOils = dailyTotalOils + record.eatenOils
            dailyTotalMilk = dailyTotalMilk + record.eatenMilk
            dailyTotalVegetables = dailyTotalVegetables + record.eatenVegetables
            dailyTotalFruits = dailyTotalFruits + record.eatenFruits
            dailyTotalThreeCalories = dailyTotalThreeCalories + record.eatenThreeCalories
            dailyTotalCarbohydrate = dailyTotalCarbohydrate + record.eatenCarbohydrate
            dailyTotalProtein = dailyTotalProtein + record.eatenProtein
            dailyTotalFat = dailyTotalFat + record.eatenFat
            
        }
    }
    
    // MARK: - NewRecordVCDelegate Method
    
    func didFinishUpdate(record : Record)  {
        obtainRecord()
    }

    // MARK: - CalendarVCDelegate Method
    
    func loadSelectedDateRecords(date: Date) {
        self.date = date
        let dateString = self.date.getFormattedDate(format: "yyyy-MM-dd")
        let todayString = Date().getFormattedDate(format: "yyyy-MM-dd")
        if  dateString == todayString {
            self.title = self.date.getFormattedDate(format: "今天MM/dd")
        }else{
            self.title = self.date.getFormattedDate(format: "MM/dd")
        }
        obtainRecord()
    }

    // MARK: - Delete records
    func deleteRecods(record: Record) {
     
        // 準備參數
        let parameters: [String: Any] = [
            "id": record.id ?? 0,
        ]
        print("parameters", parameters)
        // 呼叫API
        self.activityIndicator.startAnimating()
        Alamofire.request(URLs.mealRecordsURL, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<BaseResponseData>) in
            self.activityIndicator.stopAnimating()
            //print(response.result.value)
            if response.result.isSuccess {
                let index = self.records.firstIndex(of: record)
                self.records.remove(at: index ?? 0 )
                
                self.getDailyTotalAmount()
                self.tableView.reloadData()
                print("刪除ok")
            }
        }
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
        } else if segue.identifier == "detailSegue"{
            let newVC = segue.destination as! DailyDetailVC
            newVC.dailyTotalCalories = self.dailyTotalCalories
            newVC.dailyTotalGrains = self.dailyTotalGrains
            newVC.dailyTotalMeats = self.dailyTotalMeats
            newVC.dailyTotalOils = self.dailyTotalOils
            newVC.dailyTotalMilk = self.dailyTotalMilk
            newVC.dailyTotalVegetables = self.dailyTotalVegetables
            newVC.dailyTotalFruits = self.dailyTotalFruits
            newVC.dailyTotalThreeCalories = self.dailyTotalThreeCalories
            newVC.dailyTotalCarbohydrate = self.dailyTotalCarbohydrate
            newVC.dailyTotalProtein = self.dailyTotalProtein
            newVC.dailyTotalFat = self.dailyTotalFat
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

            if self.dailyTotalCalories > self.userInfoCalories {
                cell.dailyNutrientsSuperView.nutrientsView.dailyCaloriesLabel.textColor = .red
            }else{
                cell.dailyNutrientsSuperView.nutrientsView.dailyCaloriesLabel.textColor = .black
            }
            cell.dailyNutrientsSuperView.nutrientsView.dailyCaloriesLabel.text = "已攝取\(self.dailyTotalCalories.rounding(toDecimal: 1))大卡\n剩餘\((self.userInfoCalories - self.dailyTotalCalories).rounding(toDecimal: 1))大卡"
            
            cell.dailyNutrientsSuperView.nutrientsView.grainsLabel.text = "\(self.dailyTotalGrains.rounding(toDecimal: 1))份/\(self.userInfoGrains)份"
            cell.dailyNutrientsSuperView.nutrientsView.meatsLabel.text = "\(self.dailyTotalMeats.rounding(toDecimal: 1))份/\(self.userInfoMeats)份"
            cell.dailyNutrientsSuperView.nutrientsView.milkLabel.text = "\(self.dailyTotalMilk.rounding(toDecimal: 1))份/\(self.userInfoMilk)份"
            cell.dailyNutrientsSuperView.nutrientsView.vegetablesLabel.text = "\(self.dailyTotalVegetables.rounding(toDecimal: 1))份/\(self.userInfoVegetables)份"
            cell.dailyNutrientsSuperView.nutrientsView.fruitsLabel.text = "\(self.dailyTotalFruits.rounding(toDecimal: 1))份/\(self.userInfoFruits)份"
            cell.dailyNutrientsSuperView.nutrientsView.oilsLabel.text = "\(self.dailyTotalOils.rounding(toDecimal: 1))份/\(self.userInfoOils)份"
            return cell
        } else {
            let data = self.records[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "diaryCell", for: indexPath) as! DiaryTableViewCell
            cell.loadCellContent(data)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

// MARK: - DiaryTableViewCellDelegate

extension DietDiaryVC: DiaryTableViewCellDelegate {

    func editting(record: Record) {
        
        let alertController = UIAlertController(title: nil, message: "我想要", preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "編輯紀錄", style: .default) { (action) in
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "NewRecordVC") as! NewRecordVC
            vc.modalPresentationStyle = .currentContext
            self.navigationController?.pushViewController(vc, animated: true)
            vc.delegate = self
            vc.record = record
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            alertController.resignFirstResponder()
        }
        let deleteAction = UIAlertAction(title: "刪除紀錄", style: .destructive) { (action) in
            let deleteAlertController = UIAlertController(title: "確定要刪除此筆紀錄嗎？", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確定", style: .default) { (action) in
                self.deleteRecods(record: record)
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                deleteAlertController.resignFirstResponder()
            }
            deleteAlertController.addAction(okAction)
            deleteAlertController.addAction(cancelAction)
            self.present(deleteAlertController, animated: true, completion: nil)

        }
        alertController.addAction(editAction)
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
