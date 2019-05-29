//
//  GameViewController.swift
//  Coin Jumo
//
//  Created by Wilmer sinchi on 5/8/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
//delete the label to add an object to have a physic in the game
// place the red object and click on physic definition on it to see what type of physic
//dynamic meaning if you want to hit another object
//if you dont want the object to move, have it pnned and no gravit and no rotation 
class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
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

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
