//
//  HomeViewController.swift
//  Fitness
//
//  Created by Irvine Martinez on 11/18/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    struct Gym{
        let title : String
        let imageName : String
    }
    
    let data : [Gym] = [
        Gym(title: "Chest", imageName: "chest"),
        Gym(title: "Back", imageName: "back"),
        Gym(title: "Arms", imageName: "arm"),
        Gym(title: "Legs", imageName: "legs")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gym = data[indexPath.row]
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.imageIcon.image = UIImage(named: gym.imageName)
        cell.label.text = gym.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
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
