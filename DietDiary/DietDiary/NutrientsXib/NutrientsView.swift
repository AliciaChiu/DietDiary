//
//  NutrientsView.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/18.
//

import UIKit

class NutrientsView: UIView {
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var dailyCaloriesLabel: UILabel!
    @IBOutlet weak var grainsLabel: UILabel!
    @IBOutlet weak var meatsLabel: UILabel!
    @IBOutlet weak var oilsLabel: UILabel!
    @IBOutlet weak var milkLabel: UILabel!
    @IBOutlet weak var fruitsLabel: UILabel!
    @IBOutlet weak var vegetablesLabel: UILabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
        
//        categoryView.layer.borderWidth = 2.0
//        categoryView.layer.borderColor = UIColor(red: 255/255, green: 167/255, blue: 38/255, alpha: 1).cgColor
//        categoryView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryView.layer.cornerRadius = 100
//        categoryView.layer.borderWidth = 2.0
//        categoryView.layer.borderColor = UIColor(red: 255/255, green: 167/255, blue: 38/255, alpha: 1).cgColor
//        self.sendSubviewToBack(categoryView)
       
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    

//

}
