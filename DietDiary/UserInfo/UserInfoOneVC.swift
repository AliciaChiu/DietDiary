//
//  UserInfoOneVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/10.
//

import UIKit

class UserInfoOneVC: UIViewController {
    

    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    @IBOutlet weak var heightTxt: UITextField!

    @IBOutlet weak var weightTxt: UITextField!
    
    @IBOutlet weak var goalWeightTxt: UITextField!
    
    @IBOutlet weak var nextStepBtn: UIButton!
    
    var userInfo = UserInfo()
    
    @IBAction func nextStep(_ sender: Any) {
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "基本資料"
        self.nextStepBtn.layer.cornerRadius = 15.0
       

    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserInfoOneSegue" {
            if let vc = segue.destination as? UserInfoTwoVC {
                userInfo.height = Double(self.heightTxt.text ?? "")
                userInfo.weight = Double(self.weightTxt.text ?? "")
                userInfo.goalWeight = Double(self.goalWeightTxt.text ?? "")
                
                vc.userInfo = self.userInfo
                
                
            }
        }
    }
}



