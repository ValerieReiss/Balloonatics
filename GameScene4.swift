//
//  GameScene4.swift
//  Balloonatics
//
//  Created by Valerie on 10.03.23.
//

import CoreMotion
import SpriteKit
import GameplayKit

/*enum CollisionType: UInt32 {
    case player = 1
    case enemy = 2
    case star = 4
}*/

class GameScene4: SKScene, SKPhysicsContactDelegate {
    
    class func newGameScene() -> GameScene4 {
        guard let scene = SKScene(fileNamed: "GameScene3") as? GameScene4 else {
            print("Failed to load GameScene4.sks")
            abort()
        }
        scene.scaleMode = .aspectFill
        return scene
    }
    
    let enemyTypes = Bundle.main.decode([EnemyType].self, from: "enemy-types.json")
    
    var scoreLabel: SKLabelNode!
    var starLabel: SKLabelNode!
    var txtGameOver: SKLabelNode!
    var playerHearts = 10
    var playerStars = 0

    var lastUpdateTime:TimeInterval = 0
    var dt:TimeInterval = 0
    var player = Player()

    var currentTouchPosition: CGPoint  = CGPointZero
    var beginningTouchPosition:CGPoint = CGPointZero
    var currentPlayerPosition: CGPoint = CGPointZero

    var playableRectArea:CGRect = CGRectZero
    
    override func didMove(to view: SKView) {
        
        let backgroundImage = SKSpriteNode(imageNamed: "backgroundSky4")
        backgroundImage.anchorPoint = CGPointMake(0.5, 0.5)
        backgroundImage.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        backgroundImage.zPosition = -20
        self.addChild(backgroundImage)
        
        navibar()
        
        physicsWorld.contactDelegate = self
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
    }
    
    func createStars(){
        let startPosition = Int.random(in: 50..<300)
        let star = StarNode(startPosition: CGPoint(x: 844, y: startPosition), moveStraight: true)
        addChild(star)
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        let sortedNodes = [nodeA, nodeB].sorted {$0.name ?? "" < $1.name ?? ""}
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        
        if secondNode.name == "enemy"{
            print("enemy")
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = firstNode.position
                addChild(explosion)}
            secondNode.removeFromParent()
            playerHearts -= 1
            if playerHearts == -1 {gameOver()}
        }
        else if secondNode is StarNode{
            print("starnode")
            secondNode.removeFromParent()
            playerStars += 1
            if playerStars == 10 {won()}
        }
        else {
            print("keine ahnung")
        }
            
        /*
        } else if let enemy = firstNode as? EnemyNode{
            print("enemynode")
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = enemy.position
                addChild(explosion)}
            enemy.removeFromParent()
        } else if let star = firstNode as? StarNode{
            print("starnode")
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = star.position
                addChild(explosion)}
            star.removeFromParent()
            playerStars += 1
            if playerStars == 10 {won()}
        } else {
            print("else keine ahnung wer")
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = secondNode.position
                addChild(explosion)}
            nodeB.removeFromParent()
            playerHearts -= 1
            if playerHearts == -1 {
            gameOver()
            }
        }*/
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        for touch: AnyObject in touches {
            currentTouchPosition = touch.location(in:self)
        }
        let dxVectorValue = (-1) * (beginningTouchPosition.x - currentTouchPosition.x)
        let dyVectorValue = (-1) * (beginningTouchPosition.y - currentTouchPosition.y)
        player.movePlayerBy(dxVectorValue: dxVectorValue, dyVectorValue: dyVectorValue, duration: dt)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        player.removeAllActions()
        player.stopMoving()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        print("touch")
        for touch: AnyObject in touches {
            beginningTouchPosition = touch.location(in:self)
            currentTouchPosition = beginningTouchPosition
        }
        guard var touch = touches.first else {return}
        touch = (touches.first as UITouch?)!
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        if node.name == "returnToMenu"{
                    print ("One Object touched")
                    self.view?.presentScene(MenuScene(size: self.size),
                    transition: .crossFade(withDuration: 2))
                } else if node.name != "returnToMenu" {
                    print ("fail")
                }
    }

    override func update(_ currentTime: CFTimeInterval) {
        scoreLabel.text = "\(playerHearts)"
        starLabel.text = "\(playerStars)"
        currentPlayerPosition = player.position
        if lastUpdateTime > 0 {dt = currentTime - lastUpdateTime}
        else {dt = 0}
        lastUpdateTime = currentTime
        player.boundsCheckPlayer(playableArea: playableRectArea)
        
        let activeEnemies = children.compactMap { $0 as? EnemyNode}
        if activeEnemies.isEmpty {
            if playerHearts != 0  {
                createObstacles()
            } else if playerHearts == 0 {
                    gameOver()
            }
        }
       
        let activeStars = children.compactMap { $0 as? StarNode}
        if activeStars.isEmpty {
            if playerStars != 10  {
                createStars()
            } else if playerStars == 10 {
                    won()
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
        let naviHeart = SKSpriteNode(imageNamed: "heart1")
        naviHeart.position = CGPoint(x: CGRectGetMidX(self.frame)-300, y: CGRectGetMidY(self.frame)+170)
        naviHeart.zPosition = 2
        addChild(naviHeart)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame)-250, y: CGRectGetMidY(self.frame)+160)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        scoreLabel.text = "\(playerHearts)"
        
        let naviStar = SKSpriteNode(imageNamed: "star1")
        naviStar.position = CGPoint(x: CGRectGetMidX(self.frame)-200, y: CGRectGetMidY(self.frame)+170)
        naviStar.zPosition = 2
        addChild(naviStar)
        
        starLabel = SKLabelNode(fontNamed: "Chalkduster")
        starLabel.position = CGPoint(x: CGRectGetMidX(self.frame)-150, y: CGRectGetMidY(self.frame)+160)
        starLabel.zPosition = 2
        addChild(starLabel)
        starLabel.text = "\(playerStars)"
    }
    
    func gameOver() {
        
        player.removeAllActions()
        player.stopMoving()
        player.removeFromParent()
        
        let jo = SKSpriteNode(imageNamed: "JO2.png")
        jo.name = "returnToMenu"
        jo.setScale(1)
        jo.zPosition = 4
        jo.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(jo)
        
        txtGameOver = SKLabelNode(fontNamed: "Chalkduster")
        txtGameOver.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)-100)
        txtGameOver.zPosition = 2
        addChild(txtGameOver)
        txtGameOver.text = "GameOver"
    }
    
    func won() {
        
        player.removeAllActions()
        player.stopMoving()
        player.removeFromParent()
        
        let jo = SKSpriteNode(imageNamed: "JO4.png")
        jo.name = "returnToMenu"
        jo.setScale(1)
        jo.zPosition = 4
        jo.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(jo)
        
        txtGameOver = SKLabelNode(fontNamed: "Chalkduster")
        txtGameOver.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)-100)
        txtGameOver.zPosition = 2
        addChild(txtGameOver)
        txtGameOver.text = "**Congratulations**"
        
    }
}
