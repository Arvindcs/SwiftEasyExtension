//
//  UILabel+Ext.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 07/03/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

extension UILabel {
    
    func configurePercentForCell(_ contentView: UIView, bgColor: UIColor = UIColor(hex: 0xE4372D), hidden: Bool = true, fontSize: CGFloat = 12.0) {
        font = UIFont(name: fontNamedBold, size: fontSize)
        text = "-\(20)%"
        textColor = .white
        backgroundColor = bgColor
        textAlignment = .center
        isHidden = hidden
        contentView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureOriginPrForCell(_ price: Double, hidden: Bool = true, txtColor: UIColor = UIColor(hex: 0xD1D1D1), fontSize: CGFloat = 12.0) {
        let priceStr = price.formattedWithCurrency
        let attributed = NSMutableAttributedString(string: priceStr) //Dollar
        attributed.addAttribute(.strikethroughStyle, value: 1, range: NSMakeRange(0, attributed.length))
        attributedText = attributed
        //text = "\(price)" //Dollar
        font = UIFont(name: fontNamedBold, size: fontSize)
        textColor = txtColor
        isHidden = hidden
        lineBreakMode = .byClipping
    }
    
    func configureCurrentPrForCell(_ price: Double, txtColor: UIColor = .white, fontSize: CGFloat = 12.0) {
        let saleOffStr = Double(price*0.9).formattedWithCurrency
        text = "\(saleOffStr)" //Dollar
        font = UIFont(name: fontNamedBold, size: fontSize)
        textColor = txtColor
        lineBreakMode = .byClipping
    }
    
    func configureNameForCell(_ hidden: Bool = false, line: Int = 1, txtColor: UIColor = .white, fontSize: CGFloat = 12.0, isTxt: String = "Nike Air Max 270", fontN: String = fontNamedBold) {
        text = isTxt
        font = UIFont(name: fontN, size: fontSize)
        textColor = txtColor
        isHidden = hidden
        numberOfLines = line
        lineBreakMode = .byClipping
    }
    
    func configureTitleForNavi(_ parentV: UIView, isTxt: String) {
        let width = estimatedText(isTxt, fontS: 17.0).width
        frame = CGRect(x: parentV.center.x - width/2.0, y: parentV.center.y-10.0, width: width, height: 40.0)
        text = isTxt
        font = UIFont(name: fontNamedBold, size: 17.0)
        textColor = .white
        sizeToFit()
        parentV.addSubview(self)
    }
    
    func configureHeaderTitle(_ kView: UIView) {
        kView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: kView.leadingAnchor, constant: 15.0),
            bottomAnchor.constraint(equalTo: kView.bottomAnchor, constant: -5.0),
        ])
    }
}
//MARK: - Extimated Text

public func estimatedText(_ text: String, fontS: CGFloat = 13.0, width: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGRect {
    let height = CGFloat.greatestFiniteMagnitude
    let size = CGSize(width: width, height: height)
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    let attributes = setupAttri(fontNamedBold, size: fontS, txtColor: .black)
    return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
}
