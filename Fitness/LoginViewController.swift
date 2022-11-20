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
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
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
                self.performSegue(withIdentifier: "SignupSegue", sender: nil)
                
            }
            else{
                print("Error: \(String(describing: error?.localizedDescription))")
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
