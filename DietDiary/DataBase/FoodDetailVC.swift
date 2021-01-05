//
//  FoodDetailVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/20.
//

import UIKit

class FoodDetailVC: UIViewController {
    
    var food: Food!
    
    @IBOutlet weak var amounTxt: UITextField!
    
    @IBOutlet weak var gramLabel: UILabel!
    
    @IBOutlet weak var foodNutrientsSuperView: NutrientsSuperView!
    
    @IBOutlet weak var foodCaloriesSuperView: CaloriesSuperView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.food.name
        
        self.amounTxt.delegate = self
        
        self.gramLabel.text = "\(self.food.weight!)公克"
        self.foodNutrientsSuperView.nutrientsView.dailyCaloriesLabel.text = "\(self.food.calories!)大卡"
        
        self.food.getNutrientsAmoumt()
        self.foodNutrientsSuperView.nutrientsView.grainsLabel.text = "\(self.food.grains!.rounding(toDecimal: 1))份"
        self.foodNutrientsSuperView.nutrientsView.meatsLabel.text = "\(self.food.meats!.rounding(toDecimal: 1))份"
        self.foodNutrientsSuperView.nutrientsView.milkLabel.text = "\(self.food.milk!.rounding(toDecimal: 1))份"
        self.foodNutrientsSuperView.nutrientsView.fruitsLabel.text = "\(self.food.fruits!.rounding(toDecimal: 1))份"
        self.foodNutrientsSuperView.nutrientsView.vegetablesLabel.text = "\(self.food.vegetables!.rounding(toDecimal: 1))份"
        self.foodNutrientsSuperView.nutrientsView.oilsLabel.text = "\(self.food.oils!.rounding(toDecimal: 1))份"
        
        if let carbohydrate = self.food.carbohydrate, let protein = self.food.protein, let fat = self.food.fat {
            self.foodCaloriesSuperView.caloriesView.carbohydrateLabel.text = "醣類\n\(carbohydrate.rounding(toDecimal: 1))g"
            self.foodCaloriesSuperView.caloriesView.proteinLabel.text = "蛋白質\n\(protein.rounding(toDecimal: 1))g"
            self.foodCaloriesSuperView.caloriesView.fatLabel.text = "脂肪\n\(fat.rounding(toDecimal: 1))g"
            self.foodCaloriesSuperView.caloriesView.caloriesLabel.text = "\((carbohydrate * 4 + protein * 4 + fat * 9).rounding(toDecimal: 1))大卡"
        }
    }
    
    @IBAction func addFood(_ sender: Any) {
        
        let mealRecord = MealRecord()
        mealRecord.food_name = self.food.name
        print(mealRecord.food_name)
        mealRecord.eaten_calories = self.food.calories!
        mealRecord.grains = self.food.grains
        mealRecord.meats = self.food.meats
        mealRecord.oils = self.food.oils
        mealRecord.milk = self.food.milk
        mealRecord.vegetables = self.food.vegetables
        mealRecord.fruits = self.food.fruits
        
        if let carbohydrate = self.food.carbohydrate, let protein = self.food.protein, let fat = self.food.fat {
            mealRecord.threeCalories = carbohydrate * 4 + protein * 4 + fat * 9
            mealRecord.carbohydrate = carbohydrate
            mealRecord.protein = protein
            mealRecord.fat = fat
        }
        MemoryData.record.meal_records?.append(mealRecord)
        //print(MemoryData.record.meal_records)
        MemoryData.record.getEatenFoodDetails()
        self.navigationController?.popViewController(animated: true)
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
            
            let amount = Float(newText) ?? 1
            let gram = food.weight ?? 0
            self.gramLabel.text = "\(amount * gram)公克"

            let eatenCalories = food.calories ?? 0
            self.foodNutrientsSuperView.nutrientsView.dailyCaloriesLabel.text = "\(amount * eatenCalories)大卡"

            let  carbohydrate = food.carbohydrate ?? 0
            self.foodCaloriesSuperView.caloriesView.carbohydrateLabel.text = "醣類\n\(amount * carbohydrate)g"

            let  protein = food.protein ?? 0
            self.foodCaloriesSuperView.caloriesView.proteinLabel.text = "蛋白質\n\(amount * protein)g"

            let  fat = food.fat ?? 0
            self.foodCaloriesSuperView.caloriesView.fatLabel.text = "脂肪\n\(amount * fat)g"
            
            let threeCalories = (carbohydrate * 4) + (protein * 4) + (fat * 9)
            self.foodCaloriesSuperView.caloriesView.caloriesLabel.text = "\(amount * threeCalories)大卡"
    
        }
        return true
    }
}
