//
//  UserInfoOneVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/10.
//

import UIKit

class UserInfoVC: UIViewController {
    
    @IBOutlet weak var genderSC: UISegmentedControl!
    
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    @IBOutlet weak var heightTxt: UITextField!

    @IBOutlet weak var weightTxt: UITextField!
    
    @IBOutlet weak var goalWeightTxt: UITextField!
    
    @IBOutlet weak var planLabel: UILabel!
    
    @IBOutlet weak var exerciseSC: UISegmentedControl!
    
    @IBOutlet weak var timeNeededLabel: UILabel!
    
    @IBOutlet weak var dailyCaloriesLabel: UILabel!
    
    @IBOutlet weak var finishBtn: UIButton!
    
    var userInfo = UserInfo()
    
    
    @IBAction func genderMayTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            userInfo.gender = .Male
        case 1:
            userInfo.gender = .Female
        default:
            print("Please choose your gender. ")
        }
    }
    
    @IBAction func exerciseMayTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            userInfo.activityLevel = .LowActivity
        case 1:
            userInfo.activityLevel = .MiddleActivity
        case 2:
            userInfo.activityLevel = .HighActivity
        default:
            print("Please choose an activity level. ")
        }
    }
    
    @IBAction func finish(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "基本資料"
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        self.finishBtn.layer.cornerRadius = 15.0
       
//        self.finishBtn.layer.cornerRadius = 15.0
//        self.planLabel.text = self.userInfo.planName
//        self.goalWeighLabel.text = "\(Int(self.userInfo.goalWeight ?? 0))"
//        self.dailyCaloriesLabel.text = "\(Int(self.userInfo.dailyCalories ?? 0))"
        
        /*
                guard let weight = self.userInfo.weight, let goalWeight: self.userInfo.goalWeight else {
                    assertionFailure("")
                    return
                }
                let timeNeeded = self.userInfo.caculateTimeNeeded(weight: weight , goalWeight: goalWeight, monthlyDecreaseWeight: 1)
                self.timeNeededLabel.text = "\(Int(timeNeeded!))天"
         */
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserInfoSegue" {
            if let secondVC = segue.destination as? DietDiaryVC {
//                self.userInfo.height = Double(self.heightTxt.text ?? "")
//                self.userInfo.weight = Double(self.weightTxt.text ?? "")
//                self.userInfo.goalWeight = Double(self.goalWeightTxt.text ?? "")
//                
//                guard let weight = self.userInfo.weight, let height = self.userInfo.height, let goalWeight = self.userInfo.goalWeight else {
//                     assertionFailure("Fail to enter user information.")
//                    return
//                }
//                let activityLevel = self.userInfo.activityLevel
//                userInfo.dailyCalories = self.userInfo.calculateBMR(weight: weight, goalWeight: goalWeight, height: height, age: 29.0, activityLevel: activityLevel)
//
//                
                secondVC.userInfo = self.userInfo
                
            }
        }
    }
}



