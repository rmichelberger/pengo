//
//  Points.swift
//  climate
//
//  Created by Roland Michelberger on 28.09.19.
//  Copyright © 2019 hack zurich. All rights reserved.
//

class Points {
    
    static let shared = Points()
    
    var bikePoints = 126.6
    var trainPoints = 452.9
    var walkPoints = 86.12

    private init() {
        
    }
    
    var totalPoints: Double {
        return bikePoints + trainPoints + walkPoints
    }
    
    
}
