//
//  Theme.swift
//  BrushNow - Toothbrush Timer
//
//  Created by Daniel on 3/10/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import Foundation
import UIKit


class Theme: NSObject, NSCoding {
    var name: String
    var textColour: UIColor
    var backgroundColour: UIColor
    var buttonColour: UIColor
    var previewImage: String
    
    init (name: String, textColour: UIColor, backgroundColour: UIColor, buttonColour: UIColor, previewImage: String) {
        self.name = name
        self.textColour = textColour
        self.backgroundColour = backgroundColour
        self.buttonColour = buttonColour
        self.previewImage = previewImage
    }
    
    // NSCODING
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.textColour, forKey: "textColour")
        aCoder.encode(self.backgroundColour, forKey: "backgroundColour")
        aCoder.encode(self.buttonColour, forKey: "buttonColour")
        aCoder.encode(self.previewImage, forKey: "previewImage")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard
            let name = aDecoder.decodeObject(forKey: "name") as? String,
            let textColour = aDecoder.decodeObject(forKey: "textColour") as? UIColor,
            let backgroundColour = aDecoder.decodeObject(forKey: "backgroundColour") as? UIColor,
            let buttonColour = aDecoder.decodeObject(forKey: "buttonColour") as? UIColor,
            let previewImage = aDecoder.decodeObject(forKey: "previewImage") as? String
            else { return nil }
        
        self.init(
            name: name,
            textColour: textColour,
            backgroundColour: backgroundColour,
            buttonColour: buttonColour,
            previewImage: previewImage
        )
    }
    
}
