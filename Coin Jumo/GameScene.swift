//
//  GameScene.swift
//  Coin Jumo
//
//  Created by Wilmer sinchi on 5/8/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    var coinMan : SKSpriteNode?
    var ground : SKSpriteNode?
    var ceiling : SKSpriteNode?
    var scoreLabel : SKLabelNode?
    var highScoreLabel : SKLabelNode?
    var yourScoreLabel : SKLabelNode?
    var finalScoreLabel : SKLabelNode?
    
    
    
    var coinTimer : Timer?
    var bombTimer : Timer?
    var score = 0
    var high = 0
    
    let coinManCategory : UInt32 = 0x1 << 1
    let coinCategory : UInt32 = 0x1 << 2
    let bombCategory : UInt32 = 0x1 << 3
    let groundAndCeilingCategory : UInt32 = 0x1 << 4
//    let grassCategory : UInt32 = 0x1 << 5
    
    override func didMove(to view: SKView) {
        //make sure you set up the delegae otherwise it wont work
        physicsWorld.contactDelegate = self
        
        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        // the name of the skspritenode or object inside the game that you put randomly
        coinMan = childNode(withName: "coinMain") as? SKSpriteNode
        coinMan?.physicsBody?.categoryBitMask = coinManCategory
        //keep track of the contact between the coin or the bomb
        coinMan?.physicsBody?.contactTestBitMask = coinCategory | bombCategory
        
        coinMan?.physicsBody?.collisionBitMask = groundAndCeilingCategory
        var coinManRun : [SKTexture] = []
        for number in 1...5 {
            coinManRun.append(SKTexture(imageNamed: "frame-\(number)"))
        }
        
        coinMan?.run(SKAction.repeatForever(SKAction.animate(with: coinManRun, timePerFrame: 0.09)))
        
        //you dont need this since we are using the grass as the new ground
//        ground = childNode(withName: "ground") as? SKSpriteNode
//        ground?.physicsBody?.categoryBitMask = groundAndCeilingCategory
//
//        ground?.physicsBody?.collisionBitMask = coinManCategory
        
        
        scoreLabel = childNode(withName: "scoreLabel") as? SKLabelNode
        finalScoreLabel = childNode(withName: "finalScoreLabel") as? SKLabelNode
        
        ceiling = childNode(withName: "ceiling") as? SKSpriteNode
        ceiling?.physicsBody?.categoryBitMask = groundAndCeilingCategory
        ceiling?.physicsBody?.collisionBitMask = coinManCategory
        
       
        
        createCoin()
        createCoin()
        createCoin()
        createCoin()
        
       
        createBomb()
        createBomb()
        createGrass()
        statTimer()
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
    
//    func highScore() {
////         var high = 0
//        if (score > high){
//            self.high = score
////            highScoreLabel?.text = "Highscore : \(high)"
//            var highScoreSave = UserDefaults.standard
//            highScoreSave.set(high, forKey: "Highscore")
//            highScoreSave.synchronize()
//
//            return
//                (highScoreLabel?.text = ("Highscore: \(highScoreSave.integer(forKey: "Highscore"))"))!
//
//
//
//
//        }
//
//    }
//
    func createGrass(){
        
        let sizingGrass = SKSpriteNode(imageNamed: "ground")
        let numberOfGrass = Int(size.width / sizingGrass.size.width + 1)
        for number in 0...numberOfGrass{
            let grass = SKSpriteNode(imageNamed: "ground")
            grass.physicsBody = SKPhysicsBody(rectangleOf: grass.size)
            grass.physicsBody?.categoryBitMask = groundAndCeilingCategory
            
            grass.physicsBody?.collisionBitMask = coinManCategory
            grass.physicsBody?.affectedByGravity = false
            //you dont want the coinMan to hit the grass
            grass.physicsBody?.isDynamic = false
            addChild(grass)
            
            let grassX = -size.width / 2 + grass.size.width / 2 + grass.size.width * CGFloat(number)
            grass.position = CGPoint(x: grassX, y: -size.height / 2 + grass.size.height / 2 - 18)
            let speed = 100.0
            let firstMoveLeft = SKAction.moveBy(x: -grass.size.width - grass.size.width * CGFloat(number), y: 0, duration: TimeInterval(grass.size.width + grass.size.width * CGFloat(number))/speed)
            
            
            
            let resetGrass = SKAction.moveBy(x: size.width + grass.size.width, y: 0, duration: 0)
            let grassFullMove = SKAction.moveBy(x: -size.width - grass.size.width, y: 0, duration: TimeInterval(size.width + grass.size.width) / speed)
            let grassRepeatForever = SKAction.repeatForever(SKAction.sequence([grassFullMove,resetGrass]))
            //we want the grass to move left and then resete the grass and keep on moving[
            grass.run(SKAction.sequence([firstMoveLeft, resetGrass, grassRepeatForever]))
            
        }
    }
    
    func statTimer() {
        
        coinTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            //since it is in the block, you should put the self in this
            self.createCoin()
        })
        
        bombTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
            self.createBomb()
        })
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
        if scene?.isPaused == false {
            
            coinMan?.physicsBody?.applyForce(CGVector(dx: 0 , dy: 100_000))
        }
