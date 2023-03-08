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
    
    let enemyTypes = Bundle.main.decode([EnemyType].self, from: "enemy-types.json")
    var scoreLabel: SKLabelNode!
    var playerShields = 10
    let positions = Array(stride(from: -420, through:420, by: 10))
    

    var lastUpdateTime:TimeInterval = 0
    var dt:TimeInterval = 0
    var player = Player()

    var currentTouchPosition: CGPoint  = CGPointZero
    var beginningTouchPosition:CGPoint = CGPointZero
    var currentPlayerPosition: CGPoint = CGPointZero

    var playableRectArea:CGRect = CGRectZero
    
    override func didMove(to view: SKView) {
        
        let backgroundImage = SKSpriteNode(imageNamed: "backgroundSky11")
        backgroundImage.anchorPoint = CGPointMake(0.5, 0.5)
        backgroundImage.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        backgroundImage.zPosition = 0
        self.addChild(backgroundImage)
        
        scene?.physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
    
        let scoreImage = SKSpriteNode(imageNamed: "heart.jpg")
        scoreImage.position = CGPoint(x: CGRectGetMidX(self.frame)-230, y: CGRectGetMidY(self.frame)+150)
        scoreImage.zPosition = 2
        addChild(scoreImage)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        //scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame)-250, y: CGRectGetMidY(self.frame)+150)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
    
        scene?.physicsWorld.gravity = CGVectorMake(0, 0)
        let maxAspectRatio:CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRectArea = CGRect(x: 0, y: playableMargin,
                                      width: size.width,
                                      height: playableHeight)
        currentTouchPosition = CGPointZero
        beginningTouchPosition = CGPointZero
        currentPlayerPosition = CGPoint(x: CGRectGetMidX(self.frame)-200, y: CGRectGetMidY(self.frame))
        
        player.position = currentPlayerPosition
        self.addChild(player)
    
    }
    
    func createObstacles() {
        let enemyType = Int.random(in: 0..<3)
        let enemyOffsetX: CGFloat = 400
        let enemyStartX = 10
        let enemyStartY = Int.random(in: 0..<50)
        
        for(index, position) in positions.shuffled().enumerated()
            {
                let enemy = EnemyNode(type: enemyTypes[enemyType], startPosition: CGPoint(x: enemyStartX, y: position), xOffset: enemyOffsetX * CGFloat(index * 2), moveStraight: true)
                addChild(enemy)
                break
            }
        print("obstacle created")
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        print("physic contact")
        if let explosion = SKEmitterNode(fileNamed: "Explosion"){
            explosion.position = nodeA.position
            addChild(explosion)
        }
        
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
            print("hit object hehe")
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
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            currentTouchPosition = touch.location(in:self)
        }

        let dxVectorValue = (-1) * (beginningTouchPosition.x - currentTouchPosition.x)
        let dyVectorValue = (-1) * (beginningTouchPosition.y - currentTouchPosition.y)

        player.movePlayerBy(dxVectorValue: 0, dyVectorValue: dyVectorValue, duration: dt)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.removeAllActions()
        player.stopMoving()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch")
        for touch: AnyObject in touches {
            beginningTouchPosition = touch.location(in:self)
            currentTouchPosition = beginningTouchPosition
        }
    }

    override func update(_ currentTime: CFTimeInterval) {
        currentPlayerPosition = player.position

        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        }else{
            dt = 0
        }
        lastUpdateTime = currentTime

        player.boundsCheckPlayer(playableArea: playableRectArea)
        
       
        
        
    }
}
