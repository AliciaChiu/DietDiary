//
//  UserInfoTwoVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/11.
//

import UIKit

class UserInfoTwoVC: UIViewController {

    var planInfoView: UserInfoView?
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        let planInfoView = UserInfoView(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let planLabel = self.planInfoView?.titleLabel {
            planLabel.text = "計畫目標"
            
        }
        

        
        
        
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
