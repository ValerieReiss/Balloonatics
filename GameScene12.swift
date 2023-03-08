//
//  GameScene12.swift
//  Shooter
//
//  Created by Valerie on 08.03.23.
//

import SpriteKit
import GameplayKit

class GameScene12: SKScene {
    
    class func newGameScene() -> GameScene12 {
        guard let scene = SKScene(fileNamed: "GameScene12") as? GameScene12 else {
            print("Failed to load GameScene12.sks")
            abort()
        }
        scene.scaleMode = .aspectFill
        return scene
    }

    var player = SKSpriteNode(imageNamed: "playerJo.png")
    var scoreLabel: SKLabelNode!
    var playerShields = 10
    var playerSize = CGSize(width: 50, height: 50)
    var touchLocation = CGPoint()
    
    override func didMove(to view: SKView) {
        let backgroundImage = SKSpriteNode(imageNamed: "backgroundSky12")
        backgroundImage.anchorPoint = CGPointMake(0.5, 0.5)
        backgroundImage.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(backgroundImage)
        
        let scoreImage = SKSpriteNode(imageNamed: "heart.jpg")
        scoreImage.position = CGPoint(x: CGRectGetMidX(self.frame)-230, y: CGRectGetMidY(self.frame)+150)
        scoreImage.zPosition = 2
        addChild(scoreImage)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        //scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame)-250, y: CGRectGetMidY(self.frame)+150)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        
        spawnPlayer()
    }
  
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.location(in: self)
            
            player.position.x = touchLocation.x
            player.position.y = touchLocation.y
        }
    }
    
    func spawnPlayer(){
        player.xScale = 1
        player.yScale = 1
        player.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - 200)
        
        player.zPosition = 2
        
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.texture!.size())
        player.physicsBody?.categoryBitMask = CollisionType.player.rawValue
        player.physicsBody?.collisionBitMask = CollisionType.enemy.rawValue
        player.physicsBody?.contactTestBitMask = CollisionType.enemy.rawValue
        player.physicsBody?.isDynamic = false
        
        self.addChild(player)
    }
}
