//
//  ViewController.swift
//  TicTacToeDemo
//
//  Created by Sushmitha on 22/12/18.
//  Copyright © 2018 Sushmitha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var gridView: UIView!
    @IBOutlet var gameStatus: UILabel!
    var currentPlayer = 0 //Player X -> 1, Player O -> 2
    var gridValuesArray: [Int] = []
    var isGameActive = false
    let winPossibilities = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],    //Horizontal
        [0, 3, 6], [1, 4, 7], [2, 5, 8],    //Vertical
        [0, 4, 8], [2, 4, 6]                //Diagonals
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setDefaultValues()
    }
    
    //MARK: Play board
    @IBAction func gridBtnTapped(_ sender: UIButton) {
        if (gridValuesArray[sender.tag-1] != 0) {
            //Board is not empty.
            return;
        }
        if (isGameActive) {
            gridValuesArray[sender.tag-1] = currentPlayer
            sender.setTitle((currentPlayer == 1) ? "X" : "O", for: .normal)
            currentPlayer = (currentPlayer == 1) ? 2 : 1
        }
        if (isGameOver()) {
            print("Game is over!")
        }
    }
    
    //MARK: Reset board
    @IBAction func resetTapped(_ sender: Any) {
        setDefaultValues()
    }
    
    func setDefaultValues() {
        gameStatus.text = ""
        currentPlayer = 1
        gridValuesArray = Array(repeating: 0, count: 9)
        isGameActive = true
        
        let subviewButtons = gridView.subviews.filter({$0.isKind(of: UIButton.self)})
        for case let button as UIButton in subviewButtons {
            button.setTitle("", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    //MARK: Game Over
    func isGameOver() -> Bool {
        for combination in winPossibilities {
            let row0 = gridValuesArray[combination[0]] //1 or 2
            if (row0 != 0) { //Check if grid is empty
                //Check all rows are having equal values
                let row1 = gridValuesArray[combination[1]]
                let row2 = gridValuesArray[combination[2]]
                if (row0 == row1 && row1 == row2) {
                    let status = (row0 == 1) ? "X" : "O"
                    gameStatus.text = status + " won the game!"
                    isGameActive = false
                    winnerGrid(array: combination)
                    return true
                }
            }
        }
        if (isGameDraw()){
            gameStatus.text = "Game is draw!"
            return true
        }
        return false
    }
    
    func winnerGrid(array: [Int]) {
        let subviewButtons = gridView.subviews.filter({$0.isKind(of: UIButton.self)})
        for case let button as UIButton in subviewButtons {
            let btnTag = button.tag-1
            if (btnTag == array[0] || btnTag == array[1] || btnTag == array[2]) {
                button.setTitleColor(UIColor.black, for: .normal)
            }
        }
    }
    
    //MARK: Game Tie
    func isGameDraw() -> Bool {
        return !gridValuesArray.contains(where: {$0 == 0})
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

