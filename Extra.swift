//
//  Extra.swift
//  Shooter
//
//  Created by Valerie on 03.03.23.
//

import Foundation
import SpriteKit

class Extra: SKScene, SKPhysicsContactDelegate {
    //let restartButton = SKSpriteNode()
    let menuButton = SKSpriteNode()
    
    let centerOfStuff = CGPoint(x: 300,
                                y: 300)
    
    let restartButton = SKSpriteNode(imageNamed: "restartButton.jpg")
    let gomenuButton = SKSpriteNode(imageNamed: "menuClown.jpg")
    
    override func didMove(to view: SKView) {
        
        restartButton.name = "restartGame"
        restartButton.position = centerOfStuff
        restartButton.size = CGSize(width: 140, height: 140)
        
        gomenuButton.name = "returnToMenu"
        gomenuButton.position =
        CGPoint(x: centerOfStuff.x - 140, y: centerOfStuff.y)
        gomenuButton.size = CGSize(width: 70, height: 70)
        
    }
 
    func showButtons() {
        // Set the button alpha to 0:
        restartButton.alpha = 0
        gomenuButton.alpha = 0
        // Add the button nodes to the HUD:
        self.addChild(restartButton)
        self.addChild(gomenuButton)
        // Fade in the buttons:
        let fadeAnimation =
        SKAction.fadeAlpha(to: 1, duration: 0.4)
        restartButton.run(fadeAnimation)
        gomenuButton.run(fadeAnimation)
    }
    
    
}
