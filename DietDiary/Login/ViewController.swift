//
//  ViewController.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/10.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire

class ViewController: UIViewController, LoginButtonDelegate {
    
//    var db: Firestore!
    
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var fbLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fbLoginButton.isHidden = true
        self.fbLogo.isHidden = true
        self.fbLoginButton.layer.cornerRadius = 25.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkSignUp()
    }
    
    @IBAction func fbLogin(_ sender: UIButton) {
        let manager = LoginManager()
        //permissions
        manager.logIn(permissions: ["public_profile"], from: self, handler: nil)
//        manager.delegate = self
        Profile.enableUpdatesOnAccessTokenChange(true)
        //註冊通知-當登入帳號有改變時會發送通知FBSDKProfileDidChangeNotification
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.checkSignUp), name: NSNotification.Name.ProfileDidChange, object: nil)
        
    }
    
    
    @objc func checkSignUp() {
        
        if let profile = Profile.current {
            let userId = profile.userID
            let profileUrl = profile.imageURL(forMode: .normal, size: CGSize(width: 100.0, height: 100.0))?.absoluteString ?? ""
            let userName =  profile.name ?? "路人甲"
            
            // 準備登入資料
            let parameters: [String: Any] = [
                "unique_id": userId,
                "profile_url": profileUrl,
                "user_name": userName
            ]
            
            // 呼叫API
            //self.indicatorView.startAnimating()
            print(parameters)
            
            Alamofire.request(URLs.userInfoURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<UserInfoData>) in
                
                //self.indicatorView.stopAnimating()
                print(response.result.value)
                if response.result.isSuccess {
                    let userInfoData = response.result.value
                    MemoryData.userInfo = userInfoData?.data
                    
                    if MemoryData.userInfo?.gender == nil {
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        let vc = sb.instantiateViewController(identifier: "UserInfoNav") as! UINavigationController
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: true, completion: nil)
                    } else {
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        let vc = sb.instantiateViewController(identifier: "UserInfoNav") as! UINavigationController
                        vc.modalPresentationStyle = .currentContext
                        
                        MemoryData.userInfo?.calculateAmount()
                        
                        let dietDiaryVC = sb.instantiateViewController(withIdentifier: "DietDiaryVC")
                        vc.viewControllers.append(dietDiaryVC)
                        self.present(vc, animated: false, completion: nil)
                    }
                }
                self.fbLoginButton.isHidden = false
                self.fbLogo.isHidden = false
            }
        }else{
            self.fbLoginButton.isHidden = false
            self.fbLogo.isHidden = false
        }
    }
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {

    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
}

