//
//  AppDelegate.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/01.
//

import UIKit
import Firebase

import FirebaseAnalytics
import FirebaseMessaging
import AuthenticationServices

//@main
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController : UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        sleep(2)
        // Override point for customization after application launch.
        
        if (UserDefaults.standard.string(forKey: "refreshToken") != nil){
            self.window = UIWindow(frame: UIScreen.main.bounds)
            navigationController = UINavigationController(rootViewController: HomeViewController())
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            self.window?.backgroundColor = .white
        }else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            navigationController = UINavigationController(rootViewController: LoginViewController())
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
        
        
        if #available(iOS 12.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge, .providesAppNotificationSettings], completionHandler: { didAllow,Error in
            })
        } else {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow,Error in
                print(didAllow)
            })
        }
        UNUserNotificationCenter.current().delegate = self
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        application.registerForRemoteNotifications()
        
        
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    //애플 로그인
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        appleIDProvider.getCredentialState(forUserID: /* 로그인에 사용한 User Identifier */) { (credentialState, error) in
//            switch credentialState {
//            case .authorized:
//                // The Apple ID credential is valid.
//                print("해당 ID는 연동되어있습니다.")
//            case .revoked:
//                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
//                print("해당 ID는 연동되어있지않습니다.")
//            case .notFound:
//                // The Apple ID credential is either was not found, so show the sign-in UI.
//                print("해당 ID를 찾을 수 없습니다.")
//            default:
//                break
//            }
//        }
//        return true
//    }

}

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let firebaseToken = fcmToken ?? ""
        print("firebase token: \(firebaseToken)")
        UserDefaults.standard.set(firebaseToken, forKey: "fcmToken")
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

