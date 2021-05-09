//
//  DatabaseViewController.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2021/4/24.
//

import UIKit

class DatabaseViewController: UIViewController {

    @IBOutlet weak var foodDatabaseContainerView: UIView!
    @IBOutlet weak var cuatomFoodContainerView: UIView!
    @IBOutlet weak var foodDatabseBtn: UIButton!
    @IBOutlet weak var customFoodBtn: UIButton!
    
    //var selectView = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 245/255, alpha: 1)
        self.title = "新增食物"
        foodDatabseBtn.layer.cornerRadius = 15.0
        foodDatabseBtn.layer.masksToBounds = false
        customFoodBtn.layer.cornerRadius = 15.0
        customFoodBtn.layer.masksToBounds = false
        
        foodDatabaseContainerView.isHidden = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(moveToCustomFoodPage(noti:)), name: NSNotification.Name("customFoodData"), object: nil)
    }
    
    
    @IBAction func showfoodDatabase(_ sender: Any) {
        pageChange(enablePage: cuatomFoodContainerView)
    }
    
    
    
    @IBAction func showCustomPage(_ sender: Any) {
        pageChange(enablePage: foodDatabaseContainerView)
    }
    

    
    func pageChange(enablePage: UIView){

        enablePage.isHidden = !enablePage.isHidden
//        if enablePage.isHidden {
//            enablePage.isHidden = false
//        }else{
//            enablePage.isHidden = true
//        }
        

    }
    
    @objc func moveToCustomFoodPage(noti: Notification){
        pageChange(enablePage: cuatomFoodContainerView)
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
