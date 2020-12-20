//
//  dietDiaryVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/13.
//

import UIKit

class DietDiaryVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var addBtn: UIButton!
    
    var diary: [Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        self.navigationItem.hidesBackButton = true
        //self.tableView.dataSource = self

        
        addBtn.layer.cornerRadius = 15.0
        addBtn.layer.masksToBounds = false
        
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return 1 //self.diary.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "nutrientsCell", for: indexPath) as! NutrientsTableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "diaryCell", for: indexPath) as! DiaryTableViewCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        segue.destination.preferredContentSize = CGSize(width: 390, height: 400)
        segue.destination.popoverPresentationController?.delegate = self
    }

    //MARK: - UIPresentationController
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
       return .none
    }

}
