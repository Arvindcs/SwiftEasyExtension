//
//  Int+Ext.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 28/03/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

extension Int {
    
    static func random(_ n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    static func random(min: Int, max: Int) -> Int {
        assert(min < max)
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}
