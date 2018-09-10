//
//  TimerViewController.swift
//  BrushNow - Toothbrush Timer
//
//  Created by Daniel on 10/9/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit

class TimerViewController: ViewController {
    // Messy part for outlets
    
    @IBOutlet weak var timerHeadingLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var themeHeadingLabel: UILabel!
    @IBOutlet weak var themeNameLabel: UILabel!
    @IBOutlet weak var readySetLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    var time = 120
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    // Start setup
    override func viewDidAppear(_ animated: Bool) {
        // Hiding and unhiding
        timerHeadingLabel.isHidden = false
        minutesLabel.isHidden = false
        themeHeadingLabel.isHidden = false
        themeNameLabel.isHidden = false
        startButton.isHidden = false
        readySetLabel.isHidden = true
        
        minutesLabel.text = "\(time / 60) MINUTES"
        time = 120
        timer?.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Button to start timer
    @IBAction func startButtonPressed(_ sender: Any) {
        timerHeadingLabel.isHidden = true
        minutesLabel.isHidden = true
        themeHeadingLabel.isHidden = true
        themeNameLabel.isHidden = true
        startButton.isHidden = true
        readySetLabel.isHidden = false
        
        func timeFormatted(_ totalSeconds: Int) -> String {
            let seconds: Int = totalSeconds % 60
            let minutes: Int = (totalSeconds / 60) % 60
            //     let hours: Int = totalSeconds / 3600
            return String(format: "%02d:%02d", minutes, seconds)
        }
        
        // Ready set go
        let animator = UIViewPropertyAnimator(duration: 1.5, curve: .linear, animations: {
            self.readySetLabel.text = "READY"
            self.readySetLabel.textColor = .red
            self.readySetLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self.readySetLabel.alpha = 0
        })
        animator.addCompletion{(_) in
            self.readySetLabel.transform = CGAffineTransform.identity
            self.readySetLabel.alpha = 1
            self.readySetLabel.text = "SET"
            self.readySetLabel.textColor = .yellow
            let secondAnimator = UIViewPropertyAnimator(duration: 1.5, curve: .linear, animations : {
                self.readySetLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                self.readySetLabel.alpha = 0
                
            })
            secondAnimator.addCompletion{(_) in
                self.readySetLabel.transform = CGAffineTransform.identity
                self.readySetLabel.alpha = 1
                self.readySetLabel.text = "GO!"
                self.readySetLabel.textColor = .green
                let thirdAnimator = UIViewPropertyAnimator(duration: 1.5, curve: .linear, animations : {
                    self.readySetLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
                    self.readySetLabel.alpha = 0
                    
                })
                thirdAnimator.addCompletion{(_) in
                    self.readySetLabel.alpha = 1
                    self.readySetLabel.transform = CGAffineTransform.identity
                    self.readySetLabel.isHidden = true
                    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                        self.minutesLabel.text = "\(timeFormatted(self.time))"
                        if self.time > 0 {
                        self.time -= 1
                        self.minutesLabel.isHidden = false
                        } else if self.time == 0 {
                            self.timer?.invalidate()
                            self.time = 120
                        }
                    }
                }
                thirdAnimator.startAnimation()
            }
            secondAnimator.startAnimation()
        }
        
        animator.startAnimation()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
