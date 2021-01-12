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
    
    var amountEatenCalories: Float!
    var amountEatenCarbohydrate: Float!
    var amountEatenProtein: Float!
    var amountEatenFat: Float!
    var amountEatenGrains: Float!
    var amountEatenMeats: Float!
    var amountEatenMilk: Float!
    var amountEatenFruits: Float!
    var amountEatenVegetables: Float!
    var amountEatenOils: Float!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.food.name
        
        self.amounTxt.delegate = self
        
        self.gramLabel.text = "\(self.food.weight!)公克"
        
        let foodCalories = self.food.calories!
        self.foodNutrientsSuperView.nutrientsView.dailyCaloriesLabel.text = "\(foodCalories)大卡"
        
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
            
            let foodThreeCalories = (carbohydrate * 4 + protein * 4 + fat * 9).rounding(toDecimal: 1)
            
            if foodThreeCalories > foodCalories {
                self.foodCaloriesSuperView.caloriesView.caloriesLabel.text = "\(foodCalories)大卡"
            }else{
                self.foodCaloriesSuperView.caloriesView.caloriesLabel.text = "\(foodThreeCalories)大卡"
            }
            
        }
    }
    
    @IBAction func addFood(_ sender: Any) {
        
        let mealRecord = MealRecord()
        mealRecord.food_name = self.food.name
        print(mealRecord.food_name)
        mealRecord.eaten_calories = self.amountEatenCalories
        mealRecord.grains = self.amountEatenGrains
        mealRecord.meats = self.amountEatenMeats
        mealRecord.oils = self.amountEatenOils
        mealRecord.milk = self.amountEatenMilk
        mealRecord.vegetables = self.amountEatenVegetables
        mealRecord.fruits = self.amountEatenFruits
        
        if let carbohydrate = self.amountEatenCarbohydrate, let protein = self.amountEatenProtein, let fat = self.amountEatenFat {
            mealRecord.threeCalories = carbohydrate * 4 + protein * 4 + fat * 9
            mealRecord.carbohydrate = carbohydrate
            mealRecord.protein = protein
            mealRecord.fat = fat
        }
        MemoryData.record.meal_records?.append(mealRecord)
        MemoryData.record.getEatenFoodDetails()
        self.navigationController?.popViewController(animated: true)
    }
}

extension FoodDetailVC: UITextFieldDelegate {
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let range = Range(range, in: text) {
            let newText = text.replacingCharacters(in: range, with: string)
            
            let amount = Float(newText) ?? 1
            let gram = food.weight ?? 0
            self.gramLabel.text = "\(amount * gram)公克"

            let eatenCalories = food.calories ?? 0
            amountEatenCalories = (amount * eatenCalories).rounding(toDecimal: 1)
            self.foodNutrientsSuperView.nutrientsView.dailyCaloriesLabel.text = "\(amountEatenCalories ?? eatenCalories)大卡"

            let carbohydrate = food.carbohydrate ?? 0
            amountEatenCarbohydrate = (amount * carbohydrate).rounding(toDecimal: 1)
            self.foodCaloriesSuperView.caloriesView.carbohydrateLabel.text = "醣類\n\(amountEatenCarbohydrate ?? carbohydrate)g"

            let protein = food.protein ?? 0
            amountEatenProtein = (amount * protein).rounding(toDecimal: 1)
            self.foodCaloriesSuperView.caloriesView.proteinLabel.text = "蛋白質\n\(amountEatenProtein ?? protein)g"

            let fat = food.fat ?? 0
            amountEatenFat = (amount * fat).rounding(toDecimal: 1)
            self.foodCaloriesSuperView.caloriesView.fatLabel.text = "脂肪\n\(amountEatenFat ?? protein)g"
            
            let threeCalories = (carbohydrate * 4) + (protein * 4) + (fat * 9)
            let amountEatenThreeCalories = (amount * threeCalories).rounding(toDecimal: 1)
            if amountEatenThreeCalories > amountEatenCalories {
                self.foodCaloriesSuperView.caloriesView.caloriesLabel.text = "\(amountEatenCalories ?? threeCalories)大卡"
            }else{
                self.foodCaloriesSuperView.caloriesView.caloriesLabel.text = "\(amountEatenThreeCalories)大卡"
            }
            
            self.food.getNutrientsAmoumt()
            let grains = self.food.grains!
            amountEatenGrains = (amount * grains).rounding(toDecimal: 1)
            self.foodNutrientsSuperView.nutrientsView.grainsLabel.text = "\(amountEatenGrains ?? grains)份"
            
            let meats = self.food.meats!
            amountEatenMeats = (amount * meats).rounding(toDecimal: 1)
            self.foodNutrientsSuperView.nutrientsView.meatsLabel.text = "\(amountEatenMeats ?? meats)份"
            
            let milk = self.food.milk!
            amountEatenMilk = (amount * milk).rounding(toDecimal: 1)
            self.foodNutrientsSuperView.nutrientsView.milkLabel.text = "\(amountEatenMilk ?? milk)份"
            
            let fruits = self.food.fruits!
            amountEatenFruits = (amount * fruits).rounding(toDecimal: 1)
            self.foodNutrientsSuperView.nutrientsView.fruitsLabel.text = "\(amountEatenFruits ?? fruits)份"
            
            let vegetables = self.food.vegetables!
            amountEatenVegetables = (amount * vegetables).rounding(toDecimal: 1)
            self.foodNutrientsSuperView.nutrientsView.vegetablesLabel.text = "\(amountEatenVegetables ?? vegetables)份"
            
            let oils = self.food.oils!
            amountEatenOils = (amount * oils).rounding(toDecimal: 1)
            self.foodNutrientsSuperView.nutrientsView.oilsLabel.text = "\(amountEatenOils ?? oils)份"
            
        }
        return true
    }
}
