//
//  ShareController.swift
//  LostPostcards
//
//  Created by Small Factory Studios on 9/10/17.
//  Copyright © 2017 Small Factory Studios. All rights reserved.
//

import UIKit

class SharePhotoController: UIViewController {
    
    static let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdateFeed")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240, alpha: 1)
        
//        setupImageAndTextViews()
    }
    
    private func saveToDataBaseWithImageURL(imageURL: String) {
        
        NotificationCenter.default.post(name: SharePhotoController.updateFeedNotificationName, object: nil)
    
//        guard let caption = textView.text else { return }
//        guard let postImage = selectedImage else { return }
//
//        guard let uid = Auth.auth().currentUser?.uid else {
//            return
//        }
//
//        let userPostRef = Database.database().reference().child("posts").child(uid)
//        let ref = userPostRef.childByAutoId()
//
//        let values = ["imageUrl": imageURL, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String: Any]
//
//        ref.updateChildValues(values) { (err, dbRef) in
//            if let err = err {
//                self.navigationItem.rightBarButtonItem?.isEnabled = true
//                debugPrint("Failed to post to DB ", err)
//                return
//            }
//
//            debugPrint("Successfully saved post to DB")
//            self.dismiss(animated: true, completion: nil)
//
//            NotificationCenter.default.post(name: SharePhotoController.updateFeedNotificationName, object: nil)
//        }
    }
    
    @objc func handleShare() {
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
