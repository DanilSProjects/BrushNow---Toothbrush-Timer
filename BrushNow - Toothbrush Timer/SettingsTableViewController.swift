//
//  SettingsTableViewController.swift
//  BrushNow - Toothbrush Timer
//
//  Created by Daniel on 10/9/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit
import UserNotifications

// Theme Setup
var origBackgroundCol = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
let origButtonCol = UIColor(red:1.00, green:0.36, blue:0.40, alpha:1.0)
var themes = [Theme(name: "ORIGINAL", textColour: .black, backgroundColour: origBackgroundCol, buttonColour: origButtonCol, previewImage: "origpreview")
]
var selectedTheme = themes[0]

// TimeSet Setup
var timeSet = 120

// Notif
var notificationNo = 0

class SettingsTableViewController: UITableViewController {
    // Timer Set For:
    @IBOutlet weak var timerSetForLabel: UILabel!
    @IBOutlet weak var timerStepper: UIStepper!
    
    // Theme
    @IBOutlet weak var themeButton: UIButton!
    
    // Notifications
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var amLabel: UILabel!
    @IBOutlet weak var amStepper: UIStepper!
    @IBOutlet weak var pmLabel: UILabel!
    @IBOutlet weak var pmStepper: UIStepper!
    @IBOutlet weak var cancelButton: UIButton!
    
    // Music
    @IBOutlet weak var trackButton: UIButton!
    
    var notifAM = 10
    var notifPM = 10
    
    var notifAM12 = 0
    var notifPM12 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loadedStepper = UserDefaults.standard.double(forKey: "timerStepper")
        timerStepper.value = loadedStepper
        
        let loadedNotifStepper = UserDefaults.standard.double(forKey: "notifStepper")
        let loadedPMStepper = UserDefaults.standard.double(forKey: "pmStepper")
        amStepper.value = loadedNotifStepper
        pmStepper.value = loadedPMStepper
        
        timerSetForLabel.text = "\(Int(timerStepper.value).description) minutes"
        UserDefaults.standard.register(defaults: ["timeSet": 120])
        let loadedTimeSet = UserDefaults.standard.integer(forKey: "timeSet")
        timeSet = loadedTimeSet
        setButton.layer.cornerRadius = 10
        setButton.clipsToBounds = true
        cancelButton.layer.cornerRadius = 10
        cancelButton.clipsToBounds = true
        
        UserDefaults.standard.register(defaults: ["notifAM": 10])
        UserDefaults.standard.register(defaults: ["notifPM": 10])
        let loadedAM = UserDefaults.standard.integer(forKey: "notifAM")
        let loadedPM = UserDefaults.standard.integer(forKey: "notifPM")
        let loadedAM12 = UserDefaults.standard.integer(forKey: "notifAM12")
        let loadedPM12 = UserDefaults.standard.integer(forKey: "notifPM12")
        notifAM12 = loadedAM12
        notifPM12 = loadedPM12
        notifAM = loadedAM
        notifPM = loadedPM
        
        if notifPM12 == 0 {
        amLabel.text = "\(notifAM)AM"
        } else {
            amLabel.text = "\(notifPM12)PM"
        }
        if notifAM12 == 0 {
        pmLabel.text = "\(notifPM)PM"
        } else {
            pmLabel.text = "\(notifAM12)AM"
        }
        
        if let data = UserDefaults.standard.data(forKey: "labelColour"),
            let myColour = NSKeyedUnarchiver.unarchiveObject(with: data) as? UIColor {
            amLabel.textColor = myColour
            pmLabel.textColor = myColour
        } else {
            amLabel.textColor = .red
            pmLabel.textColor = .red
            print("There is an issue with the label colour") // NOTE FOR VIEWER: THIS WILL DEFINITELY PRINT ON FIRST LAUNCH DUE TO NOT HAVING THEMES STORED IN IT YET, BUT DON'T WORRY - IT DOESN'T DO ANYTHING
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        themeButton.setTitle(selectedTheme.name, for: .normal)
        trackButton.setTitle(selectedTrack, for: .normal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }


    @IBAction func timerStepper(_ sender: UIStepper) {
        timerSetForLabel.text = "\(Int(sender.value).description) minutes"
        UserDefaults.standard.set(sender.value, forKey: "timerStepper")
        timeSet = Int(sender.value)*60
        UserDefaults.standard.set(timeSet, forKey: "timeSet")
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    /*
     // MARK: - Notifications
 */
    func save() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: amLabel.textColor)
        UserDefaults.standard.set(encodedData, forKey: "labelColour")
    }
    
