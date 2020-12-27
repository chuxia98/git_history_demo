//
//  CXTabBarController.swift
//  GitHistory
//
//  Created by chenyh on 2020/12/27.
//

import UIKit

class CXTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.tabBar.tintColor = UIColor.white
        self.tabBar.barTintColor = UIColor.black
        self.setupTabbar()
    }
    
    func setupTabbar() {
        let home = self.create(HomeViewController(), "Home")
        let history = self.create(HistoryViewController(), "Histroy", .history, 2)

        self.viewControllers = [home, history]
    }
    
    func create(_ vc: UIViewController, _ title: String, _ systemItem: UITabBarItem.SystemItem = .contacts, _ tag: Int = 1) -> UIViewController {
        let nav = CXNavigationController(rootViewController: vc)
        vc.title = title;
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: systemItem, tag: tag)
        vc.tabBarItem.title = title;
        return nav
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.selectedViewController
    }

}
