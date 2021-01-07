//
//  DetailVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/17.
//

import UIKit

class DailyDetailVC: UIViewController {
    
    
    @IBOutlet weak var dailyNutrientsSuperView: NutrientsSuperView!
    
    @IBOutlet weak var dailyCaloriesSuperView: CaloriesSuperView!
    
    let userInfoCalories = MemoryData.userInfo?.dailyCalories ?? 0
    let userInfoGrains = MemoryData.userInfo?.grainsAmount ?? 0
    let userInfoMeats = MemoryData.userInfo?.meatsAmount ?? 0
    let userInfoMilk = MemoryData.userInfo?.milkAmount ?? 0
    let userInfoVegetables = MemoryData.userInfo?.vegetablesAmount ?? 0
    let userInfoFruits = MemoryData.userInfo?.fruitsAmount ?? 0
    let userInfoOils = MemoryData.userInfo?.oilsAmount ?? 0
    
    var dailyTotalCalories: Float = 0.0
    var dailyTotalGrains: Float = 0.0
    var dailyTotalMeats: Float = 0.0
    var dailyTotalOils: Float = 0.0
    var dailyTotalMilk: Float = 0.0
    var dailyTotalVegetables: Float = 0.0
    var dailyTotalFruits: Float = 0.0
    var dailyTotalThreeCalories: Float = 0.0
    var dailyTotalCarbohydrate: Float = 0.0
    var dailyTotalProtein: Float = 0.0
    var dailyTotalFat: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        
        setInitialValue()
        
        //self.dailyCaloriesSuperView.caloriesView.setLabel()
        
    }
    
    func setInitialValue() {
        
        let userInfoCalories = self.userInfoCalories.rounding(toDecimal: 1)
        let dailyTotalCalories = self.dailyTotalCalories.rounding(toDecimal: 1)
        self.dailyNutrientsSuperView.nutrientsView.dailyCaloriesLabel.text = "已攝取\(dailyTotalCalories)大卡\n剩餘\(userInfoCalories - dailyTotalCalories)大卡"
        

        self.dailyNutrientsSuperView.nutrientsView.grainsLabel.text = "\(self.dailyTotalGrains.rounding(toDecimal: 1))份/\(self.userInfoGrains)份"
        self.dailyNutrientsSuperView.nutrientsView.meatsLabel.text = "\(self.dailyTotalMeats.rounding(toDecimal: 1))份/\(self.userInfoMeats)份"
        self.dailyNutrientsSuperView.nutrientsView.milkLabel.text = "\(self.dailyTotalMilk.rounding(toDecimal: 1))份/\(self.userInfoMilk)份"
        self.dailyNutrientsSuperView.nutrientsView.vegetablesLabel.text = "\(self.dailyTotalVegetables.rounding(toDecimal: 1))份/\(self.userInfoVegetables)份"
        self.dailyNutrientsSuperView.nutrientsView.fruitsLabel.text = "\(self.dailyTotalFruits.rounding(toDecimal: 1))份/\(self.userInfoFruits)份"
        self.dailyNutrientsSuperView.nutrientsView.oilsLabel.text = "\(self.dailyTotalOils.rounding(toDecimal: 1))份/\(self.userInfoOils)份"
        
        let dailyTotalThreeCalories = self.dailyTotalThreeCalories.rounding(toDecimal: 1)
        if dailyTotalThreeCalories > dailyTotalCalories {
            self.dailyCaloriesSuperView.caloriesView.caloriesLabel.text = "\(dailyTotalCalories)大卡"
        }else{
            self.dailyCaloriesSuperView.caloriesView.caloriesLabel.text = "\(dailyTotalThreeCalories)大卡"
        }
        
        self.dailyCaloriesSuperView.caloriesView.carbohydrateLabel.text = "醣類\n\(self.dailyTotalCarbohydrate.rounding(toDecimal: 1))公克"
        self.dailyCaloriesSuperView.caloriesView.proteinLabel.text = "蛋白質\n\(self.dailyTotalProtein.rounding(toDecimal: 1))公克"
        self.dailyCaloriesSuperView.caloriesView.fatLabel.text = "脂肪\n\(self.dailyTotalFat.rounding(toDecimal: 1))公克"
        
    }
}
