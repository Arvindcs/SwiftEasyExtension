//
//  UIImageView+Ext.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 07/03/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func configureIMGViewForCell(_ contentView: UIView, imgName: String, ctMore: UIView.ContentMode = .scaleAspectFit) {
        contentMode = ctMore
        clipsToBounds = true
        image = UIImage(named: imgName)?.withRenderingMode(.alwaysTemplate)
        tintColor = .black
        contentView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
