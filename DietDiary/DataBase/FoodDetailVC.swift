//
//  FoodDetailVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/20.
//

import UIKit

class FoodDetailVC: UIViewController {
    
    var food: Food!

    var delegate: FoodListViewController?
    
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
        
        if let carbohydrate = self.food.carbohydrate, let protein = self.food.protein, let fat = self.food.fat {
            self.foodCaloriesSuperView.caloriesView.carbohydrateLabel.text = "醣類\n\(carbohydrate)g"
            self.foodCaloriesSuperView.caloriesView.proteinLabel.text = "蛋白質\n\(protein)g"
            self.foodCaloriesSuperView.caloriesView.fatLabel.text = "脂肪\n\(fat)g"
            self.foodCaloriesSuperView.caloriesView.caloriesLabel.text = "\(carbohydrate * 4 + protein * 4 + fat * 9)大卡"
        }
    }
    
    @IBAction func addFood(_ sender: Any) {
        
        let mealRecord = MealRecord()
        mealRecord.food_name = self.food.name
        print(mealRecord.food_name)
        mealRecord.eaten_calories = Double(self.food.calories!)
        mealRecord.grains = 1.0
        mealRecord.meats = 2.0
        mealRecord.oils = 3.0
        mealRecord.milk = 1.0
        mealRecord.vegetables = 2.0
        mealRecord.fruits = 1.0
        
        if let carbohydrate = self.food.carbohydrate, let protein = self.food.protein, let fat = self.food.fat {
            mealRecord.threeCalories = Double(carbohydrate * 4 + protein * 4 + fat * 9)
            mealRecord.carbohydrate = Double(carbohydrate)
            mealRecord.protein = Double(protein)
            mealRecord.fat = Double(fat)
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
            
            let amount = Int(newText) ?? 1
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
