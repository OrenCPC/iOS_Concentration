//
//  ViewController.swift
//  Concentration
///Users/orendinur/Developer/Assignments/Exercise1/Concentration/Concentration/ViewController.swift
//  Created by Oren Dinur on 07/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    lazy var themes: [Theme] = [
        Theme(emojiChoices: ["😀","👻","🎃","👸🏽","🥸","🥴","🤟🏽","🤜🏼"], buttonBackgroundColor: UIColor.orange, screenBackgroundColor: UIColor.white, themeName: "Original"),
        Theme(emojiChoices: ["🙈","🦃","🐶","🐭","🐹","🦊","🐻","🐰"],  buttonBackgroundColor: UIColor.black, screenBackgroundColor: UIColor.orange, themeName: "Animals"),
        Theme(emojiChoices: ["🍋","🍇","🍏","🍉","🍌","🍊","🍐","🍎"], buttonBackgroundColor: UIColor.purple, screenBackgroundColor: UIColor.white, themeName: "Fruits"),
        Theme(emojiChoices: ["⚽️","🏀","🏈","⚾️","🥎","🏐","🥏","🪀"], buttonBackgroundColor: UIColor.lightGray, screenBackgroundColor: UIColor.darkGray, themeName: "Sports"),
        Theme(emojiChoices: ["🚗","🚕","🚙","🚌","🏎","🚓","🚐","🛴"], buttonBackgroundColor: UIColor.darkGray, screenBackgroundColor: UIColor.lightGray, themeName: "Vehicles"),
        Theme(emojiChoices: ["⌚️","📱","⌨️","🖥","💽","🖨","💡","🧭"], buttonBackgroundColor: UIColor.cyan, screenBackgroundColor: UIColor.white, themeName: "Electricity")
    ]
    
    lazy var currentTheme: Theme = Theme(emojiChoices: ["😀","👻","🎃","👸🏽","🥸","🥴","🤟🏽","🤜🏼"], buttonBackgroundColor: UIColor.orange, screenBackgroundColor: UIColor.white, themeName: "Original")
    
    private lazy var emojiChoices = currentTheme.emojiChoices
        
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    func startGame(){
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        let randomTheme = Int(arc4random_uniform(UInt32(themes.count)))
        currentTheme = themes[randomTheme]
        emojiChoices = currentTheme.emojiChoices
        updateViewFromModel()
    }
    
    override func viewDidLoad() {
        startGame()
    }
    
    
    @IBOutlet private weak var scoreCountLabel: UILabel!
    
    //Same as Array<UIButtons>!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card wasn't in cardButtons")
        }
    }
    
   private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                if !card.isMatched {
                    button.backgroundColor = currentTheme.buttonBackgroundColor
                    self.view.backgroundColor = currentTheme.screenBackgroundColor
                    
                } else {
                    button.backgroundColor = UIColor.clear
                }
            }
        }
        scoreCountLabel.text = "Score \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        startGame()
    }
    
    
    //Dictionary
    private var emoji = [Int:String]()
    
   private func emoji(for card : Card) -> String {
        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0 {
                emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            }
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}


