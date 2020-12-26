//
//  String+cx.swift
//  GitHistory
//
//  Created by chenyh on 2020/12/27.
//

import UIKit

extension String {
    
    func cx_boundingRect(with viewW: CGFloat, font: UIFont = UIFont.systemFont(ofSize: 14)) -> CGFloat {
        let size = CGSize(width: viewW, height: CGFloat(MAXFLOAT))
        let string: NSString = self as NSString
        let attributes = [NSAttributedString.Key.font: font]
        return string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size.height;
    }
    
}
