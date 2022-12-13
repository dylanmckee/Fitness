//"
//  ExerciseViewController.swift
//  Fitness
//
//  Created by Dylan McKee on 11/9/22.
//

import UIKit
import JellyGif
import AVFoundation
import Parse

class ExerciseViewController: UIViewController {

    var sound_effect : AVAudioPlayer?
    var exerciseID = String()
    @IBOutlet weak var timeInput: UITextField!
    @IBOutlet weak var exerciseGif: UIImageView!
    var starting_time = 70
    var seconds = 70
    private var timer: Timer?
    var isTimeRunning = false
    var resumeTapped = false
    var exerciseName = String()
    let date = Date()
    var foundDate = false
    let dateFormatter = DateFormatter()
    
    var currentDate = ""
    
    @IBOutlet weak var exerciseLabel: UILabel!
    

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(exerciseName, exerciseID)
        exerciseLabel.text = exerciseName.capitalized
        let gifURL = "https://d205bpvrqc9yn1.cloudfront.net/" + exerciseID + ".gif"
        let imageURL = UIImage.gifImageWithURL(gifURL)
        let imageView = UIImageView(image: imageURL)
        imageView.frame = CGRect(x:20.0,y:390.0, width: self.view.frame.size.width - 90, height: 200.0)
        view.addSubview(imageView)
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back", style: .plain, target: nil, action: nil)
        
        self.dateFormatter.dateFormat = "dd/MM/yyyy"
        self.currentDate = self.dateFormatter.string(from: date)
        
        let query  = PFQuery(className: "History")
        query.includeKeys(["date"])
        
        query.findObjectsInBackground{ (success,error) in
            if success != nil{
                if success?.count != 0{
                    for i in 0...success!.count - 1{
                        if success?[i]["date"] as! String == self.currentDate && self.foundDate == false{
                            self.foundDate  = true
                            
                        }
                        
                    }
                }
            }
            
            }
        
        
    
    }
    
    func getURL() -> String {
        let url = ""
        
        return url
    }

    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBAction func onStartButton(_ sender: Any) {
        if !isTimeRunning{
            if timeInput.hasText{ //validate input
               // validate that input was integer
                if let st = Int(timeInput.text!){
                    starting_time = st*60
                    seconds = st*60
                    setTimerLabel()
                    runTimer()
                }
                else{
                    print("Not an integer")
                }
            }
            else{
                print("No time entered")
            }
        }
    }
    @IBAction func onPauseButton(_ sender: Any) {
        if isTimeRunning{
            if self.resumeTapped == false {
                timer!.invalidate()
                 self.resumeTapped = true
                pauseButton.setTitle("Resume", for: .normal)
            } else {
                 runTimer()
                 self.resumeTapped = false
                pauseButton.setTitle("Pause", for: .normal)
            }
        }
    }
    @IBAction func onResetButton(_ sender: Any) {
        if isTimeRunning{
            timer!.invalidate()
            seconds = starting_time   //reset time
            setTimerLabel()
            isTimeRunning = false
            resumeTapped = false
            pauseButton.setTitle("Pause", for: .normal)

        }

    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ExerciseViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimeRunning = true
    }
    
    @objc func updateTimer() {
        
        seconds -= 1     //Decrement
        setTimerLabel()
        // call alarm
        if seconds <= 0{
            self.timer?.invalidate()
            playAlarm()
        }
    }

    func playAlarm(){
        let path = Bundle.main.path(forResource: "alarm.wav", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
             sound_effect = try AVAudioPlayer(contentsOf: url)
            sound_effect?.play()

    } catch {
            print("Error!")
        }
    }
    
    func setTimerLabel(){
        // get minutes and seconds for display
        let minutes = seconds/60
        let leftover_seconds = seconds % 60
        var string_leftover_seconds = ""
        string_leftover_seconds = String(leftover_seconds)
        //add leading 0 for < 10 seconds
        if leftover_seconds < 10{
            string_leftover_seconds = "0" + String(leftover_seconds)
        }
        // set label
        timerLabel.text = String(minutes) + "  :  " + string_leftover_seconds
        
    }

    @IBAction func onBackButton(_ sender: Any) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let mainView = main.instantiateViewController(withIdentifier: "tabBarController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = mainView

        }
    
    
    @IBAction func onDoneButton(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let mainView = main.instantiateViewController(withIdentifier: "tabBarController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = mainView
        
        if self.foundDate == false{
            let post = PFObject(className: "History")
            post["author"] = PFUser.current()!
            post["date"] = currentDate
            post["exercise"] = exerciseName
            post["workouts"] = [exerciseName]
            post["times"] = [String(starting_time / 60)]
            post.saveInBackground{ (success, error) in
                if success{
                    print("saved")
                    self.dismiss(animated: true,completion: nil)
                }else{
                    print("error!")
                }
            }
        }else{
            let query  = PFQuery(className: "History")
            query.includeKeys(["workout"])
            
            query.findObjectsInBackground{ (success,error) in
                if success != nil{
                    
                    for i in 0...success!.count - 1{
                        var workouts: [String] = []
                        var times : [String] = []
                        if success?[i]["date"] as! String == self.currentDate{
                            
                            workouts = success?[i]["workouts"] as! [String]
                            workouts.append(self.exerciseName)
                            
                          
                            times = success?[i]["times"] as! [String]
                            times.append(String(self.starting_time/60))
                            
                            
                            success?[i]["workouts"] = workouts
                            success?[i]["times"] = times
                            
                            
                            success?[i].saveInBackground()
                            
                            }
                        }
                    }
                }
            }

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


