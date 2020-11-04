//
//  ImagePickerHelper.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 07/03/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

class ImagePickerHelper: NSObject {
    
    var vc: UIViewController
    var completion: ((UIImage?) -> Void)
    var imgPicker = UIImagePickerController()
    
    init(vc: UIViewController, completion: @escaping (UIImage?) -> Void) {
        self.vc = vc
        self.completion = completion
        
        super.init()
        imgPicker.delegate = self
        isShowPicked()
    }
}

extension ImagePickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func isShowPicked() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePhoto = NSLocalizedString("Take Photo", comment: "ImagePickerHelper.swift: Take Photo")
        let takePhotoAC = UIAlertAction(title: takePhoto, style: .default, handler: { _ in
            isTakePhoto(self.vc, imgPC: self.imgPicker, edit: true)
        })
        
        let photoFr = NSLocalizedString("Photo From Library", comment: "ImagePickerHelper.swift: Photo From Library")
        let photoFromLibraryAC = UIAlertAction(title: photoFr, style: .default, handler: { _ in
            isPhotoFromLibrary(self.vc, imgPC: self.imgPicker, edit: true)
        })
        
        let cancel = NSLocalizedString("Cancel", comment: "ImagePickerHelper.swift: Cancel")
        let cancelAC = UIAlertAction(title: cancel, style: .cancel, handler: nil)
        
        alert.addAction(takePhotoAC)
        alert.addAction(photoFromLibraryAC)
        alert.addAction(cancelAC)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image: UIImage?
        
        if let editedIMG = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = editedIMG
        }
        
        completion(image)
        vc.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        vc.dismiss(animated: true, completion: nil)
    }
}
