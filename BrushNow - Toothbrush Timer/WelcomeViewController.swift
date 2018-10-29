//
//  TutorialViewController.swift
//  BrushNow - Toothbrush Timer
//
//  Created by Daniel on 29/10/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloLabel.alpha = 0
        iconView.alpha = 0
        tutorialLabel.alpha = 0
        continueButton.alpha = 0
        
    let animator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
        self.helloLabel.alpha = 1
        })
        animator.addCompletion{(_) in
            let secAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
                self.iconView.alpha = 1
            })
            secAnimator.addCompletion{ (_) in
                let thirAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
                    self.tutorialLabel.alpha = 1
            })
                thirAnimator.addCompletion { (_) in
                    let fourAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
                        self.continueButton.alpha = 1
                    })
                    
                    fourAnimator.startAnimation()
                }

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
