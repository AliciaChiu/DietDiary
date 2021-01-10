//
//  AppDelegate.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/10.
//

import UIKit
import CoreData
import FBSDKCoreKit
import Reachability
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var reachability: Reachability?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let path = Bundle.main.path(forResource: "20_5", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: Any]]{
                    print(jsonResult)
                }else{
                    print("parse error")
                }
                
            } catch {
               // handle error
                print("error")
            }
        }
        
        let barbuttonFont = UIFont(name: "jf-openhuninn-1.1", size: 17) ?? UIFont.systemFont(ofSize: 17)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: barbuttonFont], for: .normal)
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 247/255, green: 194/255, blue: 209/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        if let font = UIFont(name: "jf-openhuninn-1.1", size: 17){
            UINavigationBar.appearance().titleTextAttributes =
                [NSAttributedString.Key.font: font,
                 NSAttributedString.Key.foregroundColor: UIColor.white]
            
        }
        
        
        
        IQKeyboardManager.shared.enable = true
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        do{
            self.reachability = try Reachability()
            try self.reachability?.startNotifier() //開始發送通知
            
            NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.reachabilityStatus), name: .reachabilityChanged, object: nil)
        }catch{
           print("error while init Reachability \(error)")
        }
        
        return true
    }
    
    @objc func reachabilityStatus(){
        switch self.reachability?.connection {
        case .wifi:
            print("wifi")
        case .cellular:
            print("4G or 5G")
        case .none?:
            print("沒有網路")
        case .unavailable:
            print("沒有網路")
        default:
            print("error")
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.

    }
    


    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "DietDiary")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

