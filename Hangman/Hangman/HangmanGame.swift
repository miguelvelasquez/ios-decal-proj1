//
//  HangmanGame.swift
//  Hangman
//
//  Created by Miguel A Velasquez on 2/25/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import Foundation

class HangmanGame {
    var letterSelected = false
    let Phrases: HangmanPhrases?
    var numWrongs = 1
    var guess = ""
    var currentPhrase = ""
    var displayPhrase = ""
    var wrongDisplay = "Wrong Guesses:"
    var gameOver = false
    var won = false
    
    init (){
        letterSelected = false
        Phrases = HangmanPhrases.init()
    }
    
    func resetGame() {
        numWrongs = 1
        guess = ""
        wrongDisplay = "Wrong Guesses:"
        gameOver = false
        won = false        
    }
    
    func checkGuess() -> Bool {
        letterSelected = false
        var i = 0
        while (i < (currentPhrase.characters.count)) {
            let index = currentPhrase.index(currentPhrase.startIndex, offsetBy: i)
            if (String(currentPhrase[index]) == guess) {
                correct()
                return true
            }
            i += 1
        }
        incorrect()
        return false
    }
    
    func correct() {
        var i = 0
        var disp = Array(displayPhrase.characters)
        while (i < (currentPhrase.characters.count)) {
            let index = currentPhrase.index(currentPhrase.startIndex, offsetBy: i)
            if (String(currentPhrase[index]) == guess) {
                disp[i] = Character(guess)
            }
            i += 1
        }
        displayPhrase = String(disp)
        guess = ""
        didWin()
    }
    
    func incorrect() {
        numWrongs += 1
        if (numWrongs == 7) {
            gameOver = true
        }
        wrongDisplay = wrongDisplay + " " + guess
        guess = ""
    }
    
    func generateBlanks() -> String {
        var i = 0
        var blanks = ""
        while (i < (currentPhrase.characters.count)) {
            let index = currentPhrase.index(currentPhrase.startIndex, offsetBy: i)
            if (String(currentPhrase[index]) != " ") {
                blanks = blanks + "-"
            } else {
                blanks = blanks + " "
            }
            i += 1
        }
        return blanks
    }
    
    func didWin() {
        var i = 0
        var noDashes = true
        while (i < (displayPhrase.characters.count)) {
            let index = displayPhrase.index(displayPhrase.startIndex, offsetBy: i)
            if (String(displayPhrase[index]) == "-") {
                noDashes = false
            }
            i += 1
        }
        if (noDashes == true) {
            gameOver = true
            won = true
        }
    }

    
}
