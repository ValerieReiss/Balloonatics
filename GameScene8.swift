//
//  GameScene8.swift
//  Balloonatics
//
//  Created by Valerie on 10.03.23.
//

import CoreMotion
import SpriteKit
import GameplayKit
/*
enum CollisionType: UInt32 {
    case player = 1
    case enemy = 2
    case star = 4
}*/

class GameScene8: SKScene, SKPhysicsContactDelegate {
    
    private var magicStick : SKEmitterNode?
    
    class func newGameScene() -> GameScene8 {
        guard let scene = SKScene(fileNamed: "GameScene8") as? GameScene8 else {
            print("Failed to load GameScene8.sks")
            abort()
        }
        scene.scaleMode = .aspectFill
        return scene
    }
    
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
        
        self.magicStick = SKEmitterNode(fileNamed: "MyParticle.sks")
                
        if let magicStick = self.magicStick {
            magicStick.particleTexture = SKTexture(imageNamed: "magicstick.png")
            magicStick.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
                }
        
        let backgroundImage = SKSpriteNode(imageNamed: "backgroundSky8-0")
        backgroundImage.anchorPoint = CGPointMake(0.5, 0.5)
        backgroundImage.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        backgroundImage.zPosition = -20
        addChild(backgroundImage)
        
        let moveleft1 = SKAction.moveTo(x: -15550, duration: 800)
        let sequence1 = SKAction.sequence([moveleft1, .removeFromParent()])
        
