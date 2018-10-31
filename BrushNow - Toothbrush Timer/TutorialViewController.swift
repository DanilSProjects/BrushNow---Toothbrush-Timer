//
//  TutorialViewController.swift
//  BrushNow - Toothbrush Timer
//
//  Created by Daniel on 29/10/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var contButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelOne.alpha = 0
        labelTwo.alpha = 0
        contButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let animator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
            self.labelOne.alpha = 1
        })
        animator.addCompletion{(_) in
            let secAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
                self.labelTwo.alpha = 1
            })
            secAnimator.addCompletion{ (_) in
                let thirAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
                    self.contButton.alpha = 1
                })
                
                thirAnimator.startAnimation()
            }
            secAnimator.startAnimation()
        }
        animator.startAnimation()
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
