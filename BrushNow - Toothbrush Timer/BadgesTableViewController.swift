//
//  BadgesTableViewController.swift
//  BrushNow - Toothbrush Timer
//
//  Created by Daniel on 10/9/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit

// Global variable list of achievements
var badges = [
    Badge(name: "First Brush", desc: "Complete first timed brush.", isCompleted: false, reward: "Theme: Ocean", brushesNeeded: 1, icon: "firstbrush"),
    Badge(name: "Rookie Brusher", desc: "Complete 10 timed brushes.", isCompleted: false, reward: "Theme: Grass", brushesNeeded: 10, icon: "rookiebrusher"),
    Badge(name: "Dentist's BFF", desc: "Complete 25 timed brushes.", isCompleted: false, reward: "Theme: Tropical", brushesNeeded: 25, icon: "dentistsbff"),
    Badge(name: "Maniac", desc: "Complete 50 timed brushes.", isCompleted: false, reward: "Theme: Winter", brushesNeeded: 50, icon: "maniac"),
    Badge(name: "Forgetful", desc: "Set a reminder 20 times.", isCompleted: false, reward: "Theme: Night", brushesNeeded: 20 /* Reminders instead of brushes */, icon: "forgetful"),
    Badge(name: "Amnesiac", desc: "Set a reminder 50 times.", isCompleted: false, reward: "Theme: Chocolate", brushesNeeded: 50 /* Reminders instead of brushes */, icon: "amnesiac"),
    Badge(name: "Early Bird", desc: "Complete a brush before 6am.", isCompleted: false, reward: "Theme: Morning", brushesNeeded: 1,icon: "earlybird")
]

class BadgesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return badges.count
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "badgeCell", for: indexPath) as! BadgeTableViewCell

        // Name and desc set up
        cell.nameLabel.text = badges[indexPath.row].name
        cell.descLabel.text = badges[indexPath.row].desc
        cell.rewardLabel.text = "Reward: \(badges[indexPath.row].reward)"
        
        // Progress view setup
        if badges[indexPath.row].name == "Early Bird" {
            if badges[indexPath.row].isCompleted == true {
                cell.progressView.progress = 1
            } else {
                cell.progressView.progress = 0
            }
        } else if badges[indexPath.row].name == "Forgetful" || badges[indexPath.row].name == "Amnesiac" {
            let notifVal: Float = Float(notificationNo) / Float(badges[indexPath.row].brushesNeeded)
            cell.progressView.progress = notifVal
        } else {
        let val: Float = Float(numberOfBrushes) / Float(badges[indexPath.row].brushesNeeded)
        cell.progressView.progress = val
        }
        
        // If completed, show tick, if not, show cross
        if badges[indexPath.row].isCompleted == false {
        cell.completeView.image = UIImage(named: "\(badges[indexPath.row].icon)lock")
        cell.rewardLabel.textColor = .red
            
            if badges[indexPath.row].name == "Forgetful" {
                if badges[indexPath.row].brushesNeeded == 1 {
                    cell.tipLabel.text = "You need to set \(badges[indexPath.row].brushesNeeded - notificationNo) more reminder!"
                } else if badges[indexPath.row].brushesNeeded > 1 {
                    cell.tipLabel.text = "You need to set \(badges[indexPath.row].brushesNeeded - notificationNo) more reminders!"
                }
            } else if badges[indexPath.row].name == "Amnesiac" {
                    if badges[indexPath.row].brushesNeeded - notificationNo == 1 {
                        cell.tipLabel.text = "You need to set \(badges[indexPath.row].brushesNeeded - notificationNo) more reminder!"
                    } else if badges[indexPath.row].brushesNeeded - notificationNo > 1 {
                        cell.tipLabel.text = "You need to set \(badges[indexPath.row].brushesNeeded - notificationNo) more reminders!"
                } } else if badges[indexPath.row].name == "Early Bird" {
                cell.tipLabel.text = "You still need to complete the brush!"
            } else {
            if badges[indexPath.row].brushesNeeded - numberOfBrushes == 1 {
        cell.tipLabel.text = "You need \(badges[indexPath.row].brushesNeeded - numberOfBrushes) more brush!"
            } else if badges[indexPath.row].brushesNeeded - numberOfBrushes > 1 {
        cell.tipLabel.text = "You need \(badges[indexPath.row].brushesNeeded - numberOfBrushes) more brushes!"
        }
            }
            
        } else {
            cell.completeView.image = UIImage(named: badges[indexPath.row].icon)
            let completeTColour = UIColor(red:0.12, green:0.74, blue:0.13, alpha:1.0)
            cell.rewardLabel.textColor = completeTColour
            cell.tipLabel.text = "Well done! You achieved it!"
        }

        return cell
    }

    
    // Set up cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 179.0
    }

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

}
