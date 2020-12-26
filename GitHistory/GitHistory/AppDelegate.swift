//
//  AppDelegate.swift
//  GitHistory
//
//  Created by chenyh on 2020/12/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?;

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        RequestTimer.shared.setup()
        return true
    }

}

