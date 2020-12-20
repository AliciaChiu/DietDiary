//
//  DataBaseOneVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/20.
//

import UIKit

class DataBaseOneVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCatogoryCell", for: indexPath)
        cell.textLabel?.text = "kjkkjk"
        cell.detailTextLabel?.text = "jjkjkk"
        return cell
        
    }
    

    @IBOutlet weak var finishBtn: UIButton!
    
    @IBAction func finishAdd(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        
        finishBtn.layer.cornerRadius = 15.0
        finishBtn.layer.masksToBounds = false

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
