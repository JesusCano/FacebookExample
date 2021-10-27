//
//  ViewController.swift
//  FacebookExample
//
//  Created by Jesus Jaime Cano Terrazas on 11/09/21.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let loginButton = FBLoginButton(permissions: [.email, .publicProfile, .userFriends])
//        loginButton.center = view.center
//        view.addSubview(loginButton)
    }
    
    // MARK: - User Interaction

    @IBAction func facebookLoginButttonPressed(_ sender: Any) {
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: [.email, .publicProfile, .userFriends, .userEvents, .userPhotos, .userVideos], viewController: self) { loginResult in
            
            switch loginResult {
            
            case .success(granted: let granted, declined: let declined, token: let token):
                print("Granted: \(granted)")
                print("Declined: \(declined)")
                print("Token: \(token?.tokenString ?? "")")
                
                NotificationCenter.default.post(name: NSNotification.Name("SHOW_PROFILE_SCREEN"), object: nil)
            case .cancelled:
                print("User has cancelled Login")
            case .failed(let error):
                print("Login Error: \(error.localizedDescription)")
            }
        }
    }
    
}

