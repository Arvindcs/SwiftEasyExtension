//
//  UIButton+Ext.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 07/03/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

extension UIButton {
    
    func configureFilterBtn(_ parentV: UIView, imgNamed: String = "icon-filter", selector: Selector, controller: UIViewController) {
        frame = CGRect(x: parentV.frame.width-30.0, y: 0.0, width: 40.0, height: 40.0)
        setImage(UIImage(named: imgNamed), for: .normal)
        addTarget(controller, action: selector, for: .touchUpInside)
        parentV.addSubview(self)
    }
    
    func configureBackBtn(_ parentV: UIView, selector: Selector, controller: UIViewController) {
        frame = CGRect(x: -15.0, y: 0.0, width: 40.0, height: 40.0)
        setImage(UIImage(named: "icon-back"), for: .normal)
        addTarget(controller, action: selector, for: .touchUpInside)
        parentV.addSubview(self)
    }
    
    func configureLogInSignUpBtn(_ txt: String, txtColor: UIColor, bgColor: UIColor, selector: Selector, vc: UIViewController, borderC: UIColor = .clear, width: CGFloat = screenWidth*0.9) {
        let attributed = setupTitleAttri(txt, txtColor: txtColor, size: 17.0)
        setAttributedTitle(attributed, for: .normal)
        backgroundColor = bgColor
        clipsToBounds = true
        layer.cornerRadius = 50/2
        layer.borderColor = borderC.cgColor
        layer.borderWidth = 1.0
        addTarget(vc, action: selector, for: .touchUpInside)
        contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    func configureAddBtn(_ view: UIView, selector: Selector, vc: UIViewController) {
        frame = CGRect(x: -10.0, y: 0.0, width: 40.0, height: 40.0)
        setImage(UIImage(named: "icon-add"), for: .normal)
        addTarget(vc, action: selector, for: .touchUpInside)
        view.addSubview(self)
    }
}
