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
        self.tabBar.tintColor = UIColor.green
        self.tabBar.barTintColor = UIColor.black
        self.setupTabbar()
    }
    
    func setupTabbar() {
        let home = self.create(HomeViewController(), "歌手", "tabbar_singer")
        let history = self.create(HistoryViewController(), "歌手", "tabbar_singer")
//        let rank = self.create(RankViewController(), "排行榜", "tabbar_rank")
//        let collect = self.create(CollectionViewController(), "收藏", "tabbar_collect")
//        let setting = self.create(SettingViewController(), "设置", "tabbar_setting")

        self.viewControllers = [home, history]
    }
    
    func create(_ vc: UIViewController, _ title: String, _ imageNamed: String) -> UIViewController {
        let nav = CXNavigationController(rootViewController: vc)
        vc.title = title;
        vc.tabBarItem.image = UIImage(named: imageNamed);
        vc.tabBarItem.selectedImage = UIImage(named: imageNamed + "_s")
        vc.tabBarItem.title = title;
        return nav
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.selectedViewController
    }

}
