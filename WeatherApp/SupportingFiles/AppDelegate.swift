//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Abhilash k George on 22/02/22.
//

//import UIKit
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//    @available(iOS 13.0, *)
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//
//
//}
//
import UIKit
import Branch

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let storyboardID = "RecentsFavouritesViewController"
    var placeName: String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let branch = Branch.getInstance()

        branch.initSession(launchOptions: launchOptions, andRegisterDeepLinkHandler: { [self]params, error in

            // do stuff with deep link data (nav to page, display content, etc)
            print(params as? [String: AnyObject] ?? {})
            if error == nil && params?["place_name"] != nil {


                self.placeName = params?["place_name"]! as! String?
                print("Clicked weather link for \(self.placeName!)!")

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainController = storyboard.instantiateInitialViewController()! as UIViewController
                self.window!.rootViewController = mainController

                let destination = storyboard.instantiateViewController(withIdentifier: self.storyboardID) as! RecentsFavouritesViewController
                destination.searchBar.text = placeName

                self.window!.rootViewController?.present(destination, animated: true, completion: nil)

            }
        })
        return true
//        branch.initSession(launchOptions: launchOptions, andRegisterDeepLinkHandler: { [self]params, error in
//
//            // do stuff with deep link data (nav to page, display content, etc)
//            print(params as? [String: AnyObject] ?? {})
//            if params?["place_name"] != nil {
//                let placeName = params?["place_name"] as! String
//                print("clicked on \(placeName) link")
//            } else {
//                print("No parameter")
//            }
//
//                if let placeName = params?["place_name"] as? String, placeName == "Tokyo,JP" {
//                    print("Clicked on Tokyo link")
//                }
//
//                // ... continue with your existing code
//        })
//        return true

    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        Branch.getInstance().application(app, open: url, options: options)
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // handler for Universal Links
        Branch.getInstance().continue(userActivity)
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // handler for Push Notifications
        Branch.getInstance().handlePushNotification(userInfo)
    }
    // Respond to URI scheme links
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        // pass the url to the handle deep link call
        Branch.getInstance().handleDeepLink(url);

        // do other deep link routing for the Facebook SDK, Pinterest SDK, etc
        return true
    }

    // Respond to Universal Links
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        // pass the url to the handle deep link call
        Branch.getInstance().continue(userActivity)

        return true
    }
}
