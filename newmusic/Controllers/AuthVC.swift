//
//  AuthVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/1/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {
    
    let authView = AuthView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.addSubview(authView)
        authView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 0, right: 0))

    }

}
