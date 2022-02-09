//
//  ViewController.swift
//  Concentration
///Users/orendinur/Developer/Assignments/Exercise1/Concentration/Concentration/ViewController.swift
//  Created by Oren Dinur on 07/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    override func viewDidLoad() {
        emojiChoices = pickTheme()
        updateViewFromModel()
    }

    lazy var themeSet = Int(arc4random_uniform(UInt32(5)))
    
    @IBOutlet weak var scoreCountLabel: UILabel!
        
    //Same as Array<UIButtons>!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
        
    @IBAction func touchCard(_ sender: UIButton) {
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
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                if !card.isMatched {
                    //Change the background color and cards color according to the chosen theme

                    switch(themeSet){
                    case 0:
                        button.backgroundColor = UIColor.orange
                        self.view.backgroundColor = UIColor.white

                    case 1:
                        button.backgroundColor = UIColor.black
                        self.view.backgroundColor = UIColor.orange

                    case 2:
                        button.backgroundColor = UIColor.purple
                        self.view.backgroundColor = UIColor.white

                    case 3:
                        button.backgroundColor = UIColor.lightGray
                        self.view.backgroundColor = UIColor.darkGray

                    case 4:
                        button.backgroundColor = UIColor.darkGray
                        self.view.backgroundColor = UIColor.lightGray

                    case 5:
                        button.backgroundColor = UIColor.yellow
                        self.view.backgroundColor = UIColor.magenta

                    case 6:
                        button.backgroundColor = UIColor.magenta
                        self.view.backgroundColor = UIColor.yellow

                    case 7:
                        button.backgroundColor = UIColor.purple
                        self.view.backgroundColor = UIColor.cyan

                    default:
                        button.backgroundColor = UIColor.cyan
                    
                }
                } else{
                    button.backgroundColor = UIColor.clear
                }
            }
        }
        scoreCountLabel.text = "Score \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = pickTheme()
        updateViewFromModel()
    }
    
    
     func pickTheme() -> [String] {
        let emojiList = ["😀","👻","🎃","👸🏽","🥸","🥴","🤟🏽","🤜🏼",//Original
                         "🙈","🦃","🐶","🐭","🐹","🦊","🐻","🐰",//Animals
                         "🍋","🍇","🍏","🍉","🍌","🍊","🍐","🍎",//Fruits
                         "⚽️","🏀","🏈","⚾️","🥎","🏐","🥏","🪀",//Sports
                         "🚗","🚕","🚙","🚌","🏎","🚓","🚐","🛴",//Vehicles
                         "⌚️","📱","⌨️","🖥","💽","🖨","💡","🧭"]//Electricity
        var emojiChoices = [String]()
        let randomIndex = Int(arc4random_uniform(UInt32(5)))
        for index in 0...7{
            let tempEmoji = emojiList[8*randomIndex + index]
            emojiChoices += [tempEmoji]
        }
         themeSet = randomIndex
        return emojiChoices
    }
    
    lazy var emojiChoices = pickTheme()

    //Dictionary
    var emoji = [Int:String]()
    
    func emoji(for card : Card) -> String {
        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
    }
        return emoji[card.identifier] ?? "?"
    }
}


