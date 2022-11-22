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
import Foundation

class MainViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var equipmentList = [String]()
    var showsCommentBar = false
    var selectedPost : PFObject!
    var posts = [PFObject]()
    var bodyPart = ""
    let myDropDown = DropDown()
    let secondDropDown = DropDown()
    var jsonArray = [[String: Any]]()
    let partsArray = ["Back", "Chest", "Legs", "Biceps", "Shoulders"]
    // used to add selected body part to request URL
    let partsDict = ["back":"back","chest":"chest","legs":"upper%20legs","arm":"upper%20arms"]
    var exercisesList = [String]()
    var exerciseAndID = [String:String]()
    var selectedWorkout = String()
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var parts_label: UILabel!
    @IBOutlet weak var dropDownView: UIView!
    
    @IBOutlet weak var workout_list: UIButton!
    @IBOutlet weak var workoutButton: UILabel!
    @IBOutlet weak var secondDropDownView: UIView!
    @IBAction func tappedDropDownButton(_ sender: Any) {
        secondDropDown.show()
        let selected = (self.parts_label.text ?? "select") as String
        createExerciseArray(e: selected)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // API Call/GET request
        GETRequest()
        sleep(1)
        equipmentList.sort()
        myDropDown.anchorView = dropDownView
        myDropDown.dataSource = equipmentList
        
        myDropDown.bottomOffset = CGPoint(x: 0, y: (myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.topOffset = CGPoint(x: 0, y: -(myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.direction = .bottom
        
        myDropDown.selectionAction = { (index: Int, item: String) in
            self.parts_label.text = self.equipmentList[index]
            self.parts_label.textColor = .black
    
        }
        
    }
    func GETRequest(){
        let url = "https://exercisedb.p.rapidapi.com/exercises/bodyPart/" + ((partsDict[bodyPart])!)
        let headers = [
            "X-RapidAPI-Key": "f3a6f8a9d8msh00975fdcc1e2d68p141159jsnc026cd9f7459",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://exercisedb.p.rapidapi.com/exercises/bodyPart/" + ((partsDict[bodyPart])!))! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                do{
                    self.jsonArray = try JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
                    // create equipment list for selected body part
                    // list varies depending on selection
                    for e in self.jsonArray{
                        if !self.equipmentList.contains(e["equipment"] as! String){
                            self.equipmentList.append(e["equipment"] as! String)
                        }
                    }
                } catch let error as NSError {
                  print(error)
                }
            }
        })
        dataTask.resume()
        
        
    }
    
    func createExerciseArray(e:String){
        var exerciseArray = [String]()
        for i in jsonArray{
            if i["equipment"] as! String  == e {
                exerciseArray.append(i["name"] as! String )
                exerciseAndID[i["name"] as! String] = (i["id"] as! String)
                
            }
        }
        secondDropDown.anchorView = secondDropDownView
        secondDropDown.dataSource = exerciseArray
        
        secondDropDown.bottomOffset = CGPoint(x: 0, y: (secondDropDown.anchorView?.plainView.bounds.height)!)
        secondDropDown.topOffset = CGPoint(x: 0, y: -(secondDropDown.anchorView?.plainView.bounds.height)!)
        secondDropDown.direction = .bottom
        secondDropDown.selectionAction = { (index: Int, item: String) in
            self.workoutButton.text = exerciseArray[index]
            self.workoutButton.textColor = .black
    
        }
    }
    @IBAction func tappedSecondDropDown(_ sender: Any) {
        myDropDown.show()
        selectedWorkout = (self.workoutButton.text ?? "select") as String

    }
    @IBAction func onButtonClick(_ sender: Any) {
        print(self.selectedWorkout)
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
        let loginViewController = main.instantiateViewController(withIdentifier: "tabBarController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = loginViewController
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    if segue.destination is ExerciseViewController {
        let vc = segue.destination as? ExerciseViewController
        //send bodyPart to MainViewController
    
        selectedWorkout = (self.workoutButton.text ?? "select") as String
        vc?.exerciseName = selectedWorkout
        vc?.exerciseID = exerciseAndID[selectedWorkout] ?? "-1"
        }
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
