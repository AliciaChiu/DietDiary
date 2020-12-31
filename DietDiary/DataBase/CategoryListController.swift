//
//  ViewController.swift
//  foodlist
//
//  Created by kevin on 2020/12/17.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

protocol CategoryListControllerDelegate {
    func addNewFood()
}

class CategoryListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var finishAddBtn: UIButton!
    
    var categories: [Category] = []
    
    var delegate: CategoryListControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        self.finishAddBtn.layer.cornerRadius = 15.0
        self.title = "食物資料庫"
        
        Alamofire.request(URLs.categoryURL).responseObject { (response: DataResponse<CategoriesData>) in
            if response.result.isSuccess {
                let categoriesData = response.result.value
                self.categories = categoriesData?.data ?? []
                self.tableView.reloadData()
            }
        }
    }

   
    @IBAction func finishAdd(_ sender: Any) {
        self.delegate?.addNewFood()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foodListSegue" {
            if let vc = segue.destination as? FoodListViewController, let indexPath = tableView.indexPathForSelectedRow {
                vc.foodCatogory = self.categories[indexPath.row].category_name ?? ""
            
            }
        }
    }
}


extension CategoryListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCatogoryCell", for: indexPath)
        cell.textLabel?.text = self.categories[indexPath.row].category_name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
}

