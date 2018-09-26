//
//  AboutViewController.swift
//  BrushNow - Toothbrush Timer
//
//  Created by Daniel on 26/9/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit

class AboutViewController: ViewController {

    @IBOutlet weak var aboutLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutLabel.sizeToFit()
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
