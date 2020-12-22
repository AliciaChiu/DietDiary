//
//  ViewController.swift
//  foodlist
//
//  Created by kevin on 2020/12/17.
//

import UIKit

class CategoryListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var categories:  [String] = []
    var allData: [String: [String: Any]]  =  [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "食物資料庫"
        self.allData = self.read_json(fileName: "data")
        self.categories = Array(self.allData.keys).sorted()
        self.tableView.reloadData()
    }
    func read_json(fileName: String) -> [String: [String: Any]]{
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String: [String: Any]] {
                    return jsonResult
                }
            } catch {
               // handle error
            }
        }
        return [:]
    }
}


extension CategoryListController: UITableViewDelegate, UITableViewDataSource {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foodListSegue" {
            if let vc = segue.destination as? FoodListViewController, let indexPath = tableView.indexPathForSelectedRow {
                    let category = self.categories[indexPath.row]
                    if let cate_food_data = self.allData[category] as? [String: [String: Any]] {
                        print("選擇了 \(category)")
                        print("資料有 \(cate_food_data)")
                        vc.foods = cate_food_data
                    }
                }
            }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCatogoryCell", for: indexPath)
        cell.textLabel?.text = self.categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
}

