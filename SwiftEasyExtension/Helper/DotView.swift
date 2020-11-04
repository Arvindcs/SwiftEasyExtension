//
//  DotView.swift
//  Agritz
//
//  Created by Arvind on 07/03/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

private struct AnimationAppearance {
    
    var dotSize: CGFloat
    var dotCount: Int
    var dotSpacing: CGFloat
    var dotColor: UIColor
    var jumpHeight: CGFloat
    var jumDuration: TimeInterval
    
    init() {
        dotSize = 15.0
        dotCount = 3
        dotSpacing = 5.0
        dotColor = lightSeparatorColor
        jumpHeight = 10.0
        jumDuration = 0.33
    }
}

class DotView: UIView {
    
    private let appearance = AnimationAppearance()
    private var dots: [UIView] = []
    
    init() {
        let width = CGFloat(appearance.dotCount) * (appearance.dotSize + appearance.dotSpacing)
        let height = appearance.dotSize + appearance.jumpHeight
        let rect = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        
        super.init(frame: rect)
        
        var currentX: CGFloat = 0.0
        
        for _ in 0..<appearance.dotCount {
            let dotView = UIView()
            dotView.frame = CGRect(x: 0.0,
                                   y: 0.0,
                                   width: appearance.dotSize,
                                   height: appearance.dotSize)
            dotView.backgroundColor = appearance.dotColor
            dotView.clipsToBounds = true
            dotView.layer.cornerRadius = appearance.dotSize/2.0
            
            addSubview(dotView)
            dots.append(dotView)
            dotView.frame.origin.x = currentX + 5
            currentX += appearance.dotSize + appearance.dotSpacing
        }
        
        startAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func startAnimation() {
        var del: TimeInterval = 0.0
        
        for dot in dots {
            delay(duration: del) {
                dot.layer.add(self.jumAnim, forKey: nil)
            }
            
            del += appearance.jumDuration / TimeInterval(appearance.jumpHeight) * TimeInterval(appearance.dotCount) * 2.0
        }
    }
    
    private var jumAnim: CABasicAnimation {
        get {
            let anim = CABasicAnimation(keyPath: "position.y")
            anim.duration = appearance.jumDuration
            anim.fromValue = appearance.dotSize/2.0
            anim.toValue = appearance.jumpHeight
            anim.repeatCount = .infinity
            anim.autoreverses = true
            return anim
        }
    }
}
