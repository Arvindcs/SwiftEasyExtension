//
//  Types.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 28/10/20.
//

import Foundation
import UIKit
import MobileCoreServices
import MessageUI

public let screenWidth = UIScreen.main.bounds.size.width
public let screenHeight = UIScreen.main.bounds.size.height

public let fontNamed = "HelveticaNeue"
public let fontNamedBold = "HelveticaNeue-Bold"

public let fontLinhLight = "LinhAmorSans-Light"
public let fontLinhBold = "LinhAmorSans-Bold"

public let defaultColor =  UIColor(red: 252.0/255.0, green: 184.0/255.0, blue: 0/255.0, alpha: 1.0)
public let groupColor = UIColor(hex: 0xEFEFF3)
public let darkColor = UIColor(hex: 0x1C1C1E)
public let lightSeparatorColor = UIColor(hex: 0xEFEFF4)
public let darkSeparatorColor = UIColor(hex: 0x373737)


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
//MARK: - UIRectCorner

func setupCorners(_ view: UIView, corner: UIRectCorner, rect: CGRect, fColor: CGColor) {
    let shape = CAShapeLayer()
    shape.frame = rect
    shape.fillColor = fColor
    shape.lineWidth = 1.0
    shape.strokeColor = UIColor.clear.cgColor
    shape.path = UIBezierPath(roundedRect: rect,
                              byRoundingCorners: corner,
                              cornerRadii: CGSize(width: 2.0, height: 2.0)).cgPath
    view.layer.addSublayer(shape)
}

public func delay(duration: TimeInterval, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: completion)
}

public func touchAnim(_ sender: UIView, frValue: CGFloat = 0.5, toValue: CGFloat = 1.0, completion: @escaping () -> Void) {
    let opacity = CABasicAnimation(keyPath: "opacity")
    let duration: TimeInterval = 0.15
    opacity.duration = duration
    opacity.fromValue = frValue
    opacity.toValue = toValue
    opacity.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    sender.layer.add(opacity, forKey: nil)
    delay(duration: duration) { completion() }
}

public func setupSelectedCell(selectC: UIColor, completion: @escaping (UIView) -> Void) {
    let selectedView = UIView(frame: .zero)
    selectedView.backgroundColor = selectC
    completion(selectedView)
}

public func handleText(_ number: Double, completion: @escaping (String) -> Void) {
    var text: String {
        if number >= 1000 && number < 999999 {
            return String(format: "%0.1f", locale: .current, number).replacingOccurrences(of: ".0", with: "")
        }
        
        if number > 999999 {
            return String(format: "%0.1f", locale: .current, number).replacingOccurrences(of: ".0", with: "")
        }
        
        return String(format: "%0.0f", locale: .current, number)
    }
    
    completion(text)
}

public func isTakePhoto(_ vc: UIViewController, imgPC: UIImagePickerController, edit: Bool) {
    let image = kUTTypeImage as String
    
    if !UIImagePickerController.isSourceTypeAvailable(.camera) {
        return
    }
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
        imgPC.sourceType = .camera
        
        if let available = UIImagePickerController.availableMediaTypes(for: .camera) {
            if available.contains(image) {
                imgPC.mediaTypes = [image]
            }
            
            if UIImagePickerController.isCameraDeviceAvailable(.front) {
                imgPC.cameraDevice = .front
            }
            
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                imgPC.cameraDevice = .rear
            }
        }
        
    } else {
        return
    }
    
    imgPC.showsCameraControls = true
    imgPC.allowsEditing = edit
    imgPC.modalPresentationStyle = .custom
    vc.present(imgPC, animated: true, completion: nil)
}

