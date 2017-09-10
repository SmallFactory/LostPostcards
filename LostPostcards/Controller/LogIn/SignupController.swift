//
//  SignupController.swift
//  LostPostcards
//
//  Created by Small Factory Studios on 9/9/17.
//  Copyright © 2017 Small Factory Studios. All rights reserved.
//

import UIKit
import SnapKit
import SwiftHEXColors
import Firebase

class SignupController: UIViewController {
    
    private let bgView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let plusPhotoButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white:0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    private let userNameTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white:0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    private let passwordTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white:0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    private let signupButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .blue
        button.backgroundColor = UIColor.rgb(red: 210, green: 58, blue: 58)
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private let alreadyHaveAccountButton:UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [
            NSAttributedStringKey.foregroundColor: UIColor.lightGray,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)
            ])
        
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [
            NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 210, green: 58, blue: 58),
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
            ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        setupInputFields()
    }
    
    private func setupInputFields() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField, signupButton])
        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(plusPhotoButton.snp.bottom).offset(20)
            make.leading.equalTo(40)
            make.trailing.equalTo(-40)
            make.height.equalTo(200)
        }
    }
    
    private func createUI() {
        
        view.addSubview(bgView)
        bgView.backgroundColor = SFSStyles.color.white.value
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(40)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(140)
            make.height.equalTo(140)
        }
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(50)
        }
    }
    
    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 &&
            userNameTextField.text?.characters.count ?? 0 > 0 &&
            passwordTextField.text?.characters.count ?? 0 > 0
        
        if isFormValid {
            signupButton.backgroundColor = UIColor.rgb(red: 210, green: 58, blue: 58)
            signupButton.isEnabled = true
        } else {
            signupButton.backgroundColor = UIColor.rgb(red: 121, green: 121, blue: 121)
            signupButton.isEnabled = false
        }
    }
    
    @objc func handleProfilePhoto() {
        print("HANDLE PHOTO")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleAlreadyHaveAccount() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text, email.characters.count > 0,
            let username = userNameTextField.text, username.characters.count > 0,
            let password = passwordTextField.text, password.characters.count > 0 else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                debugPrint("Failed to create user", err)
                return
            }
            
            guard let image = self.plusPhotoButton.imageView?.image else {
                return
            }
            
            guard let updateData = UIImageJPEGRepresentation(image, 0.3) else {
                return
            }
            
            let fileName = UUID().uuidString
            
            Storage.storage().reference().child("profile_images").child(fileName).putData(updateData, metadata: nil, completion: { (metaData, err) in
                if let err = err {
                    debugPrint("Failed to upload profile image : ", err)
                    return
                }
                
                guard let profileImageURL = metaData?.downloadURL()?.absoluteString else {
                    return
                }
                debugPrint("Successfully uploaded profile image : ", profileImageURL )
                
                guard let uid = user?.uid else { return }
                
                let dictionaryValues = ["username":username, "profileImageUrl": profileImageURL]
                let values = [uid:dictionaryValues]
                Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if let err = err {
                        debugPrint("Failed to save user info into DB : ", err)
                        return
                    }
                    
                    debugPrint("Successfully save user info to DB")
                })
                
                debugPrint("Successfully created user", user?.uid ?? "")
                guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {
                    return
                }
                print("successfully logged back in with user : ", user?.uid ?? "")
                
                mainTabBarController.setupViewControllers()
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
}

extension SignupController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        
        dismiss(animated: true, completion: nil)
    }
}

extension SignupController: UINavigationControllerDelegate {
    
}
