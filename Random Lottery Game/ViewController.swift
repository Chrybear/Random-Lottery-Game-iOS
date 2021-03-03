//
//  ViewController.swift
//  Random Lottery Game
//
//  Author: Charles Ryan Barrett
//  Date: 3/3/2021
//  Description: A simple iOS game of random chance made for assignment 5 in CSC 308 at EKU
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    
    var curCash = 0 //Current amount of money the user has made (not legally binding; this is fake money)
    
    var prizeLocation = [Int]() //This array holds which button has which prize Ex: index 0 represents button in top left corner and the value at that index holds its prize amount, top right button is index 1, etc.
    
    var turns = 0 //Number of turns player has done in the current round
    
    //Outlets
    
    //Outlet for the prize buttons
    @IBOutlet var prizeBtn: [UIButton]!
    
    //Outlet for current cash label
    @IBOutlet weak var cashLabel: UILabel!
    
    
    //Function for when help button is pressed
    @IBAction func giveHelp(_ sender: Any) {
        //Create message with instructions on how to play
        let alertCont = UIAlertController(title: "How To Play", message: "Press any two dollar signs to reveal your prize.", preferredStyle: UIAlertController.Style.alert)
        
        //Create OK button
        let defAct = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        
        //Add button
        alertCont.addAction(defAct)
        
        //Show the message
        present(alertCont, animated: true, completion: nil)
    }
    
    //Function for when a button is pressed
    @IBAction func buttonPressed(_ sender: UIButton) {
        //Incriment turns number
        turns += 1
        
        //get button index
        let btnInd = prizeBtn.firstIndex(of: sender)!
        
        //Find the value of that button
        let btnVal = prizeLocation[btnInd]
        
        //Set text of pressed button to value
        sender.setTitle(String(btnVal), for: UIControl.State.normal)
        
        //Remove image
        sender.setBackgroundImage(nil, for: UIControl.State.normal)
        
        //Disable the button
        sender.isEnabled = false
        
        //Add the money to the total won
        updateCash(addedCash: btnVal)
        
        //Is the game over?
        if turns >= 2 {
            endGame() //End the current game
        }
    }
    
    //Function to end the game
    func endGame(){
        //Create a message to ask user if they wish to play again
        let alertCont = UIAlertController(title: "Congratulations!", message: "You've won $\(curCash)!", preferredStyle: UIAlertController.Style.alert)
        
        //Create replay button
        let replay = UIAlertAction(title: "Play Again?", style: UIAlertAction.Style.default, handler: {_ in
            (self.newGame())
        })
        //Create quit button
        let quitGame = UIAlertAction(title: "Quit", style: UIAlertAction.Style.default, handler: {_ in
            (exit(0))
        })
        
        //Add replay button
        alertCont.addAction(replay)
        
        //Add exit button
        alertCont.addAction(quitGame)
        
        //Show the message
        present(alertCont, animated: true, completion: nil)
    }
    
    //Function to update current cash label
    func updateCash(addedCash: Int){
        let newTotal = curCash + addedCash
        //Update curCash
        curCash = newTotal
        cashLabel.text = "Current Total: $\(newTotal)"
    }
    
    
    //Function for randomly assigning each button its value
    func setVal(){
        var vals = [0, 100, 200, 300, 400, 500]
        prizeLocation = [Int]()//Reset the prize locations
        
        for _ in 0...5{
            let randNum = Int(arc4random()) % vals.count
            //Get and remove the randomly selected value
            let randVal = vals.remove(at: randNum)
            //Set it in the prizeLocation
            prizeLocation.append(randVal)
        }
        
    }
    
    //Function to set up a new game
    func newGame(){
        //Reset the cash total
        curCash = 0
        //Reset label
        updateCash(addedCash: 0)
        //Reset turns
        turns = 0
        
        //Reset the image for all the buttons
        for x in prizeBtn{
            x.setBackgroundImage(UIImage(named: "dollar.png"), for: UIControl.State.normal)
            x.setTitle(nil, for: UIControl.State.normal)
            //Enable the button
            x.isEnabled = true
            //Make text color a nice green for when the amount is revealed
            x.setTitleColor(.systemGreen, for: UIControl.State.normal)
        }
        //Determine the location of the values
        setVal()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newGame() //Get everything ready for a game
    }


}

