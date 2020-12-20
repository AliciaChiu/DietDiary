//
//  NewRecordVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/17.
//

import UIKit

class NewRecordVC: UIViewController {
    
    
    @IBOutlet weak var dayView: UIView!
    
    @IBOutlet weak var timeView: UIView!
    
    
    @IBOutlet weak var addView: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        self.dayView.layer.cornerRadius = 10.0
        self.timeView.layer.cornerRadius = 10.0
        self.addView.layer.cornerRadius = 10.0
        
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
