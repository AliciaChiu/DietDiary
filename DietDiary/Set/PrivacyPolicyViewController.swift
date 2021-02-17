//
//  PrivacyPolicyViewController.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2021/2/4.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        let url = URL(string: "https://www.privacypolicies.com/live/b9f8aaa2-3635-44b7-90ce-9647e37f2c75")!
        let request = URLRequest(url: url)
        webView.load(request)
        activityIndicator.stopAnimating()
        

        // Do any additional setup after loading the view.
    }
    

}
