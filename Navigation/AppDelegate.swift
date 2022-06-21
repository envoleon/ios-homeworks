//
//  AppDelegate.swift
//  Navigation
//
//  Created by Александр Лебедев on 20.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let navigation: (UIViewController, String, String, String) -> UINavigationController = {
        let navigation = UINavigationController(rootViewController: $0)
        navigation.tabBarItem.title = $1
        navigation.tabBarItem.image = UIImage(named: $2)
        navigation.tabBarItem.selectedImage = UIImage(named: $3)
        return navigation
    }

    let tabBar: (String, [UINavigationController]) -> UITabBarController = {
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = UIColor(named: $0)
        tabBar.tabBar.unselectedItemTintColor = UIColor(named: $0)
        tabBar.viewControllers = $1
        return tabBar
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBar("bar-color", [
            navigation(FeedViewController(), "Feed", "bar-feed-off", "bar-feed-on"),
            navigation(ProfileViewController(), "Profile", "bar-profile-off", "bar-profile-on")
        ])
        window?.makeKeyAndVisible()
        return true
    }

}

