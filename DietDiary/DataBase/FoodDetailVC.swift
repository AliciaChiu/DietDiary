//
//  FoodDetailVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/20.
//

import UIKit

class FoodDetailVC: UIViewController {
    
    var fooddata: [String : Any]!
    
    
    
    var delegate: FoodListViewController?
    
    @IBOutlet weak var amounTxt: UITextField!
    
    @IBOutlet weak var gramLabel: UILabel!
    
    @IBOutlet weak var foodNutrientsSuperView: NutrientsSuperView!
    
    
    @IBOutlet weak var foodCaloriesSuperView: CaloriesSuperView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.amounTxt.delegate = self
        self.gramLabel.text = "\(fooddata["每單位重"] as! Int)公克"
        print(self.gramLabel.text)
        
        self.foodNutrientsSuperView.nutrientsView.eatenLabel.text = "\(fooddata["熱量"] as! Int)大卡"
        
        let carbohydrate = fooddata["總碳水化合物"] as! Int
        let protein = fooddata["粗蛋白"] as! Int
        let fat = fooddata["粗脂肪"] as! Int
        
        
        self.foodCaloriesSuperView.caloriesView.carbohydrateLabel.text = "醣類\n\(carbohydrate)g"
        self.foodCaloriesSuperView.caloriesView.proteinLabel.text = "蛋白質\n\(protein)g"
        self.foodCaloriesSuperView.caloriesView.fatLabel.text = "脂肪\n\(fat)g"
        self.foodCaloriesSuperView.caloriesView.caloriesLabel.text = "\((carbohydrate * 4) + (protein * 9) + (fat * 4))大卡"
        
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

extension FoodDetailVC: UITextFieldDelegate {
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let range = Range(range, in: text) {
            let newText = text.replacingCharacters(in: range, with: string)
            let amount = Int(newText) ?? 1
            let gram = fooddata["每單位重"] as! Int
            self.gramLabel.text = "\(amount * gram)公克"

            let eatenCalories = fooddata["熱量"] as! Int
            self.foodNutrientsSuperView.nutrientsView.eatenLabel.text = "\(amount * eatenCalories)大卡"

            let  carbohydrate = fooddata["總碳水化合物"] as! Int
            self.foodCaloriesSuperView.caloriesView.carbohydrateLabel.text = "醣類\n\(amount * carbohydrate)g"

            let  protein = fooddata["粗蛋白"] as! Int
            self.foodCaloriesSuperView.caloriesView.proteinLabel.text = "蛋白質\n\(amount * protein)g"

            let  fat = fooddata["粗脂肪"] as! Int
            self.foodCaloriesSuperView.caloriesView.fatLabel.text = "脂肪\n\(amount * fat)g"
            
            
        }
        
        return true
    }
    
}
