//
//  MainViewController.swift
//
//
//  Created by Dylan McKee on 10/16/22.
//

import UIKit
import Parse
import AlamofireImage

class MainViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var showsCommentBar = false
    var selectedPost : PFObject!
    var posts = [PFObject]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
 
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        becomeFirstResponder()
    }
    


    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
            
        
    }
    
    

    
    @IBAction func onLogoutButton(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = loginViewController
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
