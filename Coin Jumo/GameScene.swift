//
//  GameScene.swift
//  Coin Jumo
//
//  Created by Wilmer sinchi on 5/8/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    var coinMan : SKSpriteNode?
    var coinTimer : Timer?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        // the name of the skspritenode or object inside the game that you put randomly
        coinMan = childNode(withName: "coinMain") as? SKSpriteNode
        
        coinTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            //since it is in the block, you should put the self in this
            self.createCoin()
        })
        
        createCoin()
        createCoin()
        createCoin()
        createCoin()
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//        
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//        
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//            
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
    }
    
    
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        coinMan?.physicsBody?.applyForce(CGVector(dx: 0 , dy: 100_0000))
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func createCoin() {
        let coin = SKSpriteNode(imageNamed: "coin")
        addChild(coin)
        
        //setting the postionn of the coin in the middle of the screen
        


        //introduce the y value, give the max
        
        let maxY = size.height/2 - coin.size.height/2
        let minY = -size.height/2 + coin.size.height/2
        // need to figure out the range, so we have to find the differnce of it
        
        let range = maxY - minY
        
        //func to create a random number by using arcRandom
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        //        coin.position = CGPoint(x: 0, y: 0)
        // to put the coin at the side of the screen but half of it
        coin.position = CGPoint(x: size.width/2 + coin.size.width/2, y: coinY)
        
        
        
        
        // having the coin to move around the, and deleting them when they reach at the end of the screen
        //
//        let moveLeft = SKAction.moveBy(x: -300, y: 0, duration: 10)
        
        // if you want the coin to disappear when it hit the ledt side of the screen completly
        let moveLeft = SKAction.moveBy(x: -size.width - coin.size.width, y: 0, duration: 5)
        coin.run(SKAction.sequence([moveLeft, SKAction.removeFromParent()]))
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
    
    
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
}
