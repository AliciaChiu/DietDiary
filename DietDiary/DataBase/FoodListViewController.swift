//
//  FoodListViewController.swift
//  foodlist
//
//  Created by kevin on 2020/12/17.
//

import UIKit
import Alamofire
import AlamofireObjectMapper


class FoodListViewController: UIViewController, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    var foodCatogory = ""
    var foods: [Food] = []


    var searchController: UISearchController!
    var searchResults: [Food] = []
    

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.foodCatogory

        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = UIColor(red: 255/255, green: 248/255, blue: 245/255, alpha: 1)

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        if MemoryData.foods.isEmpty {
            self.activityIndicator.startAnimating()
            
            Alamofire.request(URLs.foodURL).responseObject { (response: DataResponse<FoodsData>) in
                self.activityIndicator.stopAnimating()
                
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
        self.countLabel.text = "\(MemoryData.record.meal_records!.count)"
    }
    
    
    
    func reloadFoodData() {
        self.foods = MemoryData.foods.filter { (food) -> Bool in
            return food.category == self.foodCatogory
        }
        self.tableView.reloadData()

    }
    
    func filterContent(for searchText: String) {
        searchResults = foods.filter({ (food) -> Bool in
            if let name = food.name {
                let isMatch = name.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    @IBAction func finish(_ sender: Any) {
        let index = (self.navigationController?.viewControllers.count ?? 0) - 3
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[index])!, animated: true)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foodDetailSegue" {
            if let vc = segue.destination as? FoodDetailVC, let indexPath = tableView.indexPathForSelectedRow {
                let food = (searchController.isActive) ? searchResults[indexPath.row] : self.foods[indexPath.row]
                vc.food = food
                searchController.isActive = false
            }
        }
    }
}
    



extension FoodListViewController: UITableViewDelegate, UITableViewDataSource {  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        
        let food = (searchController.isActive) ? searchResults[indexPath.row] : self.foods[indexPath.row]

        cell.textLabel?.text = food.name
        cell.detailTextLabel?.text = "\(food.category!),每份重\(food.weight!)公克,\(food.calories!)大卡"
        
        if MemoryData.record.foodNames.contains(food.name ?? "") {
            cell.accessoryType = .checkmark
            self.countLabel.text = "\(MemoryData.record.meal_records!.count)"
            print(MemoryData.record.meal_records!.count)
        }else{
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive {
            return searchResults.count
        } else {
            return self.foods.count
        }
    }
}
