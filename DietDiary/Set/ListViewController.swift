//
//  ListViewController.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2021/2/1.
//

import UIKit
import MessageUI

class ListViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var userProfile: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if MemoryData.userInfo?.gender == 1 {
            self.userProfile.image = UIImage(named: "boy")
        } else {
            self.userProfile.image = UIImage(named: "girl")
        }
        
        self.userName.text = MemoryData.userInfo?.user_name
    }
    

    @IBAction func contactUs(_ sender: Any) {
        
        if (MFMailComposeViewController.canSendMail()) {
            let alert = UIAlertController(title: "", message: "有什麼話想說嗎？歡迎寄信給我們", preferredStyle: .alert)
            let email = UIAlertAction(title: "Email", style: .default) { (action) in
                
                let mailController = MFMailComposeViewController()
                mailController.mailComposeDelegate = self
                mailController.title = "我有問題要回饋給開發者"
                mailController.setSubject("我有問題要回饋給開發者")
                let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
                let product = Bundle.main.object(forInfoDictionaryKey: "CFBundleName")
                let messageBody = "<br/><br/><br/>Product:\(product!)(\(version!))"
                mailController.setMessageBody(messageBody, isHTML: true)
                mailController.setToRecipients(["dietdiary110@gmail.com"])
                self.present(mailController, animated: true, completion: nil)
                
            }
            let cancelAction = UIAlertAction(title: "先不要", style: .cancel) {_ in
                alert.resignFirstResponder()
            }
            alert.addAction(email)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            print("無法寄Email.")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("user cancelled")
        case .failed:
            print("user failed")
        case .saved:
            print("user saved email")
        case .sent:
            print("email sent")
        default:
            print("user cancelled")
        }
        self.dismiss(animated: true, completion: nil)
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
