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
    
    @IBOutlet weak var birthdayTxt: UITextField!
    
    @IBOutlet weak var heightTxt: UITextField!

    @IBOutlet weak var weightTxt: UITextField!
    
    @IBOutlet weak var goalWeightTxt: UITextField!
    
    @IBOutlet weak var planLabel: UILabel!
    
    @IBOutlet weak var monthlyLabel: UILabel!
    
    @IBOutlet weak var exerciseSC: UISegmentedControl!
    
    @IBOutlet weak var timeNeededLabel: UILabel!
    
    @IBOutlet weak var dailyCaloriesLabel: UILabel!
    
    @IBOutlet weak var finishBtn: UIButton!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "基本資料"
//        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)

        if MemoryData.userInfo?.nowHeight != 0 {
            if MemoryData.userInfo?.gender == 1 {
                self.genderSC.selectedSegmentIndex = 0
            } else {
                self.genderSC.selectedSegmentIndex = 1
            }
            
            self.birthdayTxt.text = MemoryData.userInfo?.birthday
            self.heightTxt.text = "\(Int(MemoryData.userInfo?.nowHeight ?? 0))"
            self.weightTxt.text = "\(Int(MemoryData.userInfo?.nowWeight ?? 0))"
            self.goalWeightTxt.text = "\(Int(MemoryData.userInfo?.goalWeight ?? 0))"
            self.planLabel.text = MemoryData.userInfo?.planName
            self.monthlyLabel.text = "\(MemoryData.userInfo?.monthlyDecrease ?? 0)"
            
            if MemoryData.userInfo?.exerciseDegree == 1 {
                self.exerciseSC.selectedSegmentIndex = 0
            } else if MemoryData.userInfo?.exerciseDegree == 2 {
                self.exerciseSC.selectedSegmentIndex = 1
            } else if MemoryData.userInfo?.exerciseDegree == 3 {
                self.exerciseSC.selectedSegmentIndex = 2
            }
            
            self.timeNeededLabel.text = "\(MemoryData.userInfo?.timeNeeded ?? 0)天"
            
            self.dailyCaloriesLabel.text = "\((Float(MemoryData.userInfo?.dailyCalories ?? 0)).rounding(toDecimal: 1))大卡"
        }
        self.finishBtn.layer.cornerRadius = 25.0

        self.weightTxt.delegate = self
        self.goalWeightTxt.delegate = self
        self.heightTxt.delegate = self

        if let profile = Profile.current {
            MemoryData.userInfo?.unique_id = profile.userID
        }

        createDatePicker()
        
    }

    func createDatePicker() {
        
        birthdayTxt.textAlignment = .center
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneAction))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelAction))
        toolbar.setItems([cancelBtn, flexibleSpace, doneBtn], animated: true)
        
        //assign toolbar
        self.birthdayTxt.inputAccessoryView = toolbar
        
        //assign date picker to the text field.
        self.birthdayTxt.inputView = datePicker
        
        //date picker mode
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
    }
    
    @IBAction func detailDisclose(_ sender: Any) {
        
        let alertController = UIAlertController(title: "活動程度", message: "低：每週運動1~2天\n中：每週運動3~5天\n高：每週運動6~7天", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "我知道了", style: .default) { (action) in
            alertController.resignFirstResponder()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)

    }
    
    @objc func doneAction() {
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "zh_TW")
        
        birthdayTxt.text = formatter.string(from: datePicker.date)
        MemoryData.userInfo?.birthday = birthdayTxt.text
        self.view.endEditing(true)
    }
    
    @objc func cancelAction() {
        self.birthdayTxt.resignFirstResponder()
    }
    
    
    @IBAction func monthlyDecreaseValueChanged(_ sender: UIStepper) {
        MemoryData.userInfo?.monthlyDecrease = Float(sender.value)
        self.monthlyLabel.text = "\(sender.value)"
        
        MemoryData.userInfo?.calculateTimeNeeded()
        self.timeNeededLabel.text = "\(Int(MemoryData.userInfo?.timeNeeded ?? 0))天"
        
        MemoryData.userInfo?.calculateBMR()
        self.dailyCaloriesLabel.text = "\((Float(MemoryData.userInfo?.dailyCalories ?? 0)).rounding(toDecimal: 1))大卡"

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
        self.dailyCaloriesLabel.text = "\((Float(MemoryData.userInfo?.dailyCalories ?? 0)).rounding(toDecimal: 1))大卡"

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
            MemoryData.userInfo?.exerciseDegree = ExerciseDegree.LowActivity.rawValue
        }
        
        MemoryData.userInfo?.calculateBMR()
        self.dailyCaloriesLabel.text = "\((Float(MemoryData.userInfo?.dailyCalories ?? 0)).rounding(toDecimal: 1))大卡"
  
    }
    
    @IBAction func finishUserInfo(_ sender: Any) {
        
        let height = self.heightTxt.text ?? ""
        let weight = self.weightTxt.text ?? ""
        let goalWeight = self.goalWeightTxt.text ?? ""
    
        if !height.isEmpty && !weight.isEmpty && !goalWeight.isEmpty {
            
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
            print(parameters)
            
            Alamofire.request(URLs.userInfoURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<UserInfoData>) in
                
                print(response.result.value)
                if response.result.isSuccess {
                    let userInfoData = response.result.value
                    MemoryData.userInfo = userInfoData?.data
                    MemoryData.userInfo?.calculateAmount()
                    
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let vc = sb.instantiateViewController(identifier: "DietDiaryVC") as! DietDiaryVC
                    vc.modalPresentationStyle = .currentContext
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        } else {
            let alertController = UIAlertController(title: nil, message: "還有資料沒填寫完畢喔！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "填資料去～", style: .default) { (action) in
                alertController.resignFirstResponder()
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        

    }
    

    

    
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "UserInfoSegue" {
//            if let vc = segue.destination as? DietDiaryVC {
//             
//            }
//        }
//    }
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




