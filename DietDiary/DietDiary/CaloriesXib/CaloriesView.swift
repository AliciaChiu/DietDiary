//
//  CaloriesView.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/19.
//

import UIKit

class CaloriesView: UIView {
    
    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var carbohydrateLabel: UILabel!
    
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var fatLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()

    }
    override func layoutSubviews() {
        super.layoutSubviews()

       
    }
    
    func setLabel() {
        self.caloriesLabel.text = "0大卡"
        self.carbohydrateLabel.text = "醣類\n0公克"
        self.proteinLabel.text = "蛋白質\n0公克"
        self.fatLabel.text = "脂肪\n0公克"
    }

    
}
