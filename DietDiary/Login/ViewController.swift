//
//  ViewController.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/10.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire

class ViewController: UIViewController, LoginButtonDelegate {
    
//    var db: Firestore!
    
    @IBOutlet weak var fbLoginButton: UIButton!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var userNameTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let settings = FirestoreSettings()
//        Firestore.firestore().settings = settings
//        db = Firestore.firestore()
        
        self.fbLoginButton.layer.cornerRadius = 15.0
        
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
    
    //    @objc func updateProfile() {
    //        if let profile = Profile.current {
    //            let userId = profile.userID
    //            let profileUrl = profile.linkURL
    //            let userName = <#value#>
    //
    //
    //
    //            checkSignUp(userId: userId, profileUrl: String, userName: String)
    //
    //            //requestMe()
    //        }
    //    }
    
    //    func requestMe(){
    //        //先判斷是否有token存在,有Token表示使用者有login
    //        if AccessToken.current != nil {
    //            let request = GraphRequest(graphPath: "me",
    //                                       parameters:["fields":"email,birthday"])
    //            request.start(completionHandler: { (connection, result, error) -> Void in
    //                print(result)
    //                let info = result as! Dictionary<String,AnyObject>
    //                if let email = info["email"] {
    //                    print("email  = \(email)")
    //                }
    //                if let birthday = info["birthday"] {
    //                    print("birthday = \(birthday)")
    //                }
    //            })
    //            let sb = UIStoryboard(name: "Main", bundle: nil)
    //            let vc = sb.instantiateViewController(identifier: "UserInfoOneVCNav") as! UINavigationController
    //            vc.modalPresentationStyle = .overFullScreen
    //            self.present(vc, animated: true, completion: nil)
    //        }
    //    }
    
    @objc func checkSignUp() {
//        Profile.loadCurrentProfile { (profile, error) in
//            if let profile = profile {
//                let imageURL = profile.imageURL(forMode: .square, size: CGSize(width: 200.0, height: 200.0))
//            }
//        }
        
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
                        
                        let dietDiaryVC = sb.instantiateViewController(withIdentifier: "DietDiaryVC")
                        vc.viewControllers.append(dietDiaryVC)
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(identifier: "UserInfoNav") as! UINavigationController
//        vc.modalPresentationStyle = .overFullScreen
//        self.present(vc, animated: true, completion: nil)
        /*
        
         Auth.auth().signIn(with: credential) { (authResult, error) in
         if let error = error {
         let authError = error as NSError
         if (isMFAEnabled && authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
         // The user is a multi-factor user. Second factor challenge is required.
         let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
         var displayNameString = ""
         for tmpFactorInfo in (resolver.hints) {
         displayNameString += tmpFactorInfo.displayName ?? ""
         displayNameString += " "
         }
         self.showTextInputPrompt(withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK, displayName in
         var selectedHint: PhoneMultiFactorInfo?
         for tmpFactorInfo in resolver.hints {
         if (displayName == tmpFactorInfo.displayName) {
         selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
         }
         }
         PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil, multiFactorSession: resolver.session) { verificationID, error in
         if error != nil {
         print("Multi factor start sign in failed. Error: \(error.debugDescription)")
         } else {
         self.showTextInputPrompt(withMessage: "Verification code for \(selectedHint?.displayName ?? "")", completionBlock: { userPressedOK, verificationCode in
         let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode!)
         let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
         resolver.resolveSignIn(with: assertion!) { authResult, error in
         if error != nil {
         print("Multi factor finanlize sign in failed. Error: \(error.debugDescription)")
         } else {
         self.navigationController?.popViewController(animated: true)
         }
         }
         })
         }
         }
         })
         } else {
         self.showMessagePrompt(error.localizedDescription)
         return
         }
         // ...
         return
         }
         // User is signed in
         // ...
         }
         */
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
}

