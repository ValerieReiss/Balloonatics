//
//  GameScene9.swift
//  Balloonatics
//
//  Created by Valerie on 09.03.23.
//
import CoreMotion
import SpriteKit
import GameplayKit

class GameScene9: SKScene, SKPhysicsContactDelegate {
    
    class func newGameScene() -> GameScene9 {
        guard let scene = SKScene(fileNamed: "GameScene9") as? GameScene9 else {
            print("Failed to load GameScene9.sks")
            abort()
        }
        scene.scaleMode = .aspectFill
        return scene
    }
    /*
    let enemyTypes = Bundle.main.decode([EnemyType].self, from: "enemy-types.json")
    var scoreLabel: SKLabelNode!
    var playerShields = 10

    var lastUpdateTime:TimeInterval = 0
    var dt:TimeInterval = 0
    var player = Player()

    var currentTouchPosition: CGPoint  = CGPointZero
    var beginningTouchPosition:CGPoint = CGPointZero
    var currentPlayerPosition: CGPoint = CGPointZero

    var playableRectArea:CGRect = CGRectZero
    
    override func didMove(to view: SKView) {
        
        let backgroundImage = SKSpriteNode(imageNamed: "backgroundSky9")
        backgroundImage.anchorPoint = CGPointMake(0.5, 0.5)
        backgroundImage.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        backgroundImage.zPosition = -20
        self.addChild(backgroundImage)
        
        physicsWorld.contactDelegate = self
        
        navibar()
    
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
        let enemyStartY = Int.random(in: 50..<300)
        let positions = Array(stride(from: -1000, through:1000, by: 2000))

        for(index, _) in positions.shuffled().enumerated()
            {
                let enemy = EnemyNode(type: enemyTypes[enemyType], startPosition: CGPoint(x: 844, y: enemyStartY), xOffset: 100 * CGFloat(index * 6), moveStraight: true)
                addChild(enemy)
                break
            }
        print("obstacle created")
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        let sortedNodes = [nodeA, nodeB].sorted {$0.name ?? "" < $1.name ?? ""}
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        
        if secondNode.name == "player"{
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = firstNode.position
                addChild(explosion)
            }
            playerShields -= 1
            if playerShields == 0 {
                gameOver()
                secondNode.removeFromParent()
            }
            firstNode.removeFromParent()
        } else if let enemy = firstNode as? EnemyNode{
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = enemy.position
                addChild(explosion)}
                enemy.removeFromParent()
        } else {
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = secondNode.position
                addChild(explosion)}
            nodeB.removeFromParent()
            playerShields -= 1
            if playerShields == 0 {
                gameOver()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            currentTouchPosition = touch.location(in:self)
        }
        let dxVectorValue = (-1) * (beginningTouchPosition.x - currentTouchPosition.x)
        let dyVectorValue = (-1) * (beginningTouchPosition.y - currentTouchPosition.y)
        player.movePlayerBy(dxVectorValue: dxVectorValue, dyVectorValue: dyVectorValue, duration: dt)
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
        scoreLabel.text = "\(playerShields)"
        currentPlayerPosition = player.position
        if lastUpdateTime > 0 {dt = currentTime - lastUpdateTime}
        else {dt = 0}
        lastUpdateTime = currentTime
        player.boundsCheckPlayer(playableArea: playableRectArea)
        
        let activeEnemies = children.compactMap { $0 as? EnemyNode}
        if activeEnemies.isEmpty {
            if playerShields != 0  {
                //let wait = SKAction.wait(forDuration: 0.05, withRange: 0.05)
                //SKAction.repeat(wait, count: 1)
                createObstacles()
                
            } else if playerShields == 0 {
                    gameOver()
            }
        }
        
        for child in children {
            if child.frame.maxX < 0 {
                if !frame.intersects(child.frame){
                    child.removeFromParent()
                }
            }
        }
        
    }
    
    func navibar(){
        let scoreImage = SKSpriteNode(imageNamed: "heart1")
        scoreImage.position = CGPoint(x: CGRectGetMidX(self.frame)-300, y: CGRectGetMidY(self.frame)+170)
        scoreImage.zPosition = 2
        addChild(scoreImage)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame)-250, y: CGRectGetMidY(self.frame)+160)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        scoreLabel.text = "\(playerShields)"
    }
    
    func gameOver() {
        
        player.removeAllActions()
        player.stopMoving()
        player.removeFromParent()
        
        let jo2 = SKSpriteNode(imageNamed: "JO2.png")
        jo2.setScale(1)
        jo2.zPosition = 4
        jo2.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(jo2)
        
        let rotateAction = SKAction.sequence ([
            SKAction.rotate(toAngle: 0.2, duration: 0.4),
            SKAction.rotate(toAngle: -0.2, duration: 0.4)])
        jo2.run(SKAction.repeatForever(rotateAction))
        
        let gomenuButton = SKSpriteNode(imageNamed: "menuClown.jpg")
        gomenuButton.name = "returnToMenu"
        gomenuButton.position = CGPoint(x: 800, y: 50)
        gomenuButton.size = CGSize(width: 70, height: 100)
        gomenuButton.zPosition = 4
        self.addChild(gomenuButton)
    }*/
}
