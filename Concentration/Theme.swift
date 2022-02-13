//
//  Theme.swift
//  Concentration
//
//  Created by Oren Dinur on 13/02/2022.
//

import Foundation
import UIKit

class Theme {
    
    var emojiChoices = [String]()
    var buttonBackgroundColor: UIColor
    var screenBackgroundColor: UIColor
    var themeName: String
    
    init(emojiChoices: [String], buttonBackgroundColor: UIColor, screenBackgroundColor: UIColor, themeName: String) {
        
        self.emojiChoices = emojiChoices
        self.buttonBackgroundColor = buttonBackgroundColor
        self.screenBackgroundColor = screenBackgroundColor
        self.themeName = themeName

    }
}
