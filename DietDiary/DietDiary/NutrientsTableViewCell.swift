//
//  NutrientsTableViewCell.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/18.
//

import UIKit

class NutrientsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dailyNutrientsSuperView: NutrientsSuperView!
    
    @IBOutlet weak var detailBtn: UIButton!

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        //displayValue()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        detailBtn.layer.cornerRadius = 15.0
        detailBtn.layer.shadowColor = UIColor.systemGray6.cgColor
        detailBtn.layer.shadowOpacity = 0.8
        detailBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        detailBtn.layer.masksToBounds = false
    }

    
    func displayNutrientsValue(){
        
        self.dailyNutrientsSuperView.nutrientsView.eatenLabel.text = "剩餘\(Int(MemoryData.userInfo?.dailyCalories ?? 0))大卡"
        
        MemoryData.userInfo?.caculateAmount()
        self.dailyNutrientsSuperView.nutrientsView.grainsLabel.text = "\(MemoryData.userInfo?.grainsAmount ?? 0)份"
        self.dailyNutrientsSuperView.nutrientsView.meatsLabel.text = "\(MemoryData.userInfo?.meatsAmount ?? 0)份"
        self.dailyNutrientsSuperView.nutrientsView.milkLabel.text = "\(MemoryData.userInfo?.milkAmount ?? 0)份"
        self.dailyNutrientsSuperView.nutrientsView.vegetablesLabel.text = "\(MemoryData.userInfo?.vegetablesAmount ?? 0)份"
        self.dailyNutrientsSuperView.nutrientsView.fruitsLabel.text = "\(MemoryData.userInfo?.fruitsAmount ?? 0)份"
        self.dailyNutrientsSuperView.nutrientsView.oilsLabel.text = "\(MemoryData.userInfo?.oilsAmount ?? 0)份"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
