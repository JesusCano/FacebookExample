//
//  ProfileViewController.swift
//  FacebookExample
//
//  Created by Jesus Jaime Cano Terrazas on 11/09/21.
//

import UIKit
import FBSDKCoreKit
import AlamofireImage
import FBSDKLoginKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getUserInfo()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - User Interaction
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logOut()
        NotificationCenter.default.post(name: NSNotification.Name("SHOW_LOGIN_SCREEN"), object: nil)
        
    }
    
    
    // MARK: - Private Methods
    
    private func getUserInfo() {
        let connection = GraphRequestConnection()
        let params = [
            "fields": "id, name, picture.width(400).height(400)"]
        
        let request = GraphRequest(graphPath: "/me", parameters: params)
        connection.add(request) { request, result, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("request: \(result)")
                
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: result, options: [])
                    let facebookResponse = try JSONDecoder().decode(FacebookResponseModel.self, from: data)
                    
                    self.profileNameTextLabel.text = facebookResponse.name
                    
                    if let url = URL(string: facebookResponse.picture.data.url) {
                        self.profileImage.af.setImage(withURL: url)
                        self.profileImage.circleImage()
                    }
                } catch let  error {
                    print(error)
                }
            }
            
        }
        
        connection.start()
        
    }

}
