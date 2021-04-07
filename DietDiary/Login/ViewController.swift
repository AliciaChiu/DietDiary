//
//  ViewController.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/10.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import AuthenticationServices
import Alamofire


class ViewController: UIViewController, LoginButtonDelegate {

    @IBOutlet weak var fbLoginButton: UIButton!
  
    @IBOutlet weak var appleSignInButton: UIButton!
//    let appleSignInButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fbLoginButton.alpha = 0
        self.appleSignInButton.alpha = 0
        self.fbLoginButton.layer.cornerRadius = 22
        self.appleSignInButton.layer.cornerRadius = 22
        
        Alamofire.request("https://aliciachiu.github.io/DDdomain/domain.json?abc=\(arc4random())", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<DomainData>) in
            if response.result.isSuccess {
                let domainData = response.result.value
                URLs.domain = domainData?.domain ?? URLs.domain
            }
            
            self.checkFBSignUp()
            self.checkAppleSignIn()
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //MARK: Facebook login.
    @IBAction func fbLogin(_ sender: UIButton) {
        let manager = LoginManager()
        //permissions
        manager.logIn(permissions: ["public_profile"], from: self, handler: nil)
//        manager.delegate = self
        Profile.enableUpdatesOnAccessTokenChange(true)
        //註冊通知-當登入帳號有改變時會發送通知FBSDKProfileDidChangeNotification
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.checkFBSignUp), name: NSNotification.Name.ProfileDidChange, object: nil)
        
    }
    
    @objc func checkFBSignUp() {
        
        if let profile = Profile.current {
            let userID = profile.userID
            let profileUrl = profile.imageURL(forMode: .normal, size: CGSize(width: 100.0, height: 100.0))?.absoluteString ?? ""
            let userName =  profile.name ?? "路人甲"
            
            // 準備登入資料
            let parameters: [String: Any] = [
                "unique_id": userID,
                "profile_url": profileUrl,
                "user_name": userName
            ]
            
            // 呼叫API
            print(parameters)
            
            Alamofire.request(URLs.userInfoURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<UserInfoData>) in

                print(response.result.value)
                if response.result.isSuccess {
                    let userInfoData = response.result.value
                    MemoryData.userInfo = userInfoData?.data
                    
                    if MemoryData.userInfo?.nowHeight == nil {
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
            }
        }else{
            self.fbLoginButton.alpha = 1
            self.appleSignInButton.alpha = 1
        }
    }
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {

    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
    
    
    //MARK: Apple signin.
    
    @IBAction func SignInWithApple(_ sender: Any) {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
    }
    
    
    
    
//    func setUpSignInAppleButton() {
//
//        appleSignInButton.frame = CGRect(x: 50, y: 550, width: 290, height: 44)
//        appleSignInButton.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
//        appleSignInButton.cornerRadius = 25
//        //Add button on some view or stack
//        self.view.addSubview(appleSignInButton)
//
//    }
    
//    @objc func handleAppleIdRequest() {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let request = appleIDProvider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
//    }
    
    
    func checkAppleSignIn() {

        if let userID = UserDefaults.standard.string(forKey: "userID"), let userName = UserDefaults.standard.string(forKey: "userName"), userID != nil  {
            
            // 準備登入資料
                let parameters: [String: Any] = [
                    "unique_id": userID,
                    "user_name": userName
                ]
                
                // 呼叫API
                print(parameters)

                Alamofire.request(URLs.userInfoURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<UserInfoData>) in

                    if response.result.isSuccess {
                        
                        let userInfoData = response.result.value
                        MemoryData.userInfo = userInfoData?.data
                        MemoryData.userInfo?.calculateAmount()
                        
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        let vc = sb.instantiateViewController(identifier: "UserInfoNav") as! UINavigationController
                        vc.modalPresentationStyle = .currentContext
                        
                        let dietDiaryVC = sb.instantiateViewController(withIdentifier: "DietDiaryVC")
                        vc.viewControllers.append(dietDiaryVC)
                        self.present(vc, animated: false, completion: nil)
                        
                    }else{
                        print("Failed")
                    }
                }
        }else{
            //self.setUpSignInAppleButton()
            //self.appleSignInButton.isHidden = false
        }
    }
}

extension ViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userID = appleIDCredential.user
            let givenName = appleIDCredential.fullName?.givenName ?? "Honey"
            let familyName = appleIDCredential.fullName?.familyName ?? "Sweet"
            let userName = givenName + familyName
            print(userName)
            let email = appleIDCredential.email
            
            UserDefaults.standard.set(userID, forKey: "userID")
            UserDefaults.standard.set(userName, forKey: "userName")
            UserDefaults.standard.synchronize()
            
            // 準備登入資料
            let parameters: [String: Any] = [
                "unique_id": userID,
                "user_name": userName
            ]
            
            // 呼叫API
            print(parameters)
            
            Alamofire.request(URLs.userInfoURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<UserInfoData>) in
                
                print(response.result.value)
                
                if response.result.isSuccess {
                    
                    let userInfoData = response.result.value
                    MemoryData.userInfo = userInfoData?.data
                    
                    let msg = "User id is \(userID) \n User Name is \(String(describing: userName)) \n Email id is \(String(describing: email))"
                    print(msg)
                    
                    let alert = UIAlertController(title: "登入成功", message: nil, preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .cancel) { (action) in
                        
                        if MemoryData.userInfo?.nowHeight == nil {
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
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    
                }else {
                    print("Failed")
                }
            }
        }
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Failed:\(error.localizedDescription)")
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }

}
