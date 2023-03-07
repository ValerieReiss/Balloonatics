//
//  GameScene11.swift
//  Balloonatics
//
//  Created by Valerie on 26.02.23.
//

import CoreMotion
import SpriteKit
import GameplayKit

class GameScene11: SKScene, SKPhysicsContactDelegate {
    
    class func newGameScene() -> GameScene11 {
        guard let scene = SKScene(fileNamed: "GameScene11") as? GameScene11 else {
            print("Failed to load GameScene11.sks")
            abort()
        }
        scene.scaleMode = .aspectFill
        return scene
    }
    
    let motionManager = CMMotionManager()
    let player = SKSpriteNode(imageNamed: "player")
    
    let enemyTypes = Bundle.main.decode([EnemyType].self, from: "enemy-types.json")
    
    var scoreLabel: SKLabelNode!
    var playerShields = 10

    let positions = Array(stride(from: -420, through:420, by: 80))
    
    override func didMove(to view: SKView) {
        
        let backgroundImage = SKSpriteNode(imageNamed: "backgroundSky11")
        backgroundImage.anchorPoint = CGPointMake(0.5, 0.5)
        backgroundImage.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(backgroundImage)
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    
        /*if let particles = SKEmitterNode(fileNamed: "Starfield"){
            particles.position = CGPoint (x: 1300, y: 0)
            particles.advanceSimulationTime(60)
            particles.zPosition = 1
            addChild(particles)
        }*/
        
        //playerShields Score anzeigen auf Screen
        let scoreImage = SKSpriteNode(imageNamed: "heart.jpg")
        scoreImage.position = CGPoint(x: -200, y: 150)
        scoreImage.zPosition = 1
        addChild(scoreImage)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: -300, y: 150)
        scoreLabel.zPosition = 1
        addChild(scoreLabel)
    
        player.name = "player"
        player.anchorPoint = CGPointMake(0.5, 0.5)
        player.position.x = frame.minX + 50
        player.position.y = frame.minY/2
        player.setScale(1)
        player.zPosition = 1
        addChild(player)
        
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.texture!.size())
        player.physicsBody?.categoryBitMask = CollisionType.player.rawValue
        player.physicsBody?.collisionBitMask = CollisionType.enemy.rawValue
        player.physicsBody?.contactTestBitMask = CollisionType.enemy.rawValue
        player.physicsBody?.isDynamic = false
        
        motionManager.startAccelerometerUpdates()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let accelerometerData = motionManager.accelerometerData{
            player.position.y += CGFloat(accelerometerData.acceleration.x * 50)
            if player.position.y < frame.minY {
                player.position.y = frame.minY
            } else if player.position.y > frame.maxY {
                player.position.y = frame.maxY
            }
        }
        for child in children {
            if child.frame.maxX < 0 {
                if !frame.intersects(child.frame){
                    child.removeFromParent()
                }
            }
        }
        
        if playerShields > 0 {
            var zahl = 0
            while zahl < 10 {
                zahl += 1
                print("Before delay")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    print("Async after 2 seconds")
                }
                createObstacles()
            }
        } else {
            gameOver()
        }
    }
    
    func createObstacles() {
        let enemyType = Int.random(in: 0..<3)
        //let enemyOffsetX: CGFloat = 400
        let enemyStartX = 1000
        let enemyStartY = Int.random(in: 0..<50)
        
        let enemy = EnemyNode(type: enemyTypes[enemyType], startPosition: CGPoint(x: enemyStartX, y: enemyStartY), /*xOffset: enemyOffsetX,*/ moveStraight: true)
        addChild(enemy)
        
        /*for(index, position) in positions.shuffled().enumerated()
            {
                let enemy = EnemyNode(type: enemyTypes[enemyType], startPosition: CGPoint(x: enemyStartX, y: position), xOffset: enemyOffsetX * CGFloat(index * 2), moveStraight: true)
                addChild(enemy)
                break
            }*/
        print("obstacle created")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
                    if nodeTouched.name == "returnToMenu" {
                        self.view?.presentScene(MenuScene(size: self.size),
                       transition: .crossFade(withDuration: 2))
                    }
           }
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if nodeA.name == "player"{
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = nodeA.position
                addChild(explosion)
            }
            playerShields -= 1
            scoreLabel.text = "\(playerShields)"
            nodeB.removeFromParent()
            
            if playerShields == 0 {
                let tod = SKSpriteNode(imageNamed: "Jo Sad")
                tod.position.x = frame.minX + 100
                addChild(tod)
                
                gameOver()
                nodeA.removeFromParent()
                nodeB.removeFromParent()
                print("Tod 2")
                
            } else {
                print("returned weil score != 0 gewesen")
                return
            }
            
        } else {
            
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = nodeB.position
                addChild(explosion)
            }
            nodeB.removeFromParent()
            fatalError("else!!!! no nodeA  ")
        }
    }
    
    func gameOver() {
        // Show the restart and main menu buttons:
        print("gameover funktion aufrufen")
        player.removeFromParent()
        let jo2 = SKSpriteNode(imageNamed: "JO2.png")
        jo2.setScale(1)
        jo2.zPosition = 2
        jo2.position = CGPoint(x: 100, y: 100)
        self.addChild(jo2)
        
        let rotateAction = SKAction.sequence ([
            SKAction.rotate(toAngle: 0.2, duration: 0.2),
            SKAction.rotate(toAngle: -0.2, duration: 0.2)])
        jo2.run(SKAction.repeatForever(rotateAction))
        
        let gomenuButton = SKSpriteNode(imageNamed: "menuClown.jpg")
        gomenuButton.name = "returnToMenu"
        gomenuButton.position =
        CGPoint(x: 500, y: 50)
        gomenuButton.size = CGSize(width: 70, height: 100)
        gomenuButton.zPosition = 2
        gomenuButton.alpha = 0
        self.addChild(gomenuButton)
        let fadeAnimation =
        SKAction.fadeAlpha(to: 1, duration: 1)
        gomenuButton.run(fadeAnimation)
        
    }
    
}
