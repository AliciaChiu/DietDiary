//
//  dietDiaryVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/13.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class DietDiaryVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate, NewRecordVCDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addBtn: UIButton!
    
    var records: [Record] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        self.navigationItem.hidesBackButton = true
        //self.tableView.dataSource = self
        let today = Date()
        self.title = today.getFormattedDate(format: "今天MM/dd")
        
        addBtn.layer.cornerRadius = 15.0
        addBtn.layer.masksToBounds = false
        
        obtainRecord()
        
    }
    
    func obtainRecord() {
        // 準備參數
        let parameters: [String: Any] = [
            "user_unique_id": MemoryData.userInfo?.unique_id ?? ""
            //            "start_date": profileUrl,
            //            "end_date": userName
        ]
        
        // 呼叫API
        Alamofire.request(URLs.mealRecordsURL, parameters: parameters).responseObject { (response: DataResponse<RecordData>) in
            if response.result.isSuccess {
                let recordData = response.result.value
                self.records = recordData?.data ?? []
                //let recordJSON = recordData?.toJSON()
                self.tableView.reloadData()
            }
        }
    }
    
    func didFinishUpdate(record : Record)  {
        
        obtainRecord()

//        let indexPath = IndexPath(row: self.records.count - 1, section: 1)
//        //reload tableView
//        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }

        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "diaryCell", for: indexPath) as! DiaryTableViewCell
            let mealName = self.records[indexPath.row].getMealName()
            let time = self.records[indexPath.row].date?.substring(with: 11..<16)
            cell.mealLabel.text = mealName + "  " + time!
            cell.foodPicture.image = self.records[indexPath.row].meal_images?.first?.image_content?.convertBase64StringToImage()
            if self.records[indexPath.row].note != nil {
                cell.noteTextView.text = self.records[indexPath.row].note
                cell.noteTextView.isHidden = false
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        segue.destination.preferredContentSize = CGSize(width: 390, height: 400)
        segue.destination.popoverPresentationController?.delegate = self
        
        if segue.identifier == "addSegue"{
            let newVC = segue.destination as! NewRecordVC
            newVC.delegate = self
        }
    }

    //MARK: - UIPresentationController
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
       return .none
    }

}