        let forground0 = SKSpriteNode(imageNamed: "forground8")
        forground0.anchorPoint = CGPointMake(0.5, 0.5)
        forground0.size = CGSize(width: 8000, height: self.frame.height-60)
        forground0.position =  CGPoint(x: 4000, y: self.frame.midY-50)
        forground0.zPosition = 0
        addChild(forground0)
        forground0.run(sequence1)
        
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
        _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            self.createStars()
        }
        _ = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer1 in
            self.createBalloons()
        }
        _ = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: true) { timer2 in
            self.create1()
        }
        _ = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: true) { timer3 in
            self.create2()
        }
        _ = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: true) { time4 in
            self.create3()
        }
    }
    
    func createStars(){
        let star = SKSpriteNode(imageNamed: "objectStar2")
        star.setScale(1)
        star.zPosition = 4
        star.name = "star"
        star.physicsBody = SKPhysicsBody(texture: star.texture!, size: star.texture!.size())
        star.physicsBody?.categoryBitMask = CollisionType.star.rawValue
        star.physicsBody?.collisionBitMask = CollisionType.player.rawValue
        star.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
        star.physicsBody?.isDynamic = false
        star.position = CGPoint(x: 844, y: Int.random(in: 50..<350))
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: -1000, y: 0))
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 100)
        let sequence = SKAction.sequence([movement, .removeFromParent()])
        addChild(star)
        star.run (sequence)
    }
    
    func createBalloons(){
        let balloon = SKSpriteNode(imageNamed: "balloon")
        balloon.setScale(1)
        balloon.zPosition = 4
        balloon.name = "balloon"
        balloon.physicsBody = SKPhysicsBody(texture: balloon.texture!, size: balloon.texture!.size())
        balloon.physicsBody?.categoryBitMask = CollisionType.balloon.rawValue
        balloon.physicsBody?.collisionBitMask = CollisionType.player.rawValue
        balloon.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
        balloon.physicsBody?.isDynamic = false
        balloon.position = CGPoint(x: Int.random(in: 50..<700), y: -10)
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: 1400))
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 100)
        let sequence = SKAction.sequence([movement, .removeFromParent()])
        addChild(balloon)
        balloon.run (sequence)
    }
    
    func create1(){
        let create1 = SKSpriteNode(imageNamed: "objectPlane2")
        create1.setScale(1)
        create1.zPosition = 4
        create1.name = "create1"
        create1.physicsBody = SKPhysicsBody(texture: create1.texture!, size: create1.texture!.size())
        create1.physicsBody?.categoryBitMask = CollisionType.create1.rawValue
        create1.physicsBody?.collisionBitMask = CollisionType.player.rawValue
        create1.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
        create1.physicsBody?.isDynamic = false
        create1.position = CGPoint(x: 844, y: Int.random(in: 220..<350))
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: -1000, y: 0))
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 90)
        let sequence = SKAction.sequence([movement, .removeFromParent()])
        addChild(create1)
        create1.run (sequence)
    }
    func create2(){
        let create2 = SKSpriteNode(imageNamed: "objectSnowflake")
        create2.setScale(1)
        create2.zPosition = 4
        create2.name = "create2"
        create2.physicsBody = SKPhysicsBody(texture: create2.texture!, size: create2.texture!.size())
        create2.physicsBody?.categoryBitMask = CollisionType.create2.rawValue
        create2.physicsBody?.collisionBitMask = CollisionType.player.rawValue
        create2.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
        create2.physicsBody?.isDynamic = false
        create2.position = CGPoint(x: Int.random(in: 50..<750), y: 500)
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: -500, y: -1000))
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 70)
        let sequence = SKAction.sequence([movement, .removeFromParent()])
        addChild(create2)
        create2.run (sequence)
    }
    func create3(){
        let create3 = SKSpriteNode(imageNamed: "objectSnowflake")
        //create3.setScale(0.8)
        create3.zPosition = 4
        create3.name = "create3"
        create3.physicsBody = SKPhysicsBody(texture: create3.texture!, size: create3.texture!.size())
        create3.physicsBody?.categoryBitMask = CollisionType.create3.rawValue
        create3.physicsBody?.collisionBitMask = CollisionType.player.rawValue
        create3.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
        create3.physicsBody?.isDynamic = false
        create3.position = CGPoint(x: Int.random(in: 50..<750), y: 500)
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: -400, y: -1000))
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 60)
        let sequence = SKAction.sequence([movement, .removeFromParent()])
        addChild(create3)
        create3.run (sequence)
    }
    
    
    func didBegin(_ contact: SKPhysicsContact){
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        let sortedNodes = [nodeA, nodeB].sorted {$0.name ?? "" < $1.name ?? ""}
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        
        if secondNode.name == "create1"{
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = secondNode.position
                addChild(explosion)}
            secondNode.removeFromParent()
            run("sound-bomb")
            playerHearts -= 1
            if playerHearts == -1 {
                gameOver()}
        }
        if firstNode.name == "create1"{
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = firstNode.position
                addChild(explosion)}
            firstNode.removeFromParent()
            run("sound-bomb")
            playerHearts -= 1
            if playerHearts == -1 {
                gameOver()}
        }
        
        if secondNode.name == "create2"{
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = secondNode.position
                addChild(explosion)}
            secondNode.removeFromParent()
            run("sound-bomb")
            playerHearts -= 1
            if playerHearts == -1 {
                gameOver()}
        }
        if firstNode.name == "create2"{
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = firstNode.position
                addChild(explosion)}
            firstNode.removeFromParent()
            run("sound-bomb")
            playerHearts -= 1
            if playerHearts == -1 {
                gameOver()}
        }
        
        if secondNode.name == "create3"{
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = secondNode.position
                addChild(explosion)}
            secondNode.removeFromParent()
            run("sound-bomb")
            playerHearts -= 1
            if playerHearts == -1 {
                gameOver()}
        }
        if firstNode.name == "create3"{
            if let explosion = SKEmitterNode(fileNamed: "Explosion"){
                explosion.position = firstNode.position
                addChild(explosion)}
            firstNode.removeFromParent()
            run("sound-bomb")
            playerHearts -= 1
            if playerHearts == -1 {
                gameOver()}
        }
        
        else if secondNode.name == "star"{
            if let sparkleStars = SKEmitterNode(fileNamed: "particleStars"){
                sparkleStars.position = secondNode.position
                addChild(sparkleStars)}
            secondNode.removeFromParent()
            run("sound-star")
            playerStars += 1
            if playerStars == 10 {
                won()
            }
        }else if firstNode.name == "star"{
            if let sparkleStars = SKEmitterNode(fileNamed: "particleStars"){
                sparkleStars.position = firstNode.position
                addChild(sparkleStars)}
            firstNode.removeFromParent()
            run("sound-star")
            playerStars += 1
            if playerStars == 10 {
                won()
            }
        }
        else if secondNode.name == "balloon"{
            if let sparkleStars = SKEmitterNode(fileNamed: "particleStars"){
                sparkleStars.particleTexture = SKTexture(imageNamed: "particleHeart")
                sparkleStars.position = secondNode.position
                addChild(sparkleStars)}
            run("sound-button")
        }
        else if firstNode.name == "balloon"{
            if let sparkleStars = SKEmitterNode(fileNamed: "particleStars"){
                sparkleStars.particleTexture = SKTexture(imageNamed: "particleHeart")
                sparkleStars.position = firstNode.position
                addChild(sparkleStars)}
            run("sound-button")
        }
        else {
            print("keine ahnung")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        for touch: AnyObject in touches {
            currentTouchPosition = touch.location(in:self)
        }
        let dxVectorValue = (-1) * (beginningTouchPosition.x - currentTouchPosition.x)
        let dyVectorValue = (-1) * (beginningTouchPosition.y - currentTouchPosition.y)
        player.movePlayerBy(dxVectorValue: dxVectorValue, dyVectorValue: dyVectorValue, duration: dt)
        if let n = self.magicStick?.copy() as! SKEmitterNode? {
            n.position = currentTouchPosition
            self.addChild(n)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        player.removeAllActions()
        player.stopMoving()
        
        let rotate = SKAction.rotate(toAngle: 0.05, duration:0.05)
        let rotateback = SKAction.rotate(toAngle: -0.03, duration:0.1)
        
        let sequence = SKAction.sequence([rotate, rotateback])
        let redo = SKAction.repeat(sequence, count: 2)
        player.run(redo)
        
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
                    run("sound-button")
                    self.view?.presentScene(MenuScene(size: self.size),
                    transition: .crossFade(withDuration: 2))
                } else if node.name != "returnToMenu" {
                    print ("fail")
                }
        if let n = self.magicStick?.copy() as! SKEmitterNode? {
            n.position = location
            self.addChild(n)
        }
        
        if node.name == "balloon"{
            if let sparkleStars = SKEmitterNode(fileNamed: "particleStars"){
                sparkleStars.particleTexture = SKTexture(imageNamed: "particleHeart")
                sparkleStars.position = player.position
                sparkleStars.zPosition = 3
                addChild(sparkleStars)}
            run("sound-button")
            playerHearts += 1
            node.removeFromParent()
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
        
    }
    
    func navibar(){
        let naviHeart = SKSpriteNode(imageNamed: "heart1")
        naviHeart.position = CGPoint(x: self.frame.midX - 300, y: self.frame.midY + 170)
        naviHeart.setScale(1.5)
        naviHeart.zPosition = 2
        addChild(naviHeart)
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: self.frame.midX - 260, y: self.frame.midY + 157)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        scoreLabel.text = "\(playerHearts)"
      
        let naviStar = SKSpriteNode(imageNamed: "star1")
        naviStar.position = CGPoint(x: self.frame.midX - 200, y: self.frame.midY + 168)
        naviStar.setScale(1.5)
        naviStar.zPosition = 2
        addChild(naviStar)
        starLabel = SKLabelNode(fontNamed: "Chalkduster")
        starLabel.position = CGPoint(x: self.frame.midX - 160, y: self.frame.midY + 157)
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
        jo.zPosition = 10
        jo.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        addChild(jo)
        
        let f0 = SKTexture.init(imageNamed: "JO0.png")
        let f1 = SKTexture.init(imageNamed: "JO1.png")
        let f2 = SKTexture.init(imageNamed: "JO2.png")
        let frames0: [SKTexture] = [f0]
        let frames1: [SKTexture] = [f1, f2]
        let normal = SKAction.animate(with: frames0, timePerFrame: 0.3)
        let happy = SKAction.animate(with: frames1, timePerFrame: 0.2)
        let normalaction = SKAction.repeat(normal, count: 1)
        let happyaction = SKAction.repeat(happy, count: 4)
        let sequence = SKAction.sequence([normalaction, happyaction])
        let redo = SKAction.repeatForever(sequence)
        jo.run(redo)
        
        txtGameOver = SKLabelNode(fontNamed: "Chalkduster")
        txtGameOver.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)-100)
        txtGameOver.zPosition = 2
        addChild(txtGameOver)
        txtGameOver.text = "ººº GameOver ººº"
        
        if let bubbles = SKEmitterNode(fileNamed: "particle-Lose"){
            bubbles.position = jo.position
            addChild(bubbles)}
    }
    
    func won() {
        //run("sound-won")
        player.removeAllActions()
        player.stopMoving()
        player.removeFromParent()
        
        let jo = SKSpriteNode(imageNamed: "JO4.png")
        jo.name = "returnToMenu"
        jo.setScale(1)
        jo.zPosition = 10
        jo.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        addChild(jo)
        
        let f0 = SKTexture.init(imageNamed: "JO0.png")
        let f1 = SKTexture.init(imageNamed: "JO3.png")
        let f2 = SKTexture.init(imageNamed: "JO4.png")
        let frames0: [SKTexture] = [f0]
        let frames1: [SKTexture] = [f1, f2]
        let normal = SKAction.animate(with: frames0, timePerFrame: 0.3)
        let happy = SKAction.animate(with: frames1, timePerFrame: 0.1)
        let normalaction = SKAction.repeat(normal, count: 1)
        let happyaction = SKAction.repeat(happy, count: 4)
        let sequence = SKAction.sequence([normalaction, happyaction])
        let redo = SKAction.repeatForever(sequence)
        jo.run(redo)
        
        txtGameOver = SKLabelNode(fontNamed: "Chalkduster")
        txtGameOver.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)-100)
        txtGameOver.zPosition = 2
        addChild(txtGameOver)
        txtGameOver.text = "*** Congratulations ***"
        
        if let bubbles = SKEmitterNode(fileNamed: "particle-Lose"){
            bubbles.particleTexture = SKTexture(imageNamed: "particleStar")
            bubbles.position = jo.position
            addChild(bubbles)}
    }
    
    func run(_ fileName: String){
        run(SKAction.repeat((SKAction.playSoundFileNamed(fileName, waitForCompletion: true)), count: 1))
    }
}

