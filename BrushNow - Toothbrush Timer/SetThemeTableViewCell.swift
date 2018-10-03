//
//  SetThemeTableViewCell.swift
//  BrushNow - Toothbrush Timer
//
//  Created by Daniel on 3/10/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit

class SetThemeTableViewCell: UITableViewCell {
    @IBOutlet weak var themePreviewView: UIImageView!
    @IBOutlet weak var themeTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
