//
//  RegistrationVCViewController.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/2/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class RegistrationVC: UIViewController {

    // UI Components
    
    var user: MusicUser!
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "newmusicLogoWhite")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 95).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 95).isActive = true
        return iv
    }()
    
    let appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up to share your favorite"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let appDescriptionLine2Label: UILabel = {
        let label = UILabel()
        label.text = "songs with your friends."
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    let usernameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 18, height: 48)
        tf.placeholder = "Enter Username"
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 18, height: 48)
        tf.placeholder = "Enter Email"
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 18, height: 48)
        tf.placeholder = "Enter Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
        
    @objc func handleTextInputChange() {
        let isFormValid = self.usernameTextField.text?.isEmpty != true && self.emailTextField.text?.isEmpty != true && (passwordTextField.text?.count)! > 5
        
        if isFormValid {
            self.signUpButton.isEnabled = true
            self.signUpButton.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
        } else {
            self.signUpButton.isEnabled = false
            self.signUpButton.backgroundColor = UIColor.lightText
        }
    }
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
//        button.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
        button.backgroundColor = UIColor.lightText
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    let goToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.addTarget(self, action: #selector(handleGoToLogin), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleGoToLogin() {
        let loginController = LoginVC()
        navigationController?.pushViewController(loginController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGesture()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNotificationObservers()
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }

    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true)
    }
    
    let registeringHUD = JGProgressHUD(style: .dark)
    
    @objc fileprivate func handleRegister() {
        self.handleTapDismiss()
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        checkIfUsernameIsTaken()
        
        registeringHUD.textLabel.text = "Registering"
        registeringHUD.show(in: view)
        
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if let err = err {
                self.showHudWithError(error: err)
                return
            }
            self.saveInfoToFirestore()
            
            print("Successfully Registered User:", res?.user.uid ?? "")
            
            if self.user.fullName == "" {
                let nextStepController = RegistrationStep2VC()
                nextStepController.user = self.user
                self.navigationController?.pushViewController(nextStepController, animated: true)
            }
            self.registeringHUD.dismiss(animated: true)
        }
    }
    
    fileprivate func saveInfoToFirestore() {
        let username = usernameTextField.text!
        
        let currentUser = Auth.auth().currentUser
        self.user = MusicUser(user: currentUser!)
        self.user.displayName = username.lowercased()
    }
    
    fileprivate func showHudWithError(error: Error) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed Registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 3)
    }
    
    fileprivate func checkIfUsernameIsTaken() {
        print("😳😳😳 Username Needs to be Checked")
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        print(keyboardFrame)
        
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        print(bottomSpace)
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        logoImageView,
        SpacerViewHeight(space: 10),
        appDescriptionLabel,
        appDescriptionLine2Label,
        SpacerViewHeight(space: 20),
        usernameTextField,
        emailTextField,
        passwordTextField,
        signUpButton,
        SpacerViewHeight(space: 50)
        ])
    
    fileprivate func setupLayout() {
        navigationController?.isNavigationBarHidden = true
        setupGradientLayer()
        
        view.addSubview(stackView)
        view.addSubview(goToLoginButton)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if #available(iOS 11.0, *) {
            goToLoginButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -15, paddingRight: 0, width: 50, height: 20)
        } else {
            goToLoginButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -15, paddingRight: 0, width: 50, height: 20)
        }
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        // make sure to user cgColor
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }

}
