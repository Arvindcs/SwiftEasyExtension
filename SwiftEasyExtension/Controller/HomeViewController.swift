//
//  ViewController.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 03/11/2020.
//  Copyright © 2020 Arvind. All rights reserved.

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    private let profileView = ProfileHeaderView()
    private var imagePickerHelper: ImagePickerHelper?
    private let userName = "Arvind Patel"
    private var isProfilePicture = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileView()
    }
    
    //TODO :-
    func setupProfileView() {
        profileView.setupProfileView(view, dl: self, animDl: self)
        userName.fetchFirstLastName { (fn, ln) in
         
            self.profileView.prefixLbl.text = "\(fn.prefix(1) + ln.prefix(1))".uppercased()
            self.profileView.subnameLbl.text = nil
        }
    }
}

extension HomeViewController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        profileView.editAvatarBtn.setImage(UIImage(named: "icon-small-pencil")?.withRenderingMode(.alwaysTemplate), for: .normal)
        profileView.prefixLbl.isHidden = isProfilePicture
        profileView.avatarImgView.image = profileView.avatarImg
        profileView.subnameLbl.isHidden = profileView.subnameLbl.text == nil
        
        if !profileView.prefixLbl.isHidden {
            let gradientLayer = createGradientLayer(width: 120.0, height: 50.0, startC: defaultColor, endC: UIColor(hex: 0xFF7B14))
            profileView.prefixView.layer.addSublayer(gradientLayer)
            profileView.prefixView.mask = profileView.prefixLbl
        }
        
        if !profileView.subnameLbl.isHidden {
            profileView.subnameLbl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.333) {
                    self.profileView.subnameLbl.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.334, relativeDuration: 0.333) {
                    self.profileView.subnameLbl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.666, relativeDuration: 0.333) {
                    self.profileView.subnameLbl.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            }, completion: nil)
        }
    }
}

extension HomeViewController: ProfileHeaderViewDelegate {
    
    func handleEditAvatarDidTap() {
        //let hud = createdHUD()
        imagePickerHelper = ImagePickerHelper(vc: self, completion: { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.isProfilePicture = true
                self.profileView.avatarImg = image
                self.profileView.setupGradientAvatarEditBtn(animDl: self)
            }
            //TODO:- Uncomment below code  if you want to upload image in Server
            /*
            ImgeUpload.sharedInstance.uploadImageToImgeUpload(image) { (link) in
                DispatchQueue.main.async {
                    self.profileView.prefixLbl.isHidden = true
                    self.profileView.avatarImg = image
                    self.profileView.setupGradientAvatarEditBtn(animDl: self)
                }
            }
             */
        })
    }
}