    func saveTheme() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: themes)
        UserDefaults.standard.set(encodedData, forKey: "themes")
    }
    
    func goToBadges (alert: UIAlertAction) {
        tabBarController?.selectedIndex = 1
    }
    
    
    @IBAction func setButtonPressed(_ sender: Any) {
        if amLabel.textColor == .red {
            let setNotificationTextCol = UIColor(red:0.12, green:0.74, blue:0.13, alpha:1.0)
            amLabel.textColor = setNotificationTextCol
            pmLabel.textColor = setNotificationTextCol
            save()
            
            let date = Date(timeIntervalSinceNow: 0)
            let currentDateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            
            var triggerDateHour = 0
            var pmTriggerHour = 0
            var newNotifAM = notifAM
            
            if notifPM12 == 12 {
                newNotifAM = 12
            }
            
            
            if currentDateComp.hour! < newNotifAM {
                triggerDateHour = newNotifAM - currentDateComp.hour!
            } else if currentDateComp.hour! > newNotifAM {
                triggerDateHour = 24 - (currentDateComp.hour! - newNotifAM)
            } else if currentDateComp.hour! == newNotifAM {
                triggerDateHour = currentDateComp.hour!
            }
            
            var usedNotifPM = notifPM + 12
            
            if notifAM12 == 12 {
                usedNotifPM = 0
            }

            if currentDateComp.hour! < usedNotifPM {
                pmTriggerHour = usedNotifPM - currentDateComp.hour!
            } else if currentDateComp.hour! > usedNotifPM {
                pmTriggerHour = 24 - (currentDateComp.hour! - usedNotifPM)
            } else if currentDateComp.hour! == usedNotifPM {
                pmTriggerHour = currentDateComp.hour!
            }
            
            let triggerDateTimeInterval: TimeInterval = TimeInterval((triggerDateHour * 3600) - (currentDateComp.minute! * 60) - (currentDateComp.second!))
            let triggerDate = Date(timeIntervalSinceNow: triggerDateTimeInterval)
            let triggerDateComp = Calendar.current.dateComponents([.hour, .minute], from: triggerDate)
            
            print (triggerDateComp)
            
            let pmDateTimeInterval: TimeInterval = TimeInterval((pmTriggerHour * 3600) - (currentDateComp.minute! * 60))
            let pmDate = Date(timeIntervalSinceNow: pmDateTimeInterval)
            let pmDateComp = Calendar.current.dateComponents([.hour, .minute], from: pmDate)
            
            print (pmDateComp)
            
            let content = UNMutableNotificationContent()
            content.title = "BrushNow Reminder"
            content.subtitle = "Have you brushed your teeth yet?"
            content.body = " If not, consider paying a visit to the bathroom."
            content.badge = 1
            content.sound = UNNotificationSound.default
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComp, repeats: true)
            let pmTrigger = UNCalendarNotificationTrigger(dateMatching: pmDateComp, repeats: true)
            
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            let pmRequest = UNNotificationRequest(identifier: "PMTimerDone", content: content, trigger: pmTrigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            UNUserNotificationCenter.current().add(pmRequest, withCompletionHandler: nil)
            
            notificationNo += 1
            
            switch notificationNo {
            case 20:
                badges[4].isCompleted = true
                UserDefaults.standard.set(badges[4].isCompleted, forKey: "forgetful")
                let nightCol = UIColor(red:0.91, green:0.89, blue:0.28, alpha:1.0)
                let nightBack = UIColor(red:0.76, green:0.36, blue:0.57, alpha:1.0)
                themes.append(Theme(name: "NIGHT", textColour: .black, backgroundColour: nightBack, buttonColour: nightCol, previewImage: "nightpreview"))
                UserDefaults.standard.set(notificationNo, forKey: "notifNo")
                self.saveTheme()
                
                let alert = UIAlertController(title: "Badge Unlocked", message: "You have unlocked 'Forgetful'! View your reward at the badges page.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Badges Page", comment: "Goes to badges tab"), style: .default, handler: self.goToBadges))
                alert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Default action"), style: .default, handler: { _ in
                    print ("Alert has been dimissed.")
                }))
                self.present(alert, animated: true, completion: nil)
                
            case 50:
                badges[5].isCompleted = true
                UserDefaults.standard.set(badges[5].isCompleted, forKey: "amnesiac")
                
                let chocColour = UIColor(red:0.86, green:0.71, blue:0.55, alpha:1.0)
                themes.append(Theme(name: "CHOCOLATE", textColour: .black, backgroundColour: .brown, buttonColour: chocColour, previewImage: "chocolatepreview"))
                UserDefaults.standard.set(notificationNo, forKey: "notifNo")
                self.saveTheme()
                
                let alert = UIAlertController(title: "Badge Unlocked", message: "You have unlocked 'Amnesiac'! View your reward at the badges page.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Badges Page", comment: "Goes to badges tab"), style: .default, handler: self.goToBadges))
                alert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Default action"), style: .default, handler: { _ in
                    print ("Alert has been dimissed.")
                }))
                self.present(alert, animated: true, completion: nil)
                
            default:
            print (notificationNo)
            UserDefaults.standard.set(notificationNo, forKey: "notifNo")
            }
            
        } else {
            print ("Reminder already set.")
        }
        
        
    }
    
    @IBAction func notifStepper(_ sender: UIStepper) {
        if amLabel.textColor == .red {
            if Int(sender.value) < 12 {
        notifPM12 = 0
        UserDefaults.standard.set(notifPM12, forKey: "notifPM12")
        notifAM = Int(sender.value)
        amLabel.text = "\(notifAM)AM"
        UserDefaults.standard.set(sender.value, forKey: "notifStepper")
        UserDefaults.standard.set(notifAM, forKey: "notifAM")
            } else {
                notifPM12 = Int(sender.value)
                amLabel.text = "\(notifPM12)PM"
                UserDefaults.standard.set(sender.value, forKey: "notifStepper")
                UserDefaults.standard.set(notifPM12, forKey: "notifPM12")
            }
        } else {
            amStepper.value = Double(notifAM)
            let alert = UIAlertController(title: "Reminder is Already Set", message: "Your reminder timing cannot be changed while it is already set. Please cancel your current timing first before changing it.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func pmStepper(_ sender: UIStepper) {
        if pmLabel.textColor == .red {
            if Int(sender.value) < 12 {
            notifAM12 = 0
            UserDefaults.standard.set(notifAM12, forKey: "notifAM12")
            notifPM = Int(sender.value)
            pmLabel.text = "\(notifPM)PM"
            UserDefaults.standard.set(sender.value, forKey: "pmStepper")
            UserDefaults.standard.set(notifPM, forKey: "notifPM")
            } else {
                notifAM12 = Int(sender.value)
                pmLabel.text = "\(notifAM12)AM"
                UserDefaults.standard.set(sender.value, forKey: "pmStepper")
                UserDefaults.standard.set(notifAM12, forKey: "notifAM12")
            }
        } else {
            pmStepper.value = Double(notifPM)
            let alert = UIAlertController(title: "Reminder is Already Set", message: "Your reminder timing cannot be changed while it is already set. Please cancel your current timing first before changing it.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        amLabel.textColor = .red
        pmLabel.textColor = .red
        save()
    }
    
    
}
