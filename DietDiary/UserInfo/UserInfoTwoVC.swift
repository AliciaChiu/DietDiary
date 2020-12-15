//
//  UserInfoTwoVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/11.
//

import UIKit

class UserInfoTwoVC: UIViewController {


    @IBOutlet weak var planLabel: UILabel!

    @IBOutlet weak var goalWeighLabel: UILabel!
    
    @IBOutlet weak var timeNeededLabel: UILabel!
    
    @IBOutlet weak var dailyCaloriesLabel: UILabel!
    
    @IBOutlet weak var dailyWaterTxt: UITextField!
    
    @IBOutlet weak var finishBtn: UIButton!
    
    var userInfo: UserInfo!
    
    @IBAction func finish(_ sender: Any) {
       performSegue(withIdentifier: "UserInfoTwoSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.finishBtn.layer.cornerRadius = 15.0
        self.planLabel.text = self.userInfo.planName
        self.goalWeighLabel.text = "\(self.userInfo.goalWeight!)"
        
        guard let weight2 = self.userInfo.weight, let height2 = self.userInfo.height else {
            assertionFailure("Fail to enter user information.")
            return
        }
        let activityLevel = self.userInfo.activityLevel
        self.dailyCaloriesLabel.text = "\(self.userInfo.calculateBMR(weight: weight2, height: height2, age: 29.0, activityLevel: activityLevel))"
       
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserInfoTwoSegue" {
            if let vc = segue.destination as? DietDiaryVC {
                
            }
        }
       
    }
        

        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


