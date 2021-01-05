//
//  UserInfoOneVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/10.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import FBSDKCoreKit
import FBSDKLoginKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "基本資料"
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        self.finishBtn.layer.cornerRadius = 25.0

        self.weightTxt.delegate = self
        self.goalWeightTxt.delegate = self
        self.heightTxt.delegate = self

        if let profile = Profile.current {
            MemoryData.userInfo?.unique_id = profile.userID
        }

        
    }
    
   
    @IBAction func birthday(_ sender: UIDatePicker) {
        MemoryData.userInfo?.birthday = sender.date.getFormattedDate(format: "yyyy-MM-dd")
    }
    
    @IBOutlet weak var monthlyLabel: UILabel!
    
    @IBAction func monthlyDecreaseValueChanged(_ sender: UIStepper) {
        MemoryData.userInfo?.monthlyDecrease = Float(sender.value)
        self.monthlyLabel.text = "\(sender.value)"
        
        MemoryData.userInfo?.calculateTimeNeeded()
        self.timeNeededLabel.text = "\(Int(MemoryData.userInfo?.timeNeeded ?? 0))天"
        
        MemoryData.userInfo?.calculateBMR()
        self.dailyCaloriesLabel.text = "\(Int(MemoryData.userInfo?.dailyCalories ?? 0))大卡"

    }
    
    @IBAction func genderMayTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            MemoryData.userInfo?.gender = Gender.Male.rawValue
        case 1:
            MemoryData.userInfo?.gender = Gender.Female.rawValue
        default:
            MemoryData.userInfo?.gender = Gender.Male.rawValue
        }
        
        MemoryData.userInfo?.calculateBMR()
        self.dailyCaloriesLabel.text = "\(Int(MemoryData.userInfo?.dailyCalories ?? 0) ?? 0)大卡"

    }
    
    @IBAction func exerciseMayTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            MemoryData.userInfo?.exerciseDegree = ExerciseDegree.LowActivity.rawValue
        case 1:
            MemoryData.userInfo?.exerciseDegree = ExerciseDegree.MiddleActivity.rawValue
        case 2:
            MemoryData.userInfo?.exerciseDegree = ExerciseDegree.HighActivity.rawValue
        default:
            print("Please choose an activity level. ")
        }
        
        MemoryData.userInfo?.calculateBMR()
        self.dailyCaloriesLabel.text = "\(Int(MemoryData.userInfo?.dailyCalories ?? 0))大卡"
  
    }
    
    @IBAction func finishUserInfo(_ sender: Any) {
        
        // 準備登入資料
        let parameters: [String: Any] = [
            "unique_id": MemoryData.userInfo?.unique_id ?? "",
            "profile_url": MemoryData.userInfo?.profile_url ?? "",
            "user_name": MemoryData.userInfo?.user_name ?? "",
            "gender": MemoryData.userInfo?.gender ?? 1,
            "birthday": MemoryData.userInfo?.birthday ?? "",
            "nowHeight": MemoryData.userInfo?.nowHeight ?? 0,
            "nowWeight": MemoryData.userInfo?.nowWeight ?? 0,
            "goalWeight": MemoryData.userInfo?.goalWeight ?? 0,
            "monthlyDecrease": MemoryData.userInfo?.monthlyDecrease ?? 1,
            "exerciseDegree": MemoryData.userInfo?.exerciseDegree ?? 1
        ]
        
        // 呼叫API
        //self.indicatorView.startAnimating()
        print(parameters)
        
        Alamofire.request(URLs.userInfoURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<UserInfoData>) in
            
            //self.indicatorView.stopAnimating()
            print(response.result.value)
            if response.result.isSuccess {
                let userInfoData = response.result.value
                MemoryData.userInfo = userInfoData?.data
                MemoryData.userInfo?.calculateAmount()
            }
        }
    }
    

    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserInfoSegue" {
            if let vc = segue.destination as? DietDiaryVC {
             
            }
        }
    }
}

extension UserInfoVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let range = Range(range, in: text) {
            let newText = text.replacingCharacters(in: range, with: string)
            
            if textField == self.weightTxt {
                MemoryData.userInfo?.nowWeight = Float(newText)
            }else if textField == self.goalWeightTxt {
                MemoryData.userInfo?.goalWeight = Float(newText)
            }else if textField == self.heightTxt {
                MemoryData.userInfo?.nowHeight = Float(newText)
            }
            if !(MemoryData.userInfo?.planName.isEmpty ?? true) {
                self.planLabel.text = MemoryData.userInfo?.planName
            }
            
            MemoryData.userInfo?.calculateTimeNeeded()
            self.timeNeededLabel.text = "\(Int(MemoryData.userInfo?.timeNeeded ?? 0))天"
            
            MemoryData.userInfo?.calculateBMR()
            self.dailyCaloriesLabel.text = "\(Int(MemoryData.userInfo?.dailyCalories ?? 0) )大卡"
        }
        return true
    }
}




