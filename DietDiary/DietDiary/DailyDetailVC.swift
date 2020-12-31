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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        
        setInitialValue()
        
        self.dailyCaloriesSuperView.caloriesView.setLabel()
        
    }
    
    func setInitialValue() {
        
        self.dailyNutrientsSuperView.nutrientsView.dailyCaloriesLabel.text = "剩餘\(Int(MemoryData.userInfo?.dailyCalories ?? 0))大卡"
        
        //MemoryData.userInfo?.calculateAmount()
        self.dailyNutrientsSuperView.nutrientsView.grainsLabel.text = "\(MemoryData.userInfo?.grainsAmount ?? 0)份"
        self.dailyNutrientsSuperView.nutrientsView.meatsLabel.text = "\(MemoryData.userInfo?.meatsAmount ?? 0)份"
        self.dailyNutrientsSuperView.nutrientsView.milkLabel.text = "\(MemoryData.userInfo?.milkAmount ?? 0)份"
        self.dailyNutrientsSuperView.nutrientsView.vegetablesLabel.text = "\(MemoryData.userInfo?.vegetablesAmount ?? 0)份"
        self.dailyNutrientsSuperView.nutrientsView.fruitsLabel.text = "\(MemoryData.userInfo?.fruitsAmount ?? 0)份"
        self.dailyNutrientsSuperView.nutrientsView.oilsLabel.text = "\(MemoryData.userInfo?.oilsAmount ?? 0)份"
        
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
