//
//  DetailViewController.swift
//  GitHistory
//
//  Created by chenyh on 2020/12/27.
//

import UIKit

class DetailViewController: UIViewController {

    private lazy var textView: UITextView = UITextView()
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    var map: [String: String] = [:] {
        didSet {
            textView.text = map["data"] ?? ""
            timeLabel.text = map["time"] ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detial"
        view.addSubview(timeLabel)
        view.addSubview(textView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var viewX: CGFloat = 0
        var viewY: CGFloat = 0
        var viewW: CGFloat = 0
        var viewH: CGFloat = 0
        
        viewX = 15
        viewY = UIApplication.shared.statusBarFrame.maxY + 44 + 15
        viewW = view.bounds.width - viewX * 2
        viewH = timeLabel.text!.cx_boundingRect(with: viewW)
        timeLabel.frame = CGRect(x: viewX, y: viewY, width: viewW, height: viewH)
        
        viewY = timeLabel.frame.maxY + 15
        viewH = view.frame.height - viewY
        textView.frame = CGRect(x: viewX, y: viewY, width: viewW, height: viewH)
    }
    
}
