//
//  LoginViewController.swift
//  Fitness
//
//  Created by Dylan McKee on 10/16/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameSignup: UITextField!
    @IBOutlet weak var nameSignup: UITextField!
    @IBOutlet weak var weightSignup: UITextField!
    @IBOutlet weak var passwordSignup: UITextField!
    
    
    
    @IBOutlet weak var usernameSignin: UITextField!
    @IBOutlet weak var passwordSignin: UITextField!
    

    @IBAction func onSignin(_ sender: Any) {
        let username = usernameSignin.text!
        let password = passwordSignin.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password)
        { (user, error) in
            if user != nil {
                let main = UIStoryboard(name: "Main", bundle: nil)
                                let loginViewController = main.instantiateViewController(withIdentifier: "tabBarController")
                                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
                                delegate.window?.rootViewController = loginViewController
            }
            else{
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    
    @IBAction func onSignup(_ sender: Any) {
        var user = PFUser()
        user.username = usernameSignup.text
        user.password = passwordSignup.text
        user["name"] = nameSignup.text
        user["weight"] = weightSignup.text
        
        user.signUpInBackground{ (success, error) in
            if success {
                let main = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = main.instantiateViewController(withIdentifier: "tabBarController")
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
                delegate.window?.rootViewController = loginViewController
                
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
