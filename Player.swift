//
//  Player.swift
//  Balloonatics
//
//  Created by Valerie on 08.03.23.
//

import Foundation
import SpriteKit

struct PhysicsCategory {
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Player       : UInt32 = 0b1       // 1
    static let Enemy        : UInt32 = 0b10      // 2
}

class Player: SKSpriteNode{

init(){

    let texture = SKTexture(imageNamed: "playerJo")

    super.init(texture: texture, color: UIColor.clear, size: texture.size())

    self.xScale = 1
    self.yScale = 1
    self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    self.zPosition = 1

    let body:SKPhysicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0, size: texture.size() )

    
    self.physicsBody = body
    self.physicsBody?.allowsRotation = false
    self.physicsBody?.isDynamic = true
    self.physicsBody?.affectedByGravity = true
    self.physicsBody?.categoryBitMask = PhysicsCategory.Player
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
}

func boundsCheckPlayer(playableArea: CGRect){
    let bottomLeft = CGPoint(x: 0, y: CGRectGetMinY(playableArea))
    let topRight = CGPoint(x: playableArea.size.width, y: CGRectGetMaxY(playableArea))

    if(self.position.x <= bottomLeft.x){
        self.position.x = bottomLeft.x
        // velocity.x = -velocity.x
    }

    if(self.position.x >= topRight.x){
        self.position.x = topRight.x
        // velocity.x = -velocity.x
    }

    if(self.position.y <= bottomLeft.y){
        self.position.y = bottomLeft.y
        // velocity.y = -velocity.y
    }

    if(self.position.y >= topRight.y){
        self.position.y = topRight.y
        // velocity.y = -velocity.y
    }
}

func movePlayerBy(dxVectorValue: CGFloat, dyVectorValue: CGFloat, duration: TimeInterval)->(){

    print("move player")
    let moveActionVector = CGVectorMake(dxVectorValue, dyVectorValue)
    let movePlayerAction = SKAction.applyForce(moveActionVector, duration: 0.5/duration)
    self.run(movePlayerAction)
}

func stopMoving() {
    let delayTime: TimeInterval = 0.5  // 0.5 second pause
    let stopAction: SKAction = SKAction.run{
        self.physicsBody?.velocity = CGVectorMake(0, 0)
    }
    let pause: SKAction = SKAction.wait(forDuration: delayTime)
    let stopSequence: SKAction = SKAction.sequence([pause,stopAction])
    self.run(stopSequence)
}

}
