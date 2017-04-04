//
//  GameModel.swift
//  GentleSlot
//
//  Created by Serhii Pianykh on 2017-04-03.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import Foundation

class GameModel {
    
    private var _balance = 1000
    private var _jackpot = 10000
    private var _currentBet = 50
    private var _won = 0
    
    var balance: Int {
        get {
            return _balance
        }
        set {
            _balance = newValue
        }
    }
    var jackpot: Int {
        get {
            return _jackpot
        }
        set {
            _jackpot = newValue
        }
    }
    var currentBet: Int {
        get {
            return _currentBet
        }
        set {
            _currentBet = newValue
        }
    }
    var won: Int {
        get {
            return _won
        }
        set {
            _won = newValue
        }
    }
    
    func reset() {
        _balance = 2000
        _jackpot = 10000
        _currentBet = 50
        _won = 0
    }
}
