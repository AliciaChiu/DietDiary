//
//  UserInfoOneVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/10.
//

import UIKit

class UserInfoOneVC: UIViewController {

    @IBOutlet weak var genderView: UserInfoView!
    
    @IBOutlet weak var birthdayView: UserInfoView!
    
    @IBOutlet weak var heightView: UserInfoView!
    @IBOutlet weak var heightTxt: UITextField!
    
    @IBOutlet weak var weighView: UserInfoView!
    @IBOutlet weak var weighTxt: UITextField!
    
    @IBOutlet weak var goalWeighView: UserInfoView!
    @IBOutlet weak var goalWeighTxt: UITextField!
    
    @IBOutlet weak var exerciseView: UserInfoView!
    
    @IBOutlet weak var nextStepBtn: UIButton!
    @IBAction func nextStep(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "基本資料"
        self.nextStepBtn.layer.cornerRadius = 15.0


        
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
