//
//  StarNode.swift
//  Balloonatics
//
//  Created by Valerie on 10.03.23.
//

import SpriteKit

class StarNode: SKSpriteNode {
    init(startPosition: CGPoint, moveStraight: Bool){
        
        var startPosition = Int.random(in: 50..<300)
        let texture = SKTexture(imageNamed: "Star")

        super.init(texture: texture, color: UIColor.clear, size: texture.size())

        self.setScale(2)
        self.zPosition = 4
        name = "star"
        physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        //physicsBody?.categoryBitMask = CollisionType.star.rawValue
        physicsBody?.collisionBitMask = CollisionType.player.rawValue
        physicsBody?.contactTestBitMask = CollisionType.player.rawValue
        position = CGPoint(x: 844, y: startPosition)
        configureMovement(moveStraight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("LOL NO")
    }
    
    func configureMovement(_ moveStraight: Bool){
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: -10000, y: 0))
        
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 70)
        let sequence = SKAction.sequence([movement, .removeFromParent()])
        run (sequence)
    }
    
}
