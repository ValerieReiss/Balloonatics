//
//  ButtonNode.swift
//  Shooter
//
//  Created by Valerie on 05.03.23.
//

import SpriteKit

class ButtonNode: SKSpriteNode {
    var type: ButtonType
    
    init(type: ButtonType){
        self.type = type
        let texture = SKTexture(imageNamed: type.name)
        super.init(texture: texture, color: UIColor(), size: CGSize(width: 73, height: 73))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("LOL NO")
    }
    
}
