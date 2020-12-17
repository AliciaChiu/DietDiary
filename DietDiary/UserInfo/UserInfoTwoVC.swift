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
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        
        self.finishBtn.layer.cornerRadius = 15.0
        self.planLabel.text = self.userInfo.planName
        self.goalWeighLabel.text = "\(Int(self.userInfo.goalWeight!))"
        self.dailyCaloriesLabel.text = "\(Int(self.userInfo.dailyCalories!))"
 
/*
        guard let weight = self.userInfo.weight, let goalWeight: self.userInfo.goalWeight else {
            assertionFailure("")
            return
        }
        let timeNeeded = self.userInfo.caculateTimeNeeded(weight: weight , goalWeight: goalWeight, monthlyDecreaseWeight: 1)
        self.timeNeededLabel.text = "\(Int(timeNeeded!))天"
 */
        
       
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserInfoTwoSegue" {
            if let dietDiaryVC = segue.destination as? DietDiaryVC {
                
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