//        coinMan?.physicsBody?.applyForce(CGVector(dx: 0 , dy: 100_000.50))
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        let touch = touches.first
        if let location = touch?.location(in: self){
            
     
       let theNode = nodes(at: location)
            
            for node in theNode {
                if node.name == "play"{
                    //restart the game
                    score = 0
                    node.removeFromParent()
                    finalScoreLabel?.removeFromParent()
                    yourScoreLabel?.removeFromParent()
                    scene?.isPaused = false
                    scoreLabel?.text = "Score: \(score)"
                    
//                    highScoreLabel?.text
                    
                    statTimer()
                    
                    
                    
                    
                
                    
                }
//                highScore()
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
//        print ("Contact + \(counter 1)")
        if contact.bodyA.categoryBitMask == coinCategory {
            contact.bodyA.node?.removeFromParent()
            score += 1
//            high = score
            scoreLabel?.text = ("Score: \(score)")
            
        }
        if contact.bodyB.categoryBitMask == coinCategory {
            contact.bodyB.node?.removeFromParent()
            score += 1
//            high = score
            scoreLabel?.text = ("Score: \(score)")
            
        }
        
        if contact.bodyA.categoryBitMask == bombCategory{
            contact.bodyA.node?.removeFromParent()
            gameOver()
//            highScore()
        }
        
        if contact.bodyB.categoryBitMask == bombCategory{
            contact.bodyB.node?.removeFromParent()
            gameOver()
//            highScore()
        }
    }
    
    func gameOver(){
        
        scene?.isPaused = true
        
        coinTimer?.invalidate()
        bombTimer?.invalidate()
        //setting up the label in the middle of the screen
        yourScoreLabel = SKLabelNode(text: "Your Score:")
        yourScoreLabel?.position = CGPoint(x: 0, y: 200)
        yourScoreLabel?.fontSize = 100
        yourScoreLabel?.zPosition = 1
        if yourScoreLabel != nil{
        addChild(yourScoreLabel!)
        }
        
        
        finalScoreLabel = SKLabelNode(text: "\(score)")
        finalScoreLabel?.position = CGPoint(x: 0, y: 0)
        finalScoreLabel?.fontSize = 100
        finalScoreLabel?.zPosition = 1
        
//        highScore()
       
        
//        if (score > high){
//            high = score
//            highScoreLabel?.text = ("Higscore: \(high)")
//
//
//        }
        
        
        
        if finalScoreLabel != nil{
            
        addChild(finalScoreLabel!)
        }
        
        let playButton = SKSpriteNode(imageNamed: "play")
        playButton.position = CGPoint(x: 0, y: -200)
        playButton.name = "play"
        playButton.zPosition = 1
        addChild(playButton)
        
        
    }
    func createCoin() {
        let coin = SKSpriteNode(imageNamed: "coin")
        let sizingGrass = SKSpriteNode(imageNamed: "ground")
        
        //need to add the physic body
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.categoryBitMask = coinCategory
        
        //to turn off the graivity
        coin.physicsBody?.affectedByGravity = false
        //what does the coin need to collide with
        coin.physicsBody?.contactTestBitMask = coinManCategory
        //you dont want the coin collinding wiht anybody
        coin.physicsBody?.collisionBitMask = 0
        addChild(coin)
        
        //setting the postionn of the coin in the middle of the screen
        


        //introduce the y value, give the max
        
        let maxY = size.height/2 - coin.size.height/2
        let minY = -size.height/2 + coin.size.height/2 + sizingGrass.size.height
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
    
    func createBomb() {
        let bomb = SKSpriteNode(imageNamed: "bomb")
        let sizingGrass = SKSpriteNode(imageNamed: "ground")
        //need to add the physic body
        bomb.physicsBody = SKPhysicsBody(rectangleOf: bomb.size)
        bomb.physicsBody?.categoryBitMask = bombCategory
        
        //to turn off the graivity
        bomb.physicsBody?.affectedByGravity = false
        //what does the coin need to collide with
        bomb.physicsBody?.contactTestBitMask = coinManCategory
        //you dont want the coin collinding wiht anybody
        bomb.physicsBody?.collisionBitMask = 0
        addChild(bomb)
        
        //setting the postionn of the coin in the middle of the screen
        
        
        
        //introduce the y value, give the max
        
        let maxY = size.height/2 - bomb.size.height/2
        let minY = -size.height/2 + bomb.size.height/2 + sizingGrass.size.height
        // need to figure out the range, so we have to find the differnce of it
        
        let range = maxY - minY
        
        //func to create a random number by using arcRandom
        let bombY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        //        coin.position = CGPoint(x: 0, y: 0)
        // to put the coin at the side of the screen but half of it
        bomb.position = CGPoint(x: size.width/2 + bomb.size.width/2, y: bombY)
        
        
        
        
        // having the coin to move around the, and deleting them when they reach at the end of the screen
        //
        //        let moveLeft = SKAction.moveBy(x: -300, y: 0, duration: 10)
        
        // if you want the coin to disappear when it hit the ledt side of the screen completly
        let moveLeft = SKAction.moveBy(x: -size.width - bomb.size.width, y: 0, duration: 5)
        bomb.run(SKAction.sequence([moveLeft, SKAction.removeFromParent()]))
        
        
        
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
