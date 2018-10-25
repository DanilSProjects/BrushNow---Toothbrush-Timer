//
//  CreditsViewController.swift
//  BrushNow - Toothbrush Timer
//
//  Created by Daniel on 20/10/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit
import SafariServices

class CreditsViewController: UIViewController {


    @IBAction func linkButton(_ sender: Any) {
        if let url = URL(string: "https://ozzed.net") {
            let safVC = SFSafariViewController(url: url)
            present(safVC, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
