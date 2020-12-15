//
//  UserInfoOneVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/10.
//

import UIKit

class UserInfoOneVC: UIViewController {
    
    @IBOutlet weak var ageTxt: UITextField!

    @IBOutlet weak var heightTxt: UITextField!

    @IBOutlet weak var weighTxt: UITextField!
    
    @IBOutlet weak var goalWeighTxt: UITextField!
    
    @IBOutlet weak var nextStepBtn: UIButton!
    
    //var userInfo: UserInfo?
    
    
    
    @IBAction func nextStep(_ sender: Any) {
    }
    
    
    @IBAction func exerciseMayTypeChanged(_ sender: UISegmentedControl) {
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
                //計畫目標
                guard let weighNum = Double(self.weighTxt.text ?? "0"), let goalWeighNum = Double(self.goalWeighTxt.text ?? "0") else {
                    return
                }
                if (weighNum - goalWeighNum > 0) {
                    vc.planName = "減重"
                } else {
                    vc.planName = "增重"
                }
                
                //目標體重
                vc.goalWeigh = self.goalWeighTxt.text
  /*
                //每日熱量
                func caculateCalories(type: Gender.GenderType) {
                    guard let heightNum = Double(self.heightTxt.text ?? "0"), let ageNum = Double(self.ageTxt.text ?? "0") else {
                        return
                    }
                    let weighPara = 10 * weighNum
                    let heightPara = 6.25 * heightNum
                    let agePara = 5 * ageNum
                    if type == .male {
                        let maleREE = weighPara + heightPara - agePara + 5
                    }  else {
                        let femaleREE = weighPara + heightPara - agePara - 161
                    }
                    
                    
                }
         */
                
            }
        }
    }
}

//class UserInfo {
//
//    var age: Int?
//    var height: Int?
//    var weigh: Int?
//    var goalWeigh: Int?
//
//
//
//}

