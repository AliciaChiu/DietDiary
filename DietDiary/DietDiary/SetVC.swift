//
//  SetVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/17.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SetVC: UIViewController, LoginButtonDelegate {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var genderTxt: UITextField!
    
    @IBOutlet weak var birthdayTxt: UITextField!
    
    @IBOutlet weak var nowHeightTxt: UITextField!
    
    @IBOutlet weak var nowWeightTxt: UITextField!
    
    @IBOutlet weak var goalWeightTxt: UITextField!
    
    @IBOutlet weak var planTxt: UITextField!
    
    @IBOutlet weak var monthlyDecreaseTxt: UITextField!
    
    @IBOutlet weak var exerciseDegreeTxt: UITextField!
    
    @IBOutlet weak var timeNeededTxt: UITextField!
    
    @IBOutlet weak var userInfoView: UIStackView!
    
    @IBOutlet weak var nutrientsSuperView: NutrientsSuperView!
    
    @IBOutlet weak var caloriesSuperView: CaloriesSuperView!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        self.logoutBtn.layer.cornerRadius = 25.0
        
        for view in self.userInfoView.subviews {
            view.isUserInteractionEnabled = false
        }
        
        if MemoryData.userInfo?.gender == 1 {
            self.genderTxt.text = "男性"
        } else {
            self.genderTxt.text = "女性"
        }
        
        self.birthdayTxt.text = MemoryData.userInfo?.birthday
        self.nowHeightTxt.text = "\(Int(MemoryData.userInfo?.nowHeight ?? 0))公分"
        self.nowWeightTxt.text = "\(Int(MemoryData.userInfo?.nowWeight ?? 0))公斤"
        self.goalWeightTxt.text = "\(Int(MemoryData.userInfo?.goalWeight ?? 0))公斤"
        self.planTxt.text = MemoryData.userInfo?.planName
        self.monthlyDecreaseTxt.text = "\(MemoryData.userInfo?.monthlyDecrease ?? 0)公斤"
        
        if MemoryData.userInfo?.exerciseDegree == 1 {
            self.exerciseDegreeTxt.text = "低"
        } else if MemoryData.userInfo?.exerciseDegree == 2 {
            self.exerciseDegreeTxt.text = "中"
        } else if MemoryData.userInfo?.exerciseDegree == 3 {
            self.exerciseDegreeTxt.text = "高"
        }
        
        self.timeNeededTxt.text = "\(MemoryData.userInfo?.timeNeeded ?? 0)天"
        
        self.nutrientsSuperView.nutrientsView.dailyCaloriesLabel.text = "每日攝取\(Int(MemoryData.userInfo?.dailyCalories ?? 0))大卡"
        
        //MemoryData.userInfo?.calculateAmount()
        self.nutrientsSuperView.nutrientsView.grainsLabel.text = "\(MemoryData.userInfo?.grainsAmount ?? 0)份"
        self.nutrientsSuperView.nutrientsView.meatsLabel.text = "\(MemoryData.userInfo?.meatsAmount ?? 0)份"
        self.nutrientsSuperView.nutrientsView.milkLabel.text = "\(MemoryData.userInfo?.milkAmount ?? 0)份"
        self.nutrientsSuperView.nutrientsView.vegetablesLabel.text = "\(MemoryData.userInfo?.vegetablesAmount ?? 0)份"
        self.nutrientsSuperView.nutrientsView.fruitsLabel.text = "\(MemoryData.userInfo?.fruitsAmount ?? 0)份"
        self.nutrientsSuperView.nutrientsView.oilsLabel.text = "\(MemoryData.userInfo?.oilsAmount ?? 0)份"
        
        self.caloriesSuperView.caloriesView.setLabel()
        
        self.nameLabel.text = MemoryData.userInfo?.user_name
        
        
    }
    
    @IBAction func reset(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "UserInfoNav") as! UINavigationController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    

    
    @IBAction func logOut(_ sender: UIButton) {
        let manager = LoginManager()
        manager.logOut()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "LoginVC") as! UIViewController
        vc.modalPresentationStyle = .currentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {

    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {

    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
