//
//  AppDelegate.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/10/12.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow.init()
        window?.backgroundColor = .white
        window?.frame = UIScreen.main.bounds
        window?.makeKeyAndVisible()
        window?.rootViewController = WBMainViewController()
        
        loadAppInfo()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    // MARK: - Core Data stack

    @available(iOS 13.0, *)
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "Weib_Demo")
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
    @available(iOS 13.0, *)
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

// MARK: - 网络加载应用程序信息

extension AppDelegate {
    private func loadAppInfo() {
        //模拟异步
        DispatchQueue.global().async {
            let url = Bundle.main.url(forResource: "main", withExtension: "json")
            
            let data = NSData(contentsOf: url!)
            //数据写入磁盘
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            
            data?.write(toFile: jsonPath, atomically: true)
            print("APP加载完毕\(jsonPath)")
        }
    }
}

extension AppDelegate {
    
    private func stupAddtion() {
        //设置SVProguressHUD最短消失时间
        SVProgressHUD.setMinimumDismissTimeInterval(3)
        
        //AFNetWorking网络加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
    }
}

