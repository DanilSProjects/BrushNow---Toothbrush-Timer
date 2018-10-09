//
//  SettingsTableViewController.swift
//  BrushNow - Toothbrush Timer
//
//  Created by Daniel on 10/9/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loadedStepper = UserDefaults.standard.double(forKey: "timerStepper")
                timerStepper.value = loadedStepper
        timerSetForLabel.text = "\(Int(timerStepper.value).description) minutes"
        UserDefaults.standard.register(defaults: ["timeSet": 120])
        let loadedTimeSet = UserDefaults.standard.integer(forKey: "timeSet")
        timeSet = loadedTimeSet
        setButton.layer.cornerRadius = 10
        setButton.clipsToBounds = true
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

}
