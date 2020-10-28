//
//  UIView+Ext.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 07/03/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

extension UIView {
    
    func configureContainerView(_ naviItem: UINavigationItem) {
        frame = CGRect(x: 0.0, y: 0.0, width: screenWidth-40.0, height: 40.0)
        backgroundColor = .clear
        naviItem.titleView = self
    }
    
    func configureTableTopView(_ title: String, view: UIView) {
        frame = CGRect(x: 0, y: 0.0, width: screenWidth, height: 50.0)
        backgroundColor =  .clear
        
        subviews.forEach({ $0.tag == 20 ? $0.removeFromSuperview() : nil })
        
        let label = UILabel()
        label.text = title
        label.textColor = .darkGray
        label.tag = 20
        label.frame = CGRect(x: 20, y: 0.0, width: screenWidth, height: 50.0)
        
        let separator = UIView()
        separator.frame = CGRect(x: 0, y: 49.0, width: screenWidth, height: 0.6)
        if #available(iOS 13.0, *) {
            separator.backgroundColor = .separator
        } else {
            separator.backgroundColor = .lightGray
        }
        addSubview(label)
       
        addSubview(separator)
        
        view.addSubview(self)
    }
    
    func configureLeftView(_ containerView: UIView) {
        frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        backgroundColor = .blue
        containerView.addSubview(self)
    }
    
    func configureRightView(_ containerView: UIView) {
        frame = CGRect(x: containerView.frame.width-40.0, y: 0.0, width: 40.0, height: 40.0)
        backgroundColor = .yellow
        containerView.addSubview(self)
    }
    
    func configureViewForCell(_ view: UIView, _ imgView: UIImageView) -> UIView {
        let dimsBG = UIView()
        dimsBG.backgroundColor = UIColor(hex: 0x000000, alpha: 0.5)
        dimsBG.clipsToBounds = true
        view.insertSubview(dimsBG, aboveSubview: imgView)
        dimsBG.translatesAutoresizingMaskIntoConstraints = false
        return dimsBG
    }
    
    func setupShadowForView(_ parentV: UIView, cornerR: CGFloat = 8.0) {
        setupContainerView(self, cornerR: cornerR)
        parentV.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupContainerView(_ containerView: UIView, cornerR: CGFloat = 8.0) {
        containerView.backgroundColor = .white
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = cornerR
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        containerView.layer.shadowRadius = 4.0
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shouldRasterize = true
        containerView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func configureHeaderView(_ view: UIView, tableView: UITableView) -> UIView {
        let kView = UIView(frame: CGRect(x: 0.0, y: 0.0,
                                         width: view.bounds.width,
                                         height: tableView.sectionHeaderHeight))
        kView.backgroundColor = groupColor
        return kView
    }
}

//MARK: - Gradient

extension UIView {
    
    func setupGradient(width: CGFloat, startC: UIColor, endC: UIColor, animDl: CAAnimationDelegate, lineW: CGFloat = 10.0, clockwise: Bool = true) {
        let arcC = CGPoint(x: width/2, y: width/2)
        let rad: CGFloat = width/2
        let startA: CGFloat = π/2
        let endA: CGFloat = (5*π/2) * (clockwise ? 1 : -1)
        let circularP = UIBezierPath(arcCenter: arcC, radius: rad, startAngle: startA, endAngle: endA, clockwise: clockwise)
        let circleLayer = CAShapeLayer()
        circleLayer.path = circularP.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = lineW
        circleLayer.lineCap = .round
        circleLayer.strokeColor = UIColor.clear.cgColor
        
        let progressLayer = CAShapeLayer()
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.path = circularP.cgPath
        progressLayer.lineWidth = lineW
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0.0
        progressLayer.opacity = 0.2
        
        let gradientLayer = createGradientLayer(width: width, height: width, startC: startC, endC: endC)
        gradientLayer.mask = progressLayer
        
        layer.addSublayer(circleLayer)
        layer.addSublayer(gradientLayer)
        
        setupAnimGradient(animDl: animDl, progressLayer: progressLayer)
    }
    
    func setupAnimGradient(animDl: CAAnimationDelegate, progressLayer: CAShapeLayer) {
        let animStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animStrokeEnd.toValue = 1.0
        
        let animOpacity = CABasicAnimation(keyPath: "opacity")
        animOpacity.toValue = 1.0
        
        let animG = CAAnimationGroup()
        animG.duration = 2.0
        animG.fillMode = .forwards
        animG.isRemovedOnCompletion = false
        animG.delegate = animDl
        animG.animations = [animStrokeEnd, animOpacity]
        progressLayer.add(animG, forKey: nil)
    }
}

public func createGradientLayer(width: CGFloat, height: CGFloat, startC: UIColor, endC: UIColor) -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    gradientLayer.colors = [startC.cgColor, endC.cgColor]
    return gradientLayer
}
