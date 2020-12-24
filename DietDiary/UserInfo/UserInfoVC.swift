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
    
   
    @IBAction func birthday(_ sender: UIDatePicker) {
        print(sender.date)
    }
    
    @IBOutlet weak var monthlyLabel: UILabel!
    
    @IBAction func monthlyDecreaseValueChanged(_ sender: UIStepper) {
        UserInfo.shared.monthlyDecreaseWeight = sender.value
        self.monthlyLabel.text = "\(sender.value)"
        if let weight = UserInfo.shared.weight, let goalWeight = UserInfo.shared.goalWeight, UserInfo.shared.monthlyDecreaseWeight != 0.0 {
            let monthlyDecreaseWeight = UserInfo.shared.monthlyDecreaseWeight
            let timeNeed = UserInfo.shared.caculateTimeNeeded(weight: weight, goalWeight: goalWeight, monthlyDecreaseWeight: monthlyDecreaseWeight)
            self.timeNeededLabel.text = "\(timeNeed)天"
        }
    }
    
    @IBAction func genderMayTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserInfo.shared.gender = .Male
        case 1:
            UserInfo.shared.gender = .Female
        default:
            print("Please choose your gender. ")
        }
    }
    
    @IBAction func exerciseMayTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserInfo.shared.activityLevel = .LowActivity
        case 1:
            UserInfo.shared.activityLevel = .MiddleActivity
        case 2:
            UserInfo.shared.activityLevel = .HighActivity
        default:
            print("Please choose an activity level. ")
        }
    }
    
    @IBAction func finishUserInfo(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "基本資料"
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        self.finishBtn.layer.cornerRadius = 15.0

        self.weightTxt.delegate = self
        self.goalWeightTxt.delegate = self
        
       
        //self.birthdayPicker.locale = Locale.current
        //self.dailyCaloriesLabel.text = "\(Int(UserInfo.shared.dailyCalories ?? 0))"
        
 
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserInfoSegue" {
            if let secondVC = segue.destination as? DietDiaryVC {

       
                

                
            }
        }
    }
}

extension UserInfoVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.weightTxt {
            UserInfo.shared.weight = Double(textField.text ?? "")
        }else if textField == self.goalWeightTxt {
            UserInfo.shared.goalWeight = Double(textField.text ?? "")
        }else if textField == self.heightTxt {
            UserInfo.shared.height = Double(textField.text ?? "")
        }
        if !UserInfo.shared.planName.isEmpty {
            self.planLabel.text = UserInfo.shared.planName
        }
        if let weight = UserInfo.shared.weight, let goalWeight = UserInfo.shared.goalWeight, UserInfo.shared.monthlyDecreaseWeight != 0.0 {
            let monthlyDecreaseWeight = UserInfo.shared.monthlyDecreaseWeight
            let timeNeed = UserInfo.shared.caculateTimeNeeded(weight: weight, goalWeight: goalWeight, monthlyDecreaseWeight: monthlyDecreaseWeight)
            self.timeNeededLabel.text = "\(timeNeed)天"
        }
        if let weight = UserInfo.shared.weight, let goalWeight = UserInfo.shared.goalWeight, let height = UserInfo.shared.height {
            let activityLevel = UserInfo.shared.activityLevel
            UserInfo.shared.dailyCalories = UserInfo.shared.calculateBMR(weight: weight, goalWeight: goalWeight, height: height, age: 29.0, activityLevel: activityLevel)
            self.dailyCaloriesLabel.text = "\(UserInfo.shared.dailyCalories)"
        }

        return true
    }
}




