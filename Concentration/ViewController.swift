//
//  ViewController.swift
//  Concentration
///Users/orendinur/Developer/Assignments/Exercise1/Concentration/Concentration/ViewController.swift
//  Created by Oren Dinur on 07/02/2022.
//

import UIKit

class ViewController: UIViewController {
 
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"

        }
    }
    
    //Same as Array<UIButtons>!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
    flipCount += 1
        
    }
    
   
    
    
    func flipCard(withEmoji emoji: String, on button: UIButton){
        print("Click")
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = UIColor.orange
        }else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = UIColor.white
        }
    }
    
}

