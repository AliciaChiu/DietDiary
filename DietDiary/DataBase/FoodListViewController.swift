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
        // Do any additional setup after loading the view.
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

extension FoodListViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let foodName = self.foodNames[indexPath.row]
//        if let food_data = self.foods[foodName] {
//            print("選擇了 \(foodName)")
//            print("資料有 \(food_data)")
//            let vc = self.storyboard?.instantiateViewController(identifier: "FoodDetailVC") as! FoodDetailVC
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        cell.textLabel?.text = self.foodNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foodNames.count
    }
}
