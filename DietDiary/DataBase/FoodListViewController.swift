//
//  FoodListViewController.swift
//  foodlist
//
//  Created by kevin on 2020/12/17.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

protocol FoodListViewControllerDelegate {
    func addNewFood()
}

class FoodListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var foodCatogory = ""
    var foods: [Food] = []
    var selectedFoods: [Food] = []
    var delegate: FoodListViewControllerDelegate?
    

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        self.title = self.foodCatogory
        
        if MemoryData.foods.isEmpty {
            Alamofire.request(URLs.foodURL).responseObject { (response: DataResponse<FoodsData>) in
                if response.result.isSuccess {
                    let foodsData = response.result.value
                    MemoryData.foods = foodsData?.data ?? []
                    self.reloadFoodData()
                }
            }
        }else{
            self.reloadFoodData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    func reloadFoodData() {
        self.foods = MemoryData.foods.filter { (food) -> Bool in
            return food.category == self.foodCatogory
        }
        self.tableView.reloadData()
        //indicatorView.stopAnimating()
    }
    
    @IBAction func finish(_ sender: Any) {
        let index = (self.navigationController?.viewControllers.count ?? 0) - 3
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[index])!, animated: true)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foodDetailSegue" {
            if let vc = segue.destination as? FoodDetailVC, let indexPath = tableView.indexPathForSelectedRow {
                let food = self.foods[indexPath.row]
                vc.food = food
            }
        }
    }
}
    



extension FoodListViewController: UITableViewDelegate, UITableViewDataSource {  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        cell.textLabel?.text = self.foods[indexPath.row].name
        
        let food = self.foods[indexPath.row]
        cell.detailTextLabel?.text = "\(food.category!),每份重\(food.weight!)公克,\(food.calories!)大卡"
        
        if MemoryData.record.foodNames.contains(food.name ?? "") {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .disclosureIndicator
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foods.count
    }
}
