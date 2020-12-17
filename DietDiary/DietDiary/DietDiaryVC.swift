//
//  dietDiaryVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/13.
//

import UIKit

class DietDiaryVC: UIViewController {
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var detailBtn: UIButton!
    
    @IBOutlet weak var eatenLabel: UILabel!
    @IBOutlet weak var totalCaloriesLabel: UILabel!
    @IBOutlet weak var grainsLabel: UILabel!
    @IBOutlet weak var meatsLabel: UILabel!
    @IBOutlet weak var oilsLabel: UILabel!
    @IBOutlet weak var milkLabel: UILabel!
    @IBOutlet weak var fruitsLabel: UILabel!
    @IBOutlet weak var vegetablesLabel: UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    
    var dailyWaterAmount: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        self.navigationItem.hidesBackButton = true
        
        self.categoryView.layer.borderWidth = 2.0
        self.categoryView.layer.borderColor = UIColor(red: 255/255, green: 167/255, blue: 38/255, alpha: 1).cgColor
        self.categoryView.clipsToBounds = true
        
        self.detailBtn.layer.cornerRadius = 20.0
        self.detailBtn.layer.shadowColor = UIColor.systemGray6.cgColor
        self.detailBtn.layer.shadowOpacity = 0.8
        self.detailBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.detailBtn.layer.masksToBounds = false
        
        self.addBtn.layer.cornerRadius = 15.0
        self.addBtn.layer.shadowColor = UIColor.lightGray.cgColor
        self.addBtn.layer.shadowOpacity = 0.8
        self.addBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.addBtn.layer.masksToBounds = false
        

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
