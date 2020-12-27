//
//  SetVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/17.
//

import UIKit

class SetVC: UIViewController {
    
    @IBOutlet weak var genderTxt: UITextField!
    
    @IBOutlet weak var birthdayTxt: UITextField!
    
    @IBOutlet weak var nowHeightTxt: UITextField!
    
    @IBOutlet weak var nowWeightTxt: UITextField!
    
    @IBOutlet weak var goalWeightTxt: UITextField!
    
    @IBOutlet weak var planTxt: UITextField!
    
    @IBOutlet weak var monthlyDecreaseTxt: UITextField!
    
    @IBOutlet weak var exerciseDegreeTxt: UITextField!
    
    @IBOutlet weak var timeNeededTxt: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        
        for view in self.view.subviews {
            view.isUserInteractionEnabled = false
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

}
