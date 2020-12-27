//
//  CXTableViewCell.swift
//  GitHistory
//
//  Created by chenyh on 2020/12/27.
//

import UIKit

class CXTableViewCell: UITableViewCell {
    class var cellID: String {
        return self.description()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.textLabel?.textColor = UIColor.black
        self.textLabel?.font = UIFont.systemFont(ofSize: 12)
    }
}


class CXCollectionViewCell: UICollectionViewCell {
    class var cellID: String {
        return self.description()
    }
}
