//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    var game = HangmanGame.init()

    @IBOutlet weak var gallows: UIImageView!
    @IBOutlet weak var phraseSpace: UILabel!
    @IBOutlet weak var wrongsSpace: UILabel!
    var lastButton: UIButton?
    let hangmanPhrases = HangmanPhrases()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        let phrase: String = hangmanPhrases.getRandomPhrase()
        print(phrase)
        initDisplay(word: phrase)
        
    }
    
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    func initDisplay(word: String) {
        game.resetGame()
        game.currentPhrase = word
        let beginningPhrase = game.generateBlanks()
        phraseSpace.text = beginningPhrase
        game.displayPhrase = beginningPhrase
        wrongsSpace.text = game.wrongDisplay
        gallows.image = #imageLiteral(resourceName: "hangman1")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func letterWasSelected(_ sender: UIButton) {
        if (game.gameOver == false) {
            game.letterSelected = true
            lastButton?.setTitleColor(UIColor.white, for: UIControlState.normal)
            let index = alphabet.index(alphabet.startIndex, offsetBy: sender.tag)
            game.guess = String(alphabet[index])
            sender.setTitleColor(UIColor.green, for: UIControlState.normal)
            lastButton = sender
        }
    }
    
    @IBAction func guessWasPressed(_ sender: UIButton) {
        if (game.letterSelected == true) {
            lastButton?.setTitleColor(UIColor.white, for: UIControlState.normal)
            if (game.checkGuess() == true) {
                phraseSpace.text = game.displayPhrase
            } else {
                displayHangman(val: game.numWrongs)
                wrongsSpace.text = game.wrongDisplay
            }
            if (game.gameOver == true) {
                endGame()
            }
        }
    }
    
    func displayHangman(val: Int) {
        switch val {
        case 2:
            gallows.image = #imageLiteral(resourceName: "hangman2")
        case 3:
            gallows.image = #imageLiteral(resourceName: "hangman3")
        case 4:
            gallows.image = #imageLiteral(resourceName: "hangman4")
        case 5:
            gallows.image = #imageLiteral(resourceName: "hangman5")
        case 6:
            gallows.image = #imageLiteral(resourceName: "hangman6")
        case 7:
            gallows.image = #imageLiteral(resourceName: "hangman7")
        default:
            gallows.image = #imageLiteral(resourceName: "hangman1")
        }
    }
    
    func endGame() {
        if (game.won == true) {
            let alert = UIAlertController(title: "You Won!", message: "Click the button below to restart the game", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "New Game", style: UIAlertActionStyle.default, handler: { action in
                    self.newGame()
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "You lost!", message: "Click the button below to restart the game", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "New Game", style: UIAlertActionStyle.default, handler: { action in
                    self.newGame()
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func newGame() {
        let phrase: String = hangmanPhrases.getRandomPhrase()
        initDisplay(word: phrase)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
