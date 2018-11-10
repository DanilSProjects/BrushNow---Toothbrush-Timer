//
//  TrackTableViewController.swift
//  BrushNow - Toothbrush Timer
//
//  Created by Daniel on 20/10/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

var selectedTrack = "Track 1"

var mediaPicker = MPMusicPlayerController.systemMusicPlayer
var mediaPlayer = MPMusicPlayerController.applicationMusicPlayer
class TrackTableViewController: UITableViewController, MPMediaPickerControllerDelegate {
    
    var trackArray = ["Track 1", "Track 2", "Track 3", "Track 4", "Track 5", "Track 6", "Track 7", "Pick Own"]
    
    var audioPlayer: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        mediaPlayer.stop()
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        mediaPlayer.setQueue(with: mediaItemCollection)
        if trackArray[7] != "User's Track" {
        mediaPicker.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
        trackArray.insert("User's Track", at: 7)
        selectedTrack = trackArray[7]
        UserDefaults.standard.set(selectedTrack, forKey: "selectedTrack")
        } else {
            print ("Track already there")
            selectedTrack = trackArray[7]
            UserDefaults.standard.set(selectedTrack, forKey: "selectedTrack")
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trackArray.count
    }
    
    // Set up cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as! TrackTableViewCell
        
        if trackArray[indexPath.row] != "Pick Own" {
            if trackArray[indexPath.row] != "User's Track" {
        cell.trackNameLabel.text = trackArray[indexPath.row]
        cell.playButton.tag = indexPath.row
        if cell.trackNameLabel.text == selectedTrack {
            cell.trackNameLabel.textColor = .red
        } else {
            cell.trackNameLabel.textColor = .black
        }
            } else {
                cell.trackNameLabel.text = "User's Track"
                cell.playButton.tag = 10
                if cell.trackNameLabel.text == selectedTrack {
                    cell.trackNameLabel.textColor = .red
                } else {
                    cell.trackNameLabel.textColor = .black
            }
            }
        } else {
            cell.playButton.isHidden = true
            cell.trackNameLabel.text = "Pick Your Own Track"
        }
        return cell
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        if sender.tag < 10 {
        if audioPlayer?.isPlaying == true {
            audioPlayer?.stop()
            let path = Bundle.main.path(forResource: "\(trackArray[sender.tag]).mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                // couldn't load file :(
            }
        } else {
            let path = Bundle.main.path(forResource: "\(trackArray[sender.tag]).mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                // couldn't load file :(
            }
        }
        } else {
            mediaPlayer.play()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if trackArray[indexPath.row] != "Pick Own" {
        selectedTrack = trackArray[indexPath.row]
        dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(selectedTrack, forKey: "selectedTrack")
        } else {
            let myMediaPickerVC = MPMediaPickerController(mediaTypes: MPMediaType.music)
            myMediaPickerVC.allowsPickingMultipleItems = false
            myMediaPickerVC.popoverPresentationController?.sourceView = tableView
            myMediaPickerVC.delegate = self
            self.present(myMediaPickerVC, animated: true, completion: nil)
        }
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
