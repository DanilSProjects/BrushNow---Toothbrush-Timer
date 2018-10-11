//
//  SettingsTableViewController.swift
//  BrushNow - Toothbrush Timer
//
//  Created by Daniel on 10/9/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit
import UserNotifications

// Theme Setu[
var origBackgroundCol = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.0)
var themes = [Theme(name: "ORIGINAL", textColour: .black, backgroundColour: origBackgroundCol, buttonColour: .orange, previewImage: "origpreview")
]
var selectedTheme = themes[0]

// TimeSet Setup
var timeSet = 120

class SettingsTableViewController: UITableViewController {
    // Timer Set For:
    @IBOutlet weak var timerSetForLabel: UILabel!
    @IBOutlet weak var timerStepper: UIStepper!
    
    // Theme
    @IBOutlet weak var themeButton: UIButton!
    
    // Notifications
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var notifTimeLabel: UILabel!
    @IBOutlet weak var notifStepper: UIStepper!
    
    var notifAM = 10
    var notifPM = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loadedStepper = UserDefaults.standard.double(forKey: "timerStepper")
        timerStepper.value = loadedStepper
        
        let loadedNotifStepper = UserDefaults.standard.double(forKey: "notifStepper")
        notifStepper.value = loadedNotifStepper
        
        timerSetForLabel.text = "\(Int(timerStepper.value).description) minutes"
        UserDefaults.standard.register(defaults: ["timeSet": 120])
        let loadedTimeSet = UserDefaults.standard.integer(forKey: "timeSet")
        timeSet = loadedTimeSet
        setButton.layer.cornerRadius = 10
        setButton.clipsToBounds = true
        
        UserDefaults.standard.register(defaults: ["notifAM": 10])
        UserDefaults.standard.register(defaults: ["notifPM": 10])
        let loadedAM = UserDefaults.standard.integer(forKey: "notifAM")
        let loadedPM = UserDefaults.standard.integer(forKey: "notifPM")
        notifAM = loadedAM
        notifPM = loadedPM
        
        notifTimeLabel.text = "\(notifAM)AM/\(notifPM)PM"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        themeButton.setTitle(selectedTheme.name, for: .normal)
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
        return 7
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
    @IBAction func setButtonPressed(_ sender: Any) {
        
        let date = Date(timeIntervalSinceNow: 0)
        let currentDateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let newNotifAM = notifAM
        let newNotifPM = notifAM + 12
        
        
        var triggerDateHour = 0
        
        if currentDateComp.hour! <= newNotifPM && currentDateComp.hour! > 12 {
            triggerDateHour = newNotifAM - (currentDateComp.hour! - 12)
        } else if currentDateComp.hour! <= newNotifAM {
            triggerDateHour = newNotifAM - currentDateComp.hour!
        } else if currentDateComp.hour! == 0 {
            triggerDateHour = newNotifAM
        } else if currentDateComp.hour! > newNotifAM && currentDateComp.hour! < 13 {
            triggerDateHour = newNotifPM - currentDateComp.hour!
        }
        
        let triggerDateTimeInterval: TimeInterval = TimeInterval((triggerDateHour * 3600) - (currentDateComp.minute! * 60) - (currentDateComp.second!))
        let triggerDate = Date(timeIntervalSinceNow: triggerDateTimeInterval)
        let triggerDateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: triggerDate)
        
        print (triggerDateComp)
        
        let content = UNMutableNotificationContent()
        content.title = "BrushNow Reminder"
        content.subtitle = "Have you brushed your teeth yet?"
        content.body = " If not, consider paying a visit to the bathroom."
        content.badge = 1
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComp, repeats: true)
        
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
    }
    
    @IBAction func notifStepper(_ sender: UIStepper) {
        notifAM = Int(sender.value)
        notifPM = notifAM
        notifTimeLabel.text = "\(notifAM)AM/\(notifPM)PM"
        UserDefaults.standard.set(sender.value, forKey: "notifStepper")
        UserDefaults.standard.set(notifAM, forKey: "notifAM")
        UserDefaults.standard.set(notifPM, forKey: "notifPM")
    }
    
}
