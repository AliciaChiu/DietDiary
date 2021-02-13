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
    var amountEatenGrains: Float!
    var amountEatenMeats: Float!
    var amountEatenMilk: Float!
    var amountEatenFruits: Float!
    var amountEatenVegetables: Float!
    var amountEatenOils: Float!
    
    var amountEatenCarbohydrate: Float!
    var amountEatenProtein: Float!
    var amountEatenFat: Float!
    var amountEatenThreeCalories: Float!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.food.name
        
        self.amounTxt.delegate = self
        
        self.gramLabel.text = "\(self.food.weight!)公克"
        
        amountEatenCalories = self.food.calories!
        self.foodNutrientsSuperView.nutrientsView.dailyCaloriesLabel.text = "\(amountEatenCalories ?? 0)大卡"
        
        self.food.getNutrientsAmoumt()
        amountEatenGrains = self.food.grains!
        self.foodNutrientsSuperView.nutrientsView.grainsLabel.text = "\(amountEatenGrains.rounding(toDecimal: 1))份"
        
        amountEatenMeats = self.food.meats!
        self.foodNutrientsSuperView.nutrientsView.meatsLabel.text = "\(amountEatenMeats.rounding(toDecimal: 1))份"
        
        amountEatenMilk = self.food.milk!
        self.foodNutrientsSuperView.nutrientsView.milkLabel.text = "\(amountEatenMilk.rounding(toDecimal: 1))份"
        
        amountEatenFruits = self.food.fruits!
        self.foodNutrientsSuperView.nutrientsView.fruitsLabel.text = "\(amountEatenFruits.rounding(toDecimal: 1))份"
        
        amountEatenVegetables = self.food.vegetables!
        self.foodNutrientsSuperView.nutrientsView.vegetablesLabel.text = "\(amountEatenVegetables.rounding(toDecimal: 1))份"
        
        amountEatenOils = self.food.oils!
        self.foodNutrientsSuperView.nutrientsView.oilsLabel.text = "\(amountEatenOils.rounding(toDecimal: 1))份"
        
        amountEatenCarbohydrate = self.food.carbohydrate
        self.foodCaloriesSuperView.caloriesView.carbohydrateLabel.text = "醣類\n\(amountEatenCarbohydrate.rounding(toDecimal: 1))g"
        
        amountEatenProtein = self.food.protein!
        self.foodCaloriesSuperView.caloriesView.proteinLabel.text = "蛋白質\n\(amountEatenProtein.rounding(toDecimal: 1))g"
        
        amountEatenFat = self.food.fat
        self.foodCaloriesSuperView.caloriesView.fatLabel.text = "脂肪\n\(amountEatenFat.rounding(toDecimal: 1))g"
        
        let carbohydrate = amountEatenCarbohydrate * 4
        let protein = amountEatenProtein * 4
        let fat = amountEatenFat * 9
        amountEatenThreeCalories = carbohydrate + protein + fat
        
        if amountEatenThreeCalories > amountEatenCalories {
            self.foodCaloriesSuperView.caloriesView.caloriesLabel.text = "\(amountEatenCalories ?? 0)大卡"
        }else{
            self.foodCaloriesSuperView.caloriesView.caloriesLabel.text = "\(amountEatenThreeCalories.rounding(toDecimal: 1))大卡"
        }
        
    }
    
    @IBAction func addFood(_ sender: Any) {
        
        let mealRecord = MealRecord()
        mealRecord.food_name = self.food.name
        //print(mealRecord.food_name)
        mealRecord.eaten_calories = self.amountEatenCalories
        //print(mealRecord.eaten_calories)
        mealRecord.grains = self.amountEatenGrains
        mealRecord.meats = self.amountEatenMeats
        mealRecord.oils = self.amountEatenOils
        mealRecord.milk = self.amountEatenMilk
        mealRecord.vegetables = self.amountEatenVegetables
        mealRecord.fruits = self.amountEatenFruits
        
        mealRecord.threeCalories = amountEatenThreeCalories
        mealRecord.carbohydrate = amountEatenCarbohydrate
        mealRecord.protein = amountEatenProtein
        mealRecord.fat = amountEatenFat
        
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
            
            

            let carbohydrate = food.carbohydrate ?? 0
            amountEatenCarbohydrate = (amount * carbohydrate).rounding(toDecimal: 1)
            self.foodCaloriesSuperView.caloriesView.carbohydrateLabel.text = "醣類\n\(amountEatenCarbohydrate ?? carbohydrate)g"

            let protein = food.protein ?? 0
            amountEatenProtein = (amount * protein).rounding(toDecimal: 1)
            self.foodCaloriesSuperView.caloriesView.proteinLabel.text = "蛋白質\n\(amountEatenProtein ?? protein)g"

            let fat = food.fat ?? 0
            amountEatenFat = (amount * fat).rounding(toDecimal: 1)
            self.foodCaloriesSuperView.caloriesView.fatLabel.text = "脂肪\n\(amountEatenFat ?? fat)g"
            
            let threeCalories = (carbohydrate * 4) + (protein * 4) + (fat * 9)
            amountEatenThreeCalories = (amount * threeCalories).rounding(toDecimal: 1)
            if amountEatenThreeCalories > amountEatenCalories {
                self.foodCaloriesSuperView.caloriesView.caloriesLabel.text = "\(amountEatenCalories ?? eatenCalories)大卡"
            }else{
                self.foodCaloriesSuperView.caloriesView.caloriesLabel.text = "\(amountEatenThreeCalories ?? threeCalories)大卡"
            }
            

            
        }
        return true
    }
}
