
//  EnemyNode.swift
//  Balloonatics
//
//  Created by Valerie on 26.02.23.
//

import SpriteKit

class EnemyNode: SKSpriteNode {
    var type: EnemyType
    
    init(type: EnemyType, startPosition: CGPoint, xOffset: CGFloat, moveStraight: Bool){
        self.type = type
        
        let texture = SKTexture(imageNamed: type.name)
        super.init(texture: texture, color: .white, size: texture.size())
        name = "enemy"
        physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.categoryBitMask = CollisionType.enemy.rawValue
        self.physicsBody?.collisionBitMask = CollisionType.player.rawValue
        self.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
        position = CGPoint(x: 844 + xOffset, y: startPosition.y)
        self.zRotation = self.zRotation + 90
        configureMovement(moveStraight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("LOL NO")
    }
    
    func configureMovement(_ moveStraight: Bool){
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: -10000, y: 0))
        
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: type.speed)
        let sequence = SKAction.sequence([movement, .removeFromParent()])
        run (sequence)
    }
    
}
