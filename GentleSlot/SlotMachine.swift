//
//  SlotMachine.swift
//  GentleSlot
//
//  Created by Serhii Pianykh on 2017-04-03.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit
import SpriteKit


class SlotMachine: SKSpriteNode {
    
    let jackpotLabel: SKLabelNode = {
        let label = SKLabelNode()
        label.fontSize = 60
        label.fontName = "Chalkduster"
        label.fontColor = SKColor(red: 255/255, green: 35/255, blue: 35/255, alpha: 1)
        label.horizontalAlignmentMode = .center
        label.position = CGPoint(x: 375, y: 1200)
        return label
    }()
    
    let balanceLabel: SKLabelNode = {
        let label = SKLabelNode()
        label.fontSize = 40
        label.fontName = "Chalkduster"
        label.fontColor = SKColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        label.horizontalAlignmentMode = .left
        label.position = CGPoint(x: 30, y: 240)
        return label
    }()
    
    let betLabel: SKLabelNode = {
        let label = SKLabelNode()
        label.fontSize = 40
        label.fontName = "Chalkduster"
        label.fontColor = SKColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        label.horizontalAlignmentMode = .right
        label.position = CGPoint(x: 700, y: 240)
        return label
    }()
    
    let wonLabel: SKLabelNode = {
        let label = SKLabelNode()
        label.fontSize = 50
        label.fontName = "Chalkduster"
        label.fontColor = SKColor(red: 150/255, green: 229/255, blue: 171/255, alpha: 1)
        label.horizontalAlignmentMode = .center
        label.position = CGPoint(x: 375, y: 330)
        return label
    }()

    
    let spinBtn: SKSpriteNode = {
        let button = SKSpriteNode(imageNamed: "spin")
        button.position = CGPoint(x: 630, y: 120)
        button.setScale(0.75)
        return button
    }()
    
    let resetBtn: SKSpriteNode = {
        let button = SKSpriteNode(imageNamed: "reset")
        button.position = CGPoint(x: 100, y: 120)
        button.setScale(0.55)
        return button
    }()
    
    let tenBtn: SKSpriteNode = {
        let button = SKSpriteNode(imageNamed: "10")
        button.position = CGPoint(x: 270, y: 120)
        button.setScale(0.55)
        return button
    }()
    
    let maxBtn: SKSpriteNode = {
        let button = SKSpriteNode(imageNamed: "max")
        button.position = CGPoint(x: 440, y: 120)
        button.setScale(0.55)
        return button
    }()
    
    
    let slot1: SKSpriteNode = {
        let texture = SKTexture(image: #imageLiteral(resourceName: "car"))
        let node = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 150, height: 120))
        node.position = CGPoint(x: 180, y: 975)
        
        return node
    }()
    
    let slot2: SKSpriteNode = {
        let texture = SKTexture(image: #imageLiteral(resourceName: "diamond"))
        let node = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 150, height: 120))
        node.position = CGPoint(x: 365, y: 975)
        
        return node
    }()
    
    let slot3: SKSpriteNode = {
        let texture = SKTexture(image: #imageLiteral(resourceName: "house"))
        let node = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 150, height: 120))
        node.position = CGPoint(x: 550, y: 975)
        
        return node
    }()
    
    
    init() {
        let texture = SKTexture(image: #imageLiteral(resourceName: "tuxedo"))
        super.init(texture: texture, color: .white, size: #imageLiteral(resourceName: "tuxedo").size)
        Start()
        addChild(balanceLabel)
        addChild(betLabel)
        addChild(wonLabel)
        addChild(jackpotLabel)
        addChild(spinBtn)
        addChild(resetBtn)
        addChild(tenBtn)
        addChild(maxBtn)
        addChild(slot1)
        addChild(slot2)
        addChild(slot3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func Start() {
        self.anchorPoint = CGPoint(x: -0.085, y: -0.5)
    }
    
    var gameState: GameModel? {
        didSet {
            updateGameState()
        }
    }
    
    func updateGameState() {
        if let gameState = gameState {
            jackpotLabel.text = "Jackpot: \(gameState.jackpot)"
            balanceLabel.text = "Your balance: \(gameState.balance)"
            betLabel.text = "Bet: \(gameState.currentBet)"
            if gameState.won > 0 {
                wonLabel.fontColor = SKColor(red: 50/255, green: 229/255, blue: 50/255, alpha: 1)
            } else {
                wonLabel.fontColor = SKColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
            }
            wonLabel.text = "Won: \(gameState.won)"
        }
        
    }

    
}
