//
//  Theme.swift
//  Concentration
//
//  Created by Oren Dinur on 13/02/2022.
//

import Foundation
import UIKit

class Theme {
    
    let emojiList = ["😀","👻","🎃","👸🏽","🥸","🥴","🤟🏽","🤜🏼",//Original
                     "🙈","🦃","🐶","🐭","🐹","🦊","🐻","🐰",//Animals
                     "🍋","🍇","🍏","🍉","🍌","🍊","🍐","🍎",//Fruits
                     "⚽️","🏀","🏈","⚾️","🥎","🏐","🥏","🪀",//Sports
                     "🚗","🚕","🚙","🚌","🏎","🚓","🚐","🛴",//Vehicles
                     "⌚️","📱","⌨️","🖥","💽","🖨","💡","🧭"]//Electricity//
    var emojiChoices = [String]()
    var buttonBackgroundColor: UIColor
    var screenBackgroundColor: UIColor
    
    init(){
        let randomIndex = Int(arc4random_uniform(UInt32(emojiList.count / 8)))
        //Each theme has 8 Emojis in it, later on we will pick randomly 6 out of them
        for index in 0...7 {
            let tempEmoji = emojiList[8 * randomIndex + index]
            emojiChoices += [tempEmoji]
        }
        
        //Choose the background color and cards color according to the chosen theme
        switch(randomIndex) {
        case 0:
            buttonBackgroundColor = UIColor.orange
            screenBackgroundColor = UIColor.white
            
        case 1:
            buttonBackgroundColor = UIColor.black
            screenBackgroundColor = UIColor.orange
            
        case 2:
            buttonBackgroundColor = UIColor.purple
            screenBackgroundColor = UIColor.white
            
        case 3:
            buttonBackgroundColor = UIColor.lightGray
            screenBackgroundColor = UIColor.darkGray
            
        case 4:
            buttonBackgroundColor = UIColor.darkGray
            screenBackgroundColor = UIColor.lightGray
            
        default:
            buttonBackgroundColor = UIColor.cyan
            screenBackgroundColor = UIColor.white
        }
    }
}
