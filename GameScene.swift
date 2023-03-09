//
//  GameScene.swift
//  Balloonatics
//
//  Created by Valerie on 08.03.23.
//

import CoreMotion
import SpriteKit
import GameplayKit

enum CollisionType: UInt32 {
    case player = 1
    case enemy = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    let motionManager = CMMotionManager()
    let player = SKSpriteNode(imageNamed: "player")
    
    let enemyTypes = Bundle.main.decode([EnemyType].self, from: "enemy-types.json")
    
    var scoreLabel: SKLabelNode!
    var playerShields = 20
    //{didSet {scoreLabel.text = "Score: \(playerShields)"}}

    let positions = Array(stride(from: -420, through:420, by: 80))
    
    override func didMove(to view: SKView) {
        
        let backgroundImage = SKSpriteNode(imageNamed: "backgroundSky5")
        backgroundImage.anchorPoint = CGPointMake(0.5, 0.5)
        backgroundImage.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(backgroundImage)
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
    
        if let particles = SKEmitterNode(fileNamed: "Starfield"){
            particles.position = CGPoint (x: 1300, y: 0)
            particles.advanceSimulationTime(60)
            particles.zPosition = 1
            addChild(particles)
        }
        
        //playerShields Score anzeigen auf Screen
            scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
            scoreLabel.text = "Score:"
            let scoreImage = SKSpriteNode(imageNamed: "heart.jpg")
            scoreLabel.horizontalAlignmentMode = .left
            scoreLabel.position = CGPoint(x: -400, y: 150)
            scoreImage.position = CGPoint(x: -200, y: 150)
            scoreLabel.zPosition = 1
            addChild(scoreLabel)
            addChild(scoreImage)

        
        player.name = "player"
        player.position.x = frame.minX + 200
        player.setScale(1)
        //player.size.height = frame.height/5
        //player.size.width = frame.height/9
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
       
        let activeEnemies = children.compactMap { $0 as? EnemyNode}
        if activeEnemies.isEmpty {
                if playerShields != 0  {
                    var zahl = 0
                    while zahl < 10 {
                        print ("zahl, \(zahl)")
                        zahl += 1
                        createObstacles()
                        print("child added, \(zahl)")
                    }
                }
        }
    }
    
    func createObstacles() {
        let enemyType = Int.random(in: 0..<3)
        let enemyOffsetX: CGFloat = 100
        let enemyStartX = 500
        
        for(index, position) in positions.shuffled().enumerated()
            {
                let enemy = EnemyNode(type: enemyTypes[enemyType], startPosition: CGPoint(x: enemyStartX, y: position), xOffset: enemyOffsetX * CGFloat(index * 2), moveStraight: true)
                addChild(enemy)
                break
            }
        print("obstacle created")
    }
    
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)

               // Check for HUD buttons:
               if nodeTouched.name == "restartGame" {
                   // Transition to a new version of the GameScene
                   // to restart the game:
                   self.view?.presentScene(
                       GameScene(size: self.size),
                       transition: .crossFade(withDuration: 0.6))
               }
               else if nodeTouched.name == "returnToMenu" {
                   // Transition to the main menu scene:
                   self.view?.presentScene(
                       MenuScene(size: self.size),
                       transition: .crossFade(withDuration: 0.6))
               }
           }
        
    }*/
    
    func didBegin(_ contact: SKPhysicsContact){
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if nodeA.name == "player"{
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = nodeA.position
                addChild(explosion)
            }
            print("my Hearts are at \(playerShields) ")
            
            playerShields -= 1
            scoreLabel.text = "Score: \(playerShields)"
            nodeB.removeFromParent()
            
            if playerShields == 0 {
                /*let gameOver = SKSpriteNode(imageNamed: "gameOver")
                gameOver.position.x = frame.minX + 100
                addChild(gameOver)*/
                
                gameOver()
                nodeA.removeFromParent()
                
                print("playerShields at 0 and GamerOver")
                
                // Alert the GameScene:
                fatalError("backto menu load a menu ")
                //Button zum Menu einbauen
               //Funktion aufrufen zum Menubild
                
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
        //extra.showButtons()
    }
}
