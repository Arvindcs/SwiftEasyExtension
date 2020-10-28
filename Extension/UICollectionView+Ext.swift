//
//  UICollectionView+Ext.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 26/03/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func configureCVAddSub(_ bgColor: UIColor = .clear, ds: UICollectionViewDataSource, dl: UICollectionViewDelegate, view: UIView) {
        configureCV(bgColor, ds: ds, dl: dl)
        view.addSubview(self)
    }
    
    func configureCVInsert(_ bgColor: UIColor = .clear, ds: UICollectionViewDataSource, dl: UICollectionViewDelegate, view: UIView, below: UIView) {
        configureCV(bgColor, ds: ds, dl: dl)
        view.insertSubview(self, belowSubview: below)
    }
    
    func configureCV(_ bgColor: UIColor, ds: UICollectionViewDataSource, dl: UICollectionViewDelegate) {
        contentInsetAdjustmentBehavior = .never
        backgroundColor = bgColor
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        dataSource = ds
        delegate = dl
        translatesAutoresizingMaskIntoConstraints = false
        reloadData()
    }
}
