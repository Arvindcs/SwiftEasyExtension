//
//  Formatter+Ext.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 06/03/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

extension Formatter {
    
    static let withCurrency: NumberFormatter = {
        var numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
//        numberFormatter.groupingSeparator = "."
        numberFormatter.groupingSeparator = "," //Dollar
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
    
    static let withDecimal: NumberFormatter = {
        var numberFormatter = NumberFormatter()
//        numberFormatter.groupingSeparator = "."
        numberFormatter.groupingSeparator = "," //Dollar
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
}

extension Double {
    
    var formattedWithCurrency: String {
        guard let currency = Formatter.withCurrency.string(for: self) else { return "" }
        return "$" + currency
    }
    
    var formattedWithDecimal: String {
        return Formatter.withDecimal.string(for: self) ?? ""
    }
}

extension String {
    
    var formattedWithDecimal: String {
        return Formatter.withDecimal.string(for: self) ?? ""
    }
    
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: self)
    }
    
    func toDouble() -> Double? {
          return NumberFormatter().number(from: self)?.doubleValue
      }
    
    func base64ToImage() -> UIImage? {
           if let url = URL(string: self),let data = try? Data(contentsOf: url),let image = UIImage(data: data) {
               return image
           }
           return nil
       }
}
