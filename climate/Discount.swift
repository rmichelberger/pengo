//
//  Discount.swift
//  climate
//
//  Created by Roland Michelberger on 28.09.19.
//  Copyright © 2019 hack zurich. All rights reserved.
//

import UIKit

struct Discount {
    let image: UIImage?
    let text: String?
    let logo: UIImage?
    
}

extension Discount {
    
    static let healthInsuranceDiscount = Discount(image: UIImage(named: "city"), text: """
5% discount for your health insurance, if you reach 100 🐧
""", logo: UIImage(named: "helsana"))
    static let carInsuranceDiscount = Discount(image: UIImage(named: "road"), text: """
CHF 50.- discount from your car insurance, if you reach 1000 🐧
""", logo: UIImage(named: "zurich"))
    static let trainDiscount = Discount(image: UIImage(named: "bernina"), text: """
70% discount for a surprise destination, if you reach 500 🐧
""", logo: UIImage(named: "sbb"))
    static let bikeDiscount = Discount(image: UIImage(named: "zurivelo"), text: """
30 minutes free Züri Velo usage in every months, if you reach 200 🐧
""", logo: UIImage(named: "zh"))
}
