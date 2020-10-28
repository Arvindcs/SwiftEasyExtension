//
//  Types.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 28/10/20.
//

import Foundation
import UIKit

public let screenWidth = UIScreen.main.bounds.size.width
public let screenHeight = UIScreen.main.bounds.size.height
//let naviHeight = navigationController!.navigationBar.frame.height
//let statusHeight = UIApplication.shared.statusBarFrame.height

public let fontNamed = "HelveticaNeue"
public let fontNamedBold = "HelveticaNeue-Bold"

public let fontLinhLight = "LinhAmorSans-Light"
public let fontLinhBold = "LinhAmorSans-Bold"

public let defaultColor =  UIColor(red: 252.0/255.0, green: 184.0/255.0, blue: 0/255.0, alpha: 1.0) //UIColor(hex: 0xFFBA14)
public let groupColor = UIColor(hex: 0xEFEFF3)
public let darkColor = UIColor(hex: 0x1C1C1E)
public let lightSeparatorColor = UIColor(hex: 0xEFEFF4)
public let darkSeparatorColor = UIColor(hex: 0x373737)

public func setupTitleAttri(_ title: String,
                            txtColor: UIColor = .white,
                            fontN: String = fontNamedBold,
                            size: CGFloat = 15.0) -> NSAttributedString {
    let attributes = setupAttri(fontN, size: size, txtColor: txtColor)
    let attributed = NSMutableAttributedString(string: title, attributes: attributes)
    return attributed
}

public func setupAttri(_ fontN: String, size: CGFloat, txtColor: UIColor) -> [NSAttributedString.Key : Any] {
    let attributes = [
        NSAttributedString.Key.font : UIFont(name: fontN, size: size)!,
        NSAttributedString.Key.foregroundColor : txtColor
    ]
    return attributes
}

//MARK: - Extimated Text

public func estimatedText(_ text: String, fontS: CGFloat = 13.0, width: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGRect {
    let height = CGFloat.greatestFiniteMagnitude
    let size = CGSize(width: width, height: height)
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    let attributes = setupAttri(fontNamedBold, size: fontS, txtColor: .black)
    return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
}

//MARK: - UIStackView

public func createdStackView(_ views: [UIView],
                           spacing: CGFloat,
                           axis: NSLayoutConstraint.Axis,
                           distribution: UIStackView.Distribution,
                           alignment: UIStackView.Alignment) -> UIStackView {
    let sv = UIStackView(arrangedSubviews: views)
    sv.spacing = spacing
    sv.axis = axis
    sv.distribution = distribution
    sv.alignment = alignment
    return sv
}
