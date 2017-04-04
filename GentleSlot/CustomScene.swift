//
//  CustomScene.swift
//  GentleSlot
//
//  Created by Serhii Pianykh on 2017-04-03.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit


class CustomScene: SKScene {
    
    let slotMachine = SlotMachine()
    var game = GameModel()
    
    
    enum stuff: String {
        case alcohol
        case watch
        case car
        case money
        case house
        case gold
        case diamond
        case blank
    }
    
    var bottles = 0;
    var watches = 0;
    var cars = 0;
    var cash = 0;
    var houses = 0;
    var bars = 0;
    var diamonds = 0;
    var blanks = 0;
    
    override func didMove(to view: SKView) {
        addChild(slotMachine)
        getGameState()
    }
    
    func placeBet(bet: Int){
        if game.balance <= 0 {
            game.currentBet = 0
            return
        }
        
        if game.balance >= (bet + game.currentBet) {
            if game.currentBet >= game.balance {
                game.currentBet = 50
            } else {
                game.currentBet += bet
            }
            
        } else {
            if game.currentBet >= game.balance {
                game.currentBet = 50
            } else {
                game.currentBet += bet
            }
        }
    }
    
    func placeMaxBet() {
        game.currentBet = game.balance
    }
    
    func checkResult(){
        if blanks == 0
        {
            if (bottles == 3) {
                game.won = game.currentBet * 10;
            }
            else if(watches == 3) {
                game.won = game.currentBet * 20;
            }
            else if (cars == 3) {
                game.won = game.currentBet * 30;
            }
            else if (cash == 3) {
                game.won = game.currentBet * 40;
            }
            else if (houses == 3) {
                game.won = game.currentBet * 50;
            }
            else if (bars == 3) {
                game.won = game.currentBet * 75;
            }
            else if (diamonds == 3) {
                game.won = game.currentBet * 100;
            }
            else if (bottles == 2) {
                game.won = game.currentBet * 2;
            }
            else if (watches == 2) {
                game.won = game.currentBet * 2;
            }
            else if (cars == 2) {
                game.won = game.currentBet * 3;
            }
            else if (cash == 2) {
                game.won = game.currentBet * 4;
            }
            else if (houses == 2) {
                game.won = game.currentBet * 5;
            }
            else if (bars == 2) {
                game.won = game.currentBet * 10;
            }
            else if (diamonds == 2) {
                game.won = game.currentBet * 20;
            }
            else if (diamonds == 1) {
                game.won = game.currentBet * 5;
            }
            else {
                game.won = game.currentBet * 1;
            }
            
            game.balance += game.won
        }
        else
        {
            game.balance -= game.currentBet
            game.won = 0
            placeBet(bet: 0)
        }
        
        resetSlots()
        
        
    }
    
    func slots(){
        if game.currentBet == 0 {
            return
        }
        var betLine:[stuff] = [stuff.blank,stuff.blank,stuff.blank]
        var result = [0,0,0]
        
        for spin in 0...2 {
            result[spin] = GKARC4RandomSource().nextInt(upperBound: 65) + 1
            getBetLineValue(betLineValue: &betLine[spin], outComeValue: result[spin])
        }
        
        getBetLineImage(betLine: betLine)
        checkJackPot()
        checkResult()
    }
    
    func getBetLineImage(betLine: [stuff]) {
        slotMachine.slot1.texture = SKTexture(imageNamed: betLine[0].rawValue)
        slotMachine.slot2.texture = SKTexture(imageNamed: betLine[1].rawValue)
        slotMachine.slot3.texture = SKTexture(imageNamed: betLine[2].rawValue)
    }
    
    func getBetLineValue(betLineValue:inout stuff ,outComeValue: Int) {
        switch outComeValue {
        // 41.5% chance
        case checkRange(outComeValue: outComeValue, lowerBounds: 1, upperBounds: 27):
            betLineValue = .blank
            blanks += 1
        // 15.4% chance
        case checkRange(outComeValue: outComeValue, lowerBounds: 28, upperBounds: 37):
            betLineValue = .alcohol
            watches += 1
        // 13.8% chance
        case checkRange(outComeValue: outComeValue, lowerBounds: 38, upperBounds: 46):
            betLineValue = .watch
            watches += 1
        // 12.3% chance
        case checkRange(outComeValue: outComeValue, lowerBounds: 47, upperBounds: 54):
            betLineValue = .car
            cars += 1
        //  7.7% chance
        case checkRange(outComeValue: outComeValue, lowerBounds: 55, upperBounds: 59):
            betLineValue = .money
            cash += 1
        //  4.6% chance
        case checkRange(outComeValue: outComeValue, lowerBounds: 60, upperBounds: 62):
            betLineValue = .house
            houses += 1
        //  3.1% chance
        case checkRange(outComeValue: outComeValue, lowerBounds: 63, upperBounds: 64):
            betLineValue = .gold
            bars += 1
        case checkRange(outComeValue: outComeValue, lowerBounds: 65, upperBounds: 65):
            betLineValue = .diamond
            diamonds += 1
        default:
            betLineValue = .blank
            blanks += 1
        }
    }
    
    func checkRange(outComeValue value:Int, lowerBounds:Int, upperBounds: Int) -> Int{
        if value >= lowerBounds && value <= upperBounds {
            return value
        } else {
            return 0
        }
    }
    
    func getGameState(){
        slotMachine.gameState = game
    }
    
    func checkJackPot() {
        let jackPotTry = GKARC4RandomSource().nextInt(upperBound: 51)
        let jackPotWin = GKARC4RandomSource().nextInt(upperBound: 51)
        if jackPotTry == jackPotWin {
            print("you win the \(game.jackpot)")
        }
    }
    
    func resetSlots() {
        bottles = 0;
        watches = 0;
        cars = 0;
        cash = 0;
        bars = 0;
        houses = 0;
        diamonds = 0;
        blanks = 0;
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if slotMachine.spinBtn.contains(pos){
            slots()
        } else if slotMachine.tenBtn.contains(pos) {
            placeBet(bet: 10)
        } else if slotMachine.maxBtn.contains(pos) {
            placeMaxBet()
        } else if slotMachine.resetBtn.contains(pos) {
             game.reset()
        }
        slotMachine.updateGameState()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {self.touchUp(atPoint: t.location(in: self))}
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }


}
