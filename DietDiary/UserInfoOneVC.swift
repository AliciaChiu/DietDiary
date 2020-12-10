//
//  UserInfoOneVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/10.
//

import UIKit

class UserInfoOneVC: UIViewController {

    @IBOutlet weak var genderView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "基本資料"
        genderView.layer.cornerRadius = 15.0
        genderView.layer.borderWidth = 2.0
        genderView.layer.borderColor = UIColor(red: 245/255, green: 215/255, blue: 223/255, alpha: 1).cgColor
        genderView.clipsToBounds = true
        
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
