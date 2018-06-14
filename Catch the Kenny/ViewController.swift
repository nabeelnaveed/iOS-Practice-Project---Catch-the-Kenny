//
//  ViewController.swift
//  Catch the Kenny
//
//  Created by Nabeel Naveed on 6/10/18.
//  Copyright © 2018 NabeelNaveed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!

    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var heighScoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    var score = 0
    var counter = 0
    var timer = Timer()
    var hideTimer = Timer()
    var kennyArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        //check high score
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        
        if highScore == nil{
            
          heighScoreLabel.text = "0"
        }
        if let newScore = highScore as? Int  {
            
            heighScoreLabel.text = String(newScore)
            
        }
        
        scoreLabel.text = "Score: \(score)"
        
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let gesture5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let gesture6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let gesture7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let gesture8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let gesture9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        
        kenny1.addGestureRecognizer(gesture1)
        kenny2.addGestureRecognizer(gesture2)
        kenny3.addGestureRecognizer(gesture3)
        kenny4.addGestureRecognizer(gesture4)
        kenny5.addGestureRecognizer(gesture5)
        kenny6.addGestureRecognizer(gesture6)
        kenny7.addGestureRecognizer(gesture7)
        kenny8.addGestureRecognizer(gesture8)
        kenny9.addGestureRecognizer(gesture9)
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true

        // set timers
        counter = 30
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.hidekenny), userInfo: nil, repeats: true)

        //creating array
        kennyArray.append(kenny1)
        kennyArray.append(kenny2)
        kennyArray.append(kenny3)
        kennyArray.append(kenny4)
        kennyArray.append(kenny5)
        kennyArray.append(kenny6)
        kennyArray.append(kenny7)
        kennyArray.append(kenny8)
        kennyArray.append(kenny9)
        
        hidekenny()
    }

    @objc func increaseScore(){
        
        //this is what is happen when the gester is called
        score += 1
        scoreLabel.text =  "Score: \(score)"
    }
    @objc func countDown(){
        
        counter = counter - 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            
            timer.invalidate()
            hideTimer.invalidate()
            
            //score higher
            if self.score > Int(heighScoreLabel.text!)!
            {
                UserDefaults.standard.set(self.score, forKey: "highscore")
                heighScoreLabel.text = String(self.score)

            }
            
            
            //alert creation
            let alert = UIAlertController(title: "Time!", message: "Your Time is Yup!", preferredStyle: UIAlertControllerStyle.alert)
            
            let extbtn = UIAlertAction(title: "Exit", style: UIAlertActionStyle.destructive, handler:  {(UIAlertAction) in
                
                exit(0);
            })
            
            alert.addAction(extbtn)
            /*let resetApp = UIAlertAction(title: "Close Now", style: .destructive) {
                    (alert) -> Void in
                    // home button pressed programmatically - to thorw app to background
                    UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                    // terminaing app in background
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        exit(EXIT_SUCCESS)
                    })
                }
            alert.addAction(resetApp)*/

    
            let replay = UIAlertAction(title: "Replay!", style: UIAlertActionStyle.default, handler: {(UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:  #selector(ViewController.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:  #selector(ViewController.hidekenny), userInfo: nil, repeats: true)
                
            })
            alert.addAction(replay)
            self.present(alert, animated: true, completion: nil)

      }
        
        
 }
    
    @objc func hidekenny(){
    
    for kenny in kennyArray{
        
        kenny.isHidden = true
        
    }
    let randomNumbers = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
    kennyArray[randomNumbers].isHidden = false

}
}
