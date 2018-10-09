//
//  TimerViewController.swift
//  BrushNow - Toothbrush Timer
//
//  Created by Daniel on 10/9/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit
import UserNotifications

var numberOfBrushes = 0

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
        
        // Asking for permission for notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
        
        time = timeSet
        startButton.layer.cornerRadius = 10
        startButton.clipsToBounds = true
       // UserDefaults stuff
        let loadedBrushes = UserDefaults.standard.integer(forKey: "noOfBrush")
        let loadedFirst = UserDefaults.standard.bool(forKey: "firstBrush")
        let loadedRookie = UserDefaults.standard.bool(forKey: "rookieBrush")
        let loadedDentist = UserDefaults.standard.bool(forKey: "dentistsBFF")
        let loadedManiac = UserDefaults.standard.bool(forKey: "maniac")
        
        numberOfBrushes = loadedBrushes
        badges[0].isCompleted = loadedFirst
        badges[1].isCompleted = loadedRookie
        badges[2].isCompleted = loadedDentist
        badges[3].isCompleted = loadedManiac
        
        if let data = UserDefaults.standard.data(forKey: "selectedTheme"),
            let myTheme = NSKeyedUnarchiver.unarchiveObject(with: data) as? Theme {
            selectedTheme = myTheme
        } else {
            print("There is an issue with the selected theme") // NOTE FOR VIEWER: THIS WILL DEFINITELY PRINT ON FIRST LAUNCH DUE TO NOT HAVING THEMES STORED IN IT YET, BUT DON'T WORRY - IT DOESN'T DO ANYTHING
        }
        
        // Retrieving a value for a key
        if let data = UserDefaults.standard.data(forKey: "themes"),
            let myThemeList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Theme] {
            themes = myThemeList
        } else {
            print("There is an issue with the themes array") // NOTE FOR VIEWER: THIS WILL DEFINITELY PRINT ON FIRST LAUNCH DUE TO NOT HAVING THEMES STORED IN IT YET, BUT DON'T WORRY - IT DOESN'T DO ANYTHING
        }
    }
    
    // Start setup
    override func viewDidAppear(_ animated: Bool) {
        // Theme
        view.backgroundColor = selectedTheme.backgroundColour
        timerHeadingLabel.textColor = selectedTheme.textColour
        minutesLabel.textColor = selectedTheme.textColour
        themeHeadingLabel.textColor = selectedTheme.textColour
        themeNameLabel.textColor = selectedTheme.textColour
        themeNameLabel.text = selectedTheme.name
        startButton.backgroundColor = selectedTheme.buttonColour
        
        time = timeSet
        // Hiding and unhiding
        timerHeadingLabel.isHidden = false
        minutesLabel.isHidden = false
        themeHeadingLabel.isHidden = false
        themeNameLabel.isHidden = false
        startButton.isHidden = false
        readySetLabel.isHidden = true
    
        
        minutesLabel.text = "\(time / 60) MINUTES"
        time = timeSet
  
        timer?.invalidate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
        time = timeSet
        minutesLabel.text = "\(time / 60) MINUTES"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: themes)
        UserDefaults.standard.set(encodedData, forKey: "themes")
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
                            
                            numberOfBrushes += 1
                            UserDefaults.standard.set(numberOfBrushes, forKey: "noOfBrush")
                            
                            // Switch statement for unlocking achievements
                            switch numberOfBrushes {
                                
                                //First Brush
                            case 1:
                                badges[0].isCompleted = true
                                UserDefaults.standard.set(badges[0].isCompleted, forKey: "firstBrush")
                                themes.append(Theme(name: "OCEAN", textColour: .white, backgroundColour: .blue, buttonColour: .yellow, previewImage: "oceanpreview"))
                                self.save()
                                
                                // Rookie Brusher
                            case 10:
                                badges[1].isCompleted = true
                                UserDefaults.standard.set(badges[1].isCompleted, forKey: "rookieBrush")
                                themes.append(Theme(name: "GRASS", textColour: .black, backgroundColour: .green, buttonColour: .brown, previewImage: "grasspreview"))
                                self.save()
                                
                                // Dentist's BFF
                            case 25:
                                badges[2].isCompleted = true
                                UserDefaults.standard.set(badges[2].isCompleted, forKey: "dentistsBFF")
                                self.save()
                                
                                // Maniac
                            case 50:
                                badges[3].isCompleted = true
                                UserDefaults.standard.set(badges[3].isCompleted, forKey: "maniac")
                                self.save()
                                
                            // If nothing was unlocked
                            default:
                                print ("No achievements have been unlocked from this brush.")
                            }
                            
                            
                            
                            self.timerHeadingLabel.isHidden = false
                            self.minutesLabel.isHidden = false
                            self.themeHeadingLabel.isHidden = false
                            self.themeNameLabel.isHidden = false
                            self.startButton.isHidden = false
                            self.readySetLabel.isHidden = true
                            
                            self.time = timeSet
                            UserDefaults.standard.set(self.time, forKey: "time")
                            self.minutesLabel.text = "\(self.time / 60) MINUTES"
                            
                            
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
