//
//  LoginController.swift
//  LostPostcards
//
//  Created by Small Factory Studios on 9/9/17.
//  Copyright © 2017 Small Factory Studios. All rights reserved.
//

import UIKit
import Firebase

class LogInController: UIViewController {
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Dont' have an account?  ", attributes: [
            NSAttributedStringKey.foregroundColor: UIColor.lightGray,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)
            ])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [
            NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 210, green: 58, blue: 58),
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
            ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    private let logoContainerView: UIView = {
        let view = UIView()
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "lost-postcards-logo"))
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints({ make in
            make.center.equalTo(view.snp.center)
        })
        
        view.backgroundColor = UIColor.rgb(red: 210, green: 58, blue: 58, alpha: 1.0)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white:0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white:0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .blue
        button.backgroundColor = UIColor.rgb(red: 210, green: 58, blue: 58)
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = .white
        view.addSubview(dontHaveAccountButton)
        view.addSubview(logoContainerView)
        
        logoContainerView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(150)
        }
        
        dontHaveAccountButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.equalTo(0)
            make.trailing.leading.equalTo(0)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        setupInputFields()
    }
    
    private func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(logoContainerView.snp.bottom).offset(40)
            make.leading.equalTo(40)
            make.trailing.equalTo(-40)
            make.height.equalTo(140)
        }
    }
    
    
    @objc private func handleTextInputChange() {
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 &&
            passwordTextField.text?.characters.count ?? 0 > 0
        
        if isFormValid {
            loginButton.backgroundColor = UIColor.rgb(red: 210, green: 58, blue: 58)
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = UIColor.rgb(red: 121, green: 121, blue: 121)
            loginButton.isEnabled = false
        }
    }
    
    @objc private func handleShowSignUp() {
        let signupVC = SignupController()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @objc private func handleLogIn() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            if let err = err {
                debugPrint("Failed to sign in with email : ", err)
                return
            }
            
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {
                return
            }
            
            mainTabBarController.setupViewControllers()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
