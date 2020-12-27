//
//  CXNavigationController.swift
//  GitHistory
//
//  Created by chenyh on 2020/12/27.
//

import UIKit

class CXNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.tintColor = UIColor.red
        self.navigationBar.barTintColor = UIColor.black
        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = self;
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationBar.titleTextAttributes = attributes;
    }
    
    override var shouldAutorotate: Bool {
        return self.topViewController?.shouldAutorotate ?? false;
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController?.supportedInterfaceOrientations ?? UIInterfaceOrientationMask.portrait;
    }

    override var prefersStatusBarHidden: Bool {
        return self.topViewController?.prefersStatusBarHidden ?? false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

}

extension CXNavigationController: UINavigationControllerDelegate {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.children.count > 0) {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
            button.setImage(UIImage(named: "navigation_back"), for: .normal)
            button.contentHorizontalAlignment = .left
            button.addTarget(self, action: #selector(cx_backAction), for: .touchUpInside)
            let item = UIBarButtonItem(customView: button)
            viewController.navigationItem.leftBarButtonItem = item
            viewController.hidesBottomBarWhenPushed = true;
            viewController.view.backgroundColor = UIColor.white;
        }
        super.pushViewController(viewController, animated: animated)
    }

    @objc func cx_backAction() {
        self.popViewController(animated: true)
    }

}

extension CXNavigationController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.children.count == 1 ? false : true;
    }

}