public func isPhotoFromLibrary(_ vc: UIViewController, imgPC: UIImagePickerController, edit: Bool) {
    let image = kUTTypeImage as String
    
    if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) ||
        !UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
        return
    }
    
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        imgPC.sourceType = .photoLibrary
        
        if let available = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
            if available.contains(image) {
                imgPC.mediaTypes = [image]
            }
        }
        
    } else if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
        imgPC.sourceType = .savedPhotosAlbum
        
        if let available = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum) {
            if available.contains(image) {
                imgPC.mediaTypes = [image]
            }
        }
        
    } else {
        return
    }
    
    imgPC.allowsEditing = edit
    imgPC.modalPresentationStyle = .custom
    vc.present(imgPC, animated: true, completion: nil)
}

public func isVideoFromLibrary(_ vc: UIViewController, imgPC: UIImagePickerController, edit: Bool) {
    let movie = kUTTypeMovie as String
    
    if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) ||
        !UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
        return
    }
    
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        imgPC.sourceType = .photoLibrary
        
        if let available = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
            if available.contains(movie) {
                imgPC.mediaTypes = [movie]
            }
        }
        
    } else if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
        imgPC.sourceType = .savedPhotosAlbum
        
        if let available = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum) {
            if available.contains(movie) {
                imgPC.mediaTypes = [movie]
            }
        }
        
    } else {
        return
    }
    
    imgPC.allowsEditing = edit
    imgPC.modalPresentationStyle = .custom
    vc.present(imgPC, animated: true, completion: nil)
}

public func isVideo(_ vc: UIViewController, imgPC: UIImagePickerController, edit: Bool) {
    let movie = kUTTypeMovie as String
    
    if !UIImagePickerController.isSourceTypeAvailable(.camera) {
        return
    }
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
        imgPC.sourceType = .camera
        
        if let available = UIImagePickerController.availableMediaTypes(for: .camera) {
            if available.contains(movie) {
                imgPC.mediaTypes = [movie]
            }
            
            if UIImagePickerController.isCameraDeviceAvailable(.front) {
                imgPC.cameraDevice = .front
            }
            
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                imgPC.cameraDevice = .rear
            }
        }
        
    } else {
        return
    }
    
    imgPC.showsCameraControls = true
    imgPC.allowsEditing = edit
    imgPC.modalPresentationStyle = .custom
    vc.present(imgPC, animated: true, completion: nil)
}

public func isCamera(_ vc: UIViewController, imgPC: UIImagePickerController, edit: Bool) {
    let image = kUTTypeImage as String
    let movie = kUTTypeMovie as String
    
    if !UIImagePickerController.isSourceTypeAvailable(.camera) {
        return
    }
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
        imgPC.sourceType = .camera
        
        if let available = UIImagePickerController.availableMediaTypes(for: .camera) {
            if available.contains(image) {
                imgPC.mediaTypes = [image, movie]
            }
            
            if UIImagePickerController.isCameraDeviceAvailable(.front) {
                imgPC.cameraDevice = .front
            }
            
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                imgPC.cameraDevice = .rear
            }
        }
        
    } else {
        return
    }
    
    imgPC.showsCameraControls = true
    imgPC.allowsEditing = edit
    imgPC.modalPresentationStyle = .custom
    vc.present(imgPC, animated: true, completion: nil)
}

//MARK: - BorderView

public func setupAnimBorderView(_ view: UIView) {
    let posAnim = CABasicAnimation(keyPath: "position.x")
    posAnim.fromValue = view.center.x + 2.0
    posAnim.toValue = view.center.x - 2.0
    
    let borderAnim = CASpringAnimation(keyPath: "borderColor")
    borderAnim.damping = 5.0
    borderAnim.initialVelocity = 10.0
    borderAnim.toValue = UIColor(hex: 0xFF755F).cgColor
    
    let animGroup = CAAnimationGroup()
    animGroup.duration = 0.1
    animGroup.timingFunction = CAMediaTimingFunction(name: .easeIn)
    animGroup.autoreverses = true
    animGroup.animations = [posAnim, borderAnim]
    
    view.layer.add(animGroup, forKey: nil)
    view.layer.borderColor = UIColor(hex: 0xFF755F).cgColor
}

public func borderView(_ view: UIView, color: UIColor = .white) {
    view.layer.borderColor = color.cgColor
}


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
