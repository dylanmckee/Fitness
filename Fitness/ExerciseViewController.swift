//
//  ExerciseViewController.swift
//  Fitness
//
//  Created by Dylan McKee on 11/9/22.
//

import UIKit
import JellyGif

class ExerciseViewController: UIViewController {


    @IBOutlet weak var exerciseGif: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let gifURL : String = "https://d205bpvrqc9yn1.cloudfront.net/0001.gif"
        let imageURL = UIImage.gifImageWithURL(gifURL)
        let imageView = UIImageView(image: imageURL)
        imageView.frame = CGRect(x:20.0,y:390.0, width: self.view.frame.size.width - 90, height: 200.0)
        view.addSubview(imageView)
//        let url = URL(string: gifURL)!
//        let imageView2 = JellyGifImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

       // imageView2.startGif(with: .localPath(url))
        //imageView.af.setImage(withURL: url)
        // Do any additional setup after loading the view.
    }
    var seconds = 60
    var timer = Timer()
    var isTimeRunning = false
    var resumeTapped = false
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBAction func onStartButton(_ sender: Any) {
        runTimer()
    }
    @IBAction func onPauseButton(_ sender: Any) {
        if self.resumeTapped == false {
            timer.invalidate()
             self.resumeTapped = true
        } else {
             runTimer()
             self.resumeTapped = false
        }
    }
    @IBAction func onResetButton(_ sender: Any) {
        timer.invalidate()
        seconds = 60    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
        timerLabel.text = String(seconds)

    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ExerciseViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        timerLabel.text = String(seconds) //This will update the label.
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
