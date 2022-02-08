//
//  ViewController.swift
//  Concentration
///Users/orendinur/Developer/Assignments/Exercise1/Concentration/Concentration/ViewController.swift
//  Created by Oren Dinur on 07/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
 
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
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else{
            print("Chosen card wasn't in cardButtons")
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
        }
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        flipCount = 0
        emojiChoices = ["😀","👻","🎃","👸🏽","🥸","🥴","🤟🏽","🤜🏼"]
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
    
    var emojiChoices = ["😀","👻","🎃","👸🏽","🥸","🥴","🤟🏽","🤜🏼"]
    
    //Dictionary
    var emoji = [Int:String]()
    
    func emoji(for card : Card) -> String {
        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
    }
        //2 Ways to handle the optional:
        
//        if emoji[card.identifier] != nil{
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    
}


