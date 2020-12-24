//
//  FoodListViewController.swift
//  foodlist
//
//  Created by kevin on 2020/12/17.
//

import UIKit

class FoodListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var foods: [String: [String: Any]] = [:] {
        didSet {
            self.foodNames = Array(self.foods.keys).sorted()
        }
    }
    var foodNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foodDetailSegue" {
            if let vc = segue.destination as? FoodDetailVC, let indexPath = tableView.indexPathForSelectedRow {
                let foodName = self.foodNames[indexPath.row]
                if let food_data = self.foods[foodName] {
                    print("選擇了 \(foodName)")
                    print("資料有 \(food_data)")
                    
                }
            }
        }
    }
}
    



extension FoodListViewController: UITableViewDelegate, UITableViewDataSource {  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        cell.textLabel?.text = self.foodNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foodNames.count
    }
}
