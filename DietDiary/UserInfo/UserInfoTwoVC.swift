//
//  UserInfoTwoVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/11.
//

import UIKit

class UserInfoTwoVC: UIViewController {

    @IBOutlet weak var planView: UserInfoView!
    @IBOutlet weak var planLabel: UILabel!
    var planName: String?

    
    
    @IBOutlet weak var goalWeighView: UserInfoView!
    @IBOutlet weak var goalWeighLabel: UILabel!
    var goalWeigh: String?
    
    
    @IBOutlet weak var monthlyDecreaseView: UIView!
    
    @IBOutlet weak var timeNeededView: UserInfoView!
    @IBOutlet weak var timeNeededLabel: UILabel!
    
    @IBOutlet weak var dailyCaloriesView: UserInfoView!
    @IBOutlet weak var dailyCaloriesLabel: UILabel!
    
    @IBOutlet weak var dailyWaterView: UserInfoView!
    @IBOutlet weak var dailyWaterTxt: UITextField!
    
    @IBOutlet weak var finishBtn: UIButton!
    
    @IBAction func finish(_ sender: Any) {
       performSegue(withIdentifier: "UserInfoTwoSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.finishBtn.layer.cornerRadius = 15.0
        self.goalWeighLabel.text = self.goalWeigh
        self.planLabel.text = self.planName
        
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


