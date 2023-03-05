//
// GameSceneNode.swift
//  Balloonatics
//
//  Created by Valerie on 26.02.23.
//

import SpriteKit

class GameSceneNode: SKSpriteNode {
    var type: GameSceneType
    
    init(type: GameSceneType){
        self.type = type
        let texture = SKTexture(imageNamed: type.name)
        //super.init(texture: texture, color: .white, size: texture.size())
        super.init(texture: texture, color: UIColor(), size: CGSize(width: 100, height: 100))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("LOL NO")
    }
    
}
