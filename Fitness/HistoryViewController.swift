//
//  HistoryViewController.swift
//  Fitness
//
//  Created by Erfanullah  Arsala on 11/16/22.
//

import UIKit
import Parse


class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    var historyTable: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyLabel.text = (PFUser.current()?.username)! + "'s Workout History"
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query  = PFQuery(className: "_User")
                query.includeKeys(["username"])
    
        query.findObjectsInBackground{(posts,error) in
                if posts != nil{
                       
                       self.historyTable = posts!
                       self.historyTableView.reloadData()
                    
            }
                
            }
       
    }
    

    @IBOutlet weak var historyTableView: UITableView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
      
   
    @IBOutlet weak var historyLabel: UILabel!
    
    
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier:"historyCell", for: indexPath)
        
        let history = historyTable[indexPath.row]
        print(history)
        let user = history["username"] as! String
    
        
        cell.textLabel?.text = user
        
        return cell
    }
    

}

