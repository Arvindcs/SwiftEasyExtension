//
//  HUD.swift
//  Agritz
//
//  Created by Arvind on 07/03/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

class AKHUD: UIView {
    
    var isRefresh = false
    
    class func hud(_ view: UIView, effect: Bool) -> AKHUD {
        let hud = AKHUD(frame: view.bounds)
        
        view.insertSubview(hud, at: 10)
        hud.isUserInteractionEnabled = true
        hud.isOpaque = false
        hud.backgroundColor = UIColor(hex: 0x000000, alpha: 0.1)
        animate(hud: hud, effect: effect)
        
        return hud
    }
    
    override func draw(_ rect: CGRect) {
        let boxHeight: CGFloat = 90.0

        let rect = CGRect(x: (bounds.size.width - boxHeight)/2.0,
                          y: (bounds.size.height - boxHeight)/2.0,
                          width: boxHeight,
                          height: boxHeight)
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 10.0)
        UIColor(white: 0.3, alpha: 0.7).setFill()
        bezierPath.fill()
        
        if isRefresh == false {
            let dotView = DotView()
            addSubview(dotView)
            dotView.center = center
            
        } else {
            let height: CGFloat = 20.0
            let indicator = UIActivityIndicatorView()
            indicator.frame = CGRect(x: (bounds.size.width - height)/2.0,
                                     y: (bounds.size.height - height)/2.0,
                                     width: height,
                                     height: height)
            indicator.style = UIActivityIndicatorView.Style.medium
            indicator.startAnimating()
            addSubview(indicator)
        }
    }
    
    class func animate(hud: AKHUD, effect: Bool) {
        if effect == true {
            hud.alpha = 0.0
            UIView.animate(withDuration: 0.33) { hud.alpha = 1.0 }
        }
    }
}

public var kWindow: UIWindow? {
    let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    return keyWindow
}

func createdHUD() -> AKHUD {
    let hud = AKHUD.hud(kWindow!, effect: true)
    return hud
}

func handleHUD(_ duration: TimeInterval = 1.5, traitCollection: UITraitCollection, completion: (() -> ())? = nil) {
    let hud = AKHUD.hud(kWindow!, effect: true)
    if #available(iOS 12.0, *) {
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified: hud.backgroundColor = .white
        case .dark: hud.backgroundColor = .black
        default: break
        }
    } else {
        hud.backgroundColor = .white
    }
    
    delay(duration: duration) {
        UIView.animate(withDuration: 0.5, animations: {
            hud.alpha = 0.0
            
        }) { (_) in
            hud.removeFromSuperview()
            completion?()
        }
    }
}

func removeHUD(_ hud: AKHUD, duration: TimeInterval = 0.75, completion: (() -> Void)? = nil) {
    delay(duration: duration) {
        UIView.animate(withDuration: 0.5, animations: {
            hud.alpha = 0.0
        }) { (_) in
            hud.removeFromSuperview()
            completion?()
        }
    }
}
