//
//  CGFloat+Ext.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 07/03/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

let π = CGFloat.pi
let twoπ = 2*π

extension CGFloat {
    
    func degreesToRadians() -> CGFloat {
        return self * π / 180.0
    }
    
    func radiansToDegrees() -> CGFloat {
        return self * 180.0 / π
    }
    
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
}
