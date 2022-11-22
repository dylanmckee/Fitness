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
        let query  = PFQuery(className: "History")
                query.includeKeys(["times","workouts"])
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        
        let history = historyTable[indexPath.row]
        
        var dict : [String: String] = [:]
        
        var res = ""
    
        
        
        let user = history["author"] as! PFUser
        
        let workouts : [String] = history["workouts"] as! [String]
        let times : [String] = history["times"] as! [String]
        
        for i in 0...workouts.count-1{
            res += workouts[i] + ": " + times[i] + " minutes \n"
            dict[workouts[i]] = times[i]
        }
        
        
        

        
        
        //cell.workoutTime.text = (history["workouts"] as? [String])?.joined(separator:",")
        cell.workoutTime.text = res
        cell.date.text = "Date: " + (history["date"] as! String)
        
        return cell
    }
    

}

