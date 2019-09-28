//
//  Colors.swift
//  climate
//
//  Created by Roland Michelberger on 28.09.19.
//  Copyright © 2019 hack zurich. All rights reserved.
//

import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = 4
        subView.clipsToBounds = true
        insertSubview(subView, at: 0)
    }
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        assert(alpha >= 0 && alpha <= 1, "Invalid alpha component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            alpha: alpha
        )
    }
}


extension UIColor {
    
    class func darkColor(at: Int) -> UIColor {
        let colors = [UIColor.greenSea, oceanBlue]
        return colors[at % colors.count]
    }
    
    class var oceanBlue: UIColor {
        return UIColor(hex: 0x2c91ff)
    }
    
    class var belizeHole: UIColor {
        return UIColor(hex: 0x2980b9)
    }
    
    class var carrot: UIColor {
        return UIColor(hex: 0xffbd29)
    }
    
    class var greenSea: UIColor {
        return UIColor(hex: 0x39c109)
    }
    
    class var wisteria: UIColor {
        return UIColor(hex: 0x8e44ad)
    }
    
    class var peterRiver: UIColor {
        return UIColor(hex: 0x3498db)
    }
    
    class var pomegranate: UIColor {
        return UIColor(hex: 0xff3434)
    }
    
    class var alizarin: UIColor {
        return UIColor(hex: 0xe74c3c)
    }
    
    class var midnightBlue: UIColor {
        return UIColor(hex: 0x2c3e50)
    }
    
    class var sunFlower: UIColor {
        return UIColor(hex: 0xf1c40f)
    }
    
    class var concrete: UIColor {
        return UIColor(hex: 0x95a5a6)
    }
    
    class var wetAsphalt: UIColor {
        return UIColor(hex: 0x34495e)
    }
    
    class var nephritis: UIColor {
        return UIColor(hex: 0x27ae60)
    }
    
}
