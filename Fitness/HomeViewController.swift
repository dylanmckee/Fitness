//
//  HomeViewController.swift
//  Fitness
//
//  Created by Irvine Martinez on 11/18/22.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    struct gym{
        let title:String
        let imageName:String
    }
    
    
    let data:[gym] = [
        gym(title: "Chest", imageName: "chest"),
        gym(title: "Back", imageName: "back"),
        gym(title: "Arms", imageName: "arm"),
        gym(title: "Legs", imageName: "legs")
    ]
    
    var currentLbs = ""
    var currentName = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    @IBOutlet weak var weightLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        let query  = PFQuery(className: "_User")
        query.includeKeys(["name","weight"])
        
        query.findObjectsInBackground{(posts,error) in
            if posts != nil{
               // let user = posts["username"] as! String
                for i in 0...posts!.count - 1{
                    if posts?[i]["username"] as? String == PFUser.current()?.username!{
                        self.currentName = posts?[i]["username"] as! String
                        self.currentLbs =  posts?[i]["weight"] as! String
                        self.nameLabel.text = "Welcome " +  self.currentName
                        self.weightLabel.text = self.currentLbs + " lbs"
                    }
                }
                    
                
            }
            
        }

       

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gym = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.label.text = gym.title
        cell.imageIconView.image = UIImage(named: gym.imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "loginScreen")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = loginViewController
    }
    
    
}
