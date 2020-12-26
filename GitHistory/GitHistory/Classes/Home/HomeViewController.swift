//
//  HomeViewController.swift
//  GitHistory
//
//  Created by chenyh on 2020/12/27.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView;
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = UIColor.white
        
        view.addSubview(scrollView)
        scrollView.addSubview(timeLabel)
        scrollView.addSubview(textLabel)
        
        listener()
        reloadTime()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = self.view.bounds
        
        var viewX: CGFloat = 0
        var viewY: CGFloat = 0
        var viewW: CGFloat = 0
        var viewH: CGFloat = 0
        
        viewX = 15
        viewY = 15
        viewW = view.bounds.width - viewX * 2
        viewH = timeLabel.font.lineHeight
        timeLabel.frame = CGRect(x: viewX, y: viewY, width: viewW, height: viewH)
        
        viewY = timeLabel.frame.maxY + 15
        viewH = textLabel.text!.cx_boundingRect(with: viewW)
        textLabel.frame = CGRect(x: viewX, y: viewY, width: viewW, height: viewH)
        
        scrollView.contentSize = CGSize(width: 0, height: textLabel.frame.maxY + 30)
    }
}

extension HomeViewController {
    func listener() {
        RequestTimer.shared.handler = { [weak self] (desc) in
            guard let wself = self else {
                return
            }
            wself.reloadTime()
            wself.textLabel.text = desc
            wself.viewDidLayoutSubviews()
        }
    }
    
    func reloadTime() {
        self.timeLabel.text = Date().description(with: Locale.init(identifier: "ZH"))
    }
}
