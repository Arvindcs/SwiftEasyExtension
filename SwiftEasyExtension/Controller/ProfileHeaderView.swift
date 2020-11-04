//
//  ProfileHeaderView.swift
//  Fashi
//
//  Created by Arvind on 03/11/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

protocol ProfileHeaderViewDelegate: class {
    func handleEditAvatarDidTap()
}

class ProfileHeaderView: UIView {
    
    //MARK: - Properties
    weak var delegate: ProfileHeaderViewDelegate?
    
    let avatarView = UIView()
    let editAvatarBtn = UIButton()
    let avatarImgView = UIImageView()
    let nameLbl = UILabel()
    let prefixLbl = UILabel()
    let subnameLbl = UILabel()
    var avatarImg: UIImage?
    let prefixView = UIView()
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configures

extension ProfileHeaderView {
    
    func setupProfileView(_ mainView: UIView, dl: ProfileHeaderViewDelegate, animDl: CAAnimationDelegate) {
        let headerH: CGFloat = 10+130+20+36+20
        frame = CGRect(x: 0.0, y: 100.0, width: screenWidth, height: headerH)
        mainView.addSubview(self)
        
        //TODO: - AvatarView
        let avatarW: CGFloat = 130.0
        avatarView.backgroundColor = .white
        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = avatarW/2
        addSubview(avatarView)
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        
        //TODO: - AvatarIMGView
        let imgViewW: CGFloat = avatarW*0.86
        avatarImgView.contentMode = .scaleAspectFill
        avatarImgView.clipsToBounds = true
        avatarImgView.layer.cornerRadius = imgViewW/2.0
        avatarImgView.image = avatarImg
        insertSubview(avatarImgView, aboveSubview: avatarView)
        avatarImgView.translatesAutoresizingMaskIntoConstraints = false
        
        //TODO: - EditAvatar
        let editW: CGFloat = 30.0
        editAvatarBtn.clipsToBounds = true
        editAvatarBtn.backgroundColor = .white
        editAvatarBtn.layer.cornerRadius = editW/2.0
        editAvatarBtn.contentEdgeInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        editAvatarBtn.tintColor = defaultColor
        editAvatarBtn.addTarget(self, action: #selector(editAvatarDidTap), for: .touchUpInside)
        insertSubview(editAvatarBtn, aboveSubview: avatarImgView)
        editAvatarBtn.translatesAutoresizingMaskIntoConstraints = false
        delegate = dl
        
        //TODO: - Gradient
        setupGradientAvatarEditBtn(animDl: animDl)

        //TODO: - NameLbl
        nameLbl.configureNameForCell(false, txtColor: .black, fontSize: 30.0, isTxt: "", fontN: fontNamedBold)
        addSubview(nameLbl)
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        
        let subnameW: CGFloat = 22.0
        subnameLbl.configureNameForCell(true, txtColor: .darkGray, fontSize: 10.0, isTxt: "", fontN: fontNamedBold)
        subnameLbl.clipsToBounds = true
        subnameLbl.layer.cornerRadius = subnameW/2
        subnameLbl.layer.borderColor = UIColor.darkGray.cgColor
        subnameLbl.layer.borderWidth = 1.0
        subnameLbl.textAlignment = .center
        addSubview(subnameLbl)
        subnameLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarView.widthAnchor.constraint(equalToConstant: avatarW),
            avatarView.heightAnchor.constraint(equalToConstant: avatarW),
            avatarView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            avatarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            avatarImgView.widthAnchor.constraint(equalToConstant: imgViewW),
            avatarImgView.heightAnchor.constraint(equalToConstant: imgViewW),
            avatarImgView.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarImgView.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            
            editAvatarBtn.widthAnchor.constraint(equalToConstant: editW),
            editAvatarBtn.heightAnchor.constraint(equalToConstant: editW),
            editAvatarBtn.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: -3.0),
            editAvatarBtn.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: -10.0),

            nameLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLbl.topAnchor.constraint(equalTo: avatarImgView.bottomAnchor, constant: 20.0),
            
            subnameLbl.widthAnchor.constraint(equalToConstant: subnameW),
            subnameLbl.heightAnchor.constraint(equalToConstant: subnameW),
            subnameLbl.leadingAnchor.constraint(equalTo: nameLbl.trailingAnchor),
            subnameLbl.bottomAnchor.constraint(equalTo: nameLbl.topAnchor, constant: 15.0)
        ])
        
        //TODO: - Prefix
        prefixView.backgroundColor = .clear
        insertSubview(prefixView, aboveSubview: avatarImgView)
        prefixView.translatesAutoresizingMaskIntoConstraints = false
        prefixView.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        prefixView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        prefixView.centerXAnchor.constraint(equalTo: avatarImgView.centerXAnchor).isActive = true
        prefixView.centerYAnchor.constraint(equalTo: avatarImgView.centerYAnchor).isActive = true
        
        let prefix = "\(nameLbl.text!.prefix(1))"
        prefixLbl.configureNameForCell(true, txtColor: .white, fontSize: 40.0, isTxt: prefix)
        prefixView.addSubview(prefixLbl)
        prefixLbl.translatesAutoresizingMaskIntoConstraints = false
        prefixLbl.centerXAnchor.constraint(equalTo: prefixView.centerXAnchor).isActive = true
        prefixLbl.centerYAnchor.constraint(equalTo: prefixView.centerYAnchor).isActive = true
    }
    
    func setupGradientAvatarEditBtn(animDl: CAAnimationDelegate) {
     
        avatarView.setupGradient(width: 130.0, startC: UIColor(hex: 0xFF7B14), endC: defaultColor, animDl: animDl)
        editAvatarBtn.setupGradient(width: 30.0, startC: defaultColor, endC: UIColor(hex: 0xFF7B14), animDl: animDl, lineW: 3.0, clockwise: false)
    }
    
    @objc func editAvatarDidTap(_ sender: UIButton) {
  
        delegate?.handleEditAvatarDidTap()
    }
    
    func setupDarkMode(_ isDarkMode: Bool) {
        let subC: UIColor = isDarkMode ? .lightGray : .darkGray
        nameLbl.textColor = isDarkMode ? .white : .black
        subnameLbl.textColor = subC
        subnameLbl.layer.borderColor = subC.cgColor
        editAvatarBtn.backgroundColor = isDarkMode ? .black : .white
        prefixLbl.textColor = isDarkMode ? .black : .white
        avatarView.backgroundColor = isDarkMode ? .black : .white
    }
}
