//
//  GameViewController.swift
//  GentleSlot
//
//  Created by Serhii Pianykh on 2017-03-31.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            if let scene = SKScene(fileNamed: "CustomScene") {
                scene.scaleMode = .aspectFill
                scene.backgroundColor = UIColor.init(red: 80/255, green: 190/255, blue: 237/255, alpha: 0.5)
                view.presentScene(scene)
            }
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
