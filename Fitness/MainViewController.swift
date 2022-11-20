//
//  MainViewController.swift
//
//
//  Created by Dylan McKee on 10/16/22.
//

import UIKit
import Parse
import AlamofireImage
import DropDown

class MainViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var showsCommentBar = false
    var selectedPost : PFObject!
    var posts = [PFObject]()
    
    let myDropDown = DropDown()
    let partsArray = ["Back", "Chest", "Legs", "Biceps", "Shoulders"]
    
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var parts_label: UILabel!
    @IBOutlet weak var dropDownView: UIView!
    
    @IBAction func tappedDropDownButton(_ sender: Any) {
        myDropDown.show()
        print((self.parts_label.text ?? "select") as String)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myDropDown.anchorView = dropDownView
        myDropDown.dataSource = partsArray
        
        myDropDown.bottomOffset = CGPoint(x: 0, y: (myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.topOffset = CGPoint(x: 0, y: -(myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.direction = .bottom
        
        myDropDown.selectionAction = { (index: Int, item: String) in
            self.parts_label.text = self.partsArray[index]
            self.parts_label.textColor = .black
            
        }
  
        
        
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        becomeFirstResponder()
    }
    


    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
            
        
    }
    
    

    @IBOutlet var onLogoutButton: UIView!
    
    @IBAction func onLogoutButton(_ sender: UIButton) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "loginScreen")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = loginViewController
    }
    
    
    @IBAction func onBackButton(_ sender: Any) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "MainNavigationController")
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
