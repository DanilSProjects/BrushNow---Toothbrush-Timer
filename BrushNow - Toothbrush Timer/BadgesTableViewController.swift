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
    Badge(name: "First Brush", desc: "Complete your first timed brush.", isCompleted: false),
    Badge(name: "Rookie Brusher", desc: "Complete 10 timed brushes.", isCompleted: false),
    Badge(name: "Dentist's BFF", desc: "Complete 25 timed brushes.", isCompleted: false),
    Badge(name: "Maniac", desc: "Complete 50 timed brushes.", isCompleted: false)
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

        print (badges[0].isCompleted)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "badgeCell", for: indexPath) as! BadgeTableViewCell

        // Name and desc set up
        cell.nameLabel.text = badges[indexPath.row].name
        cell.descLabel.text = badges[indexPath.row].desc
        
        // If completed, show tick, if not, show cross
        if badges[indexPath.row].isCompleted == false {
        cell.completeView.image = UIImage(named: "cross")
        } else {
            cell.completeView.image = UIImage(named: "tick")
        }

        return cell
    }
    
    // Set up cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
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
