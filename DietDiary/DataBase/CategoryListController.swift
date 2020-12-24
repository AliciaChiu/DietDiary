//
//  ViewController.swift
//  foodlist
//
//  Created by kevin on 2020/12/17.
//

import UIKit

class CategoryListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var finishAddBtn: UIButton!
    
    var categories: [String] = []
    var allData: [String: [String: Any]]  =  [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        self.finishAddBtn.layer.cornerRadius = 15.0
        
        self.title = "食物資料庫"
        self.allData = self.read_json(fileName: "data") as! [String: [String: Any]]
        self.categories = self.read_json(fileName: "categories") as! [String]
        //self.categories = Array(self.allData.keys).sorted()
        self.tableView.reloadData()
    }
    
    func read_json(fileName: String) -> Any{
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//                if let jsonResult = jsonResult as? [String: [String: Any]] {
//                    return jsonResult
//                }
                return jsonResult
            } catch {
               // handle error
            }
        }
        return [:]
    }
    
    @IBAction func finishAdd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foodListSegue" {
            if let vc = segue.destination as? FoodListViewController, let indexPath = tableView.indexPathForSelectedRow {
                    let category = self.categories[indexPath.row]
                    if let cate_food_data = self.allData[category] as? [String: [String: Any]] {
//                        print("選擇了 \(category)")
//                        print("資料有 \(cate_food_data)")
                        vc.foods = cate_food_data
                    }
                }
            }
        }
    
    
    
    
    
}


extension CategoryListController: UITableViewDelegate, UITableViewDataSource {

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCatogoryCell", for: indexPath)
        cell.textLabel?.text = self.categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
}

