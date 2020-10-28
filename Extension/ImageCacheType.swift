//
//  ImageCacheType.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 24/04/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

protocol ImageCacheType: class {
    
    func image(for url: URL) -> UIImage?
    func insertImage(_ img: UIImage?, for url: URL)
    func removeImage(for url: URL)
    func removeAllImage()
    subscript(_ url: URL) -> UIImage? { get set }
}
