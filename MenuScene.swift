//
//  Menu.swift
//  Shooter
//
//  Created by Valerie on 02.03.23.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    let startButton1 = SKSpriteNode(imageNamed: "button1")
    let startButton2 = SKSpriteNode(imageNamed: "button2")
    let startButton3 = SKSpriteNode(imageNamed: "button3")
    let startButton4 = SKSpriteNode(imageNamed: "button4")
    let startButton5 = SKSpriteNode(imageNamed: "button5")
    let startButton6 = SKSpriteNode(imageNamed: "button6")
    let startButton7 = SKSpriteNode(imageNamed: "button7")
    let startButton8 = SKSpriteNode(imageNamed: "button8")
    let startButton9 = SKSpriteNode(imageNamed: "button9")
    let startButton10 = SKSpriteNode(imageNamed: "button10")
    let startButton11 = SKSpriteNode(imageNamed: "button11")
    let startButton12 = SKSpriteNode(imageNamed: "button12")
    
    let backgroundImage = SKSpriteNode(imageNamed: "backgroundMenu")
    
    override func didMove(to view: SKView) {
        
        backgroundImage.anchorPoint = CGPointMake(0.5, 0.5)
        backgroundImage.size.height = self.size.height
        backgroundImage.size.width = self.size.width
        backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(backgroundImage)
        
        let buttonTypes = Bundle.main.decode([ButtonType].self, from: "button-types.json")
        
        let button1 = ButtonNode(type: buttonTypes[0])
        //button.name = ""
        button1.position = CGPoint(x: 374, y: 227)
        self.addChild(button1)
        
        let button2 = ButtonNode(type: buttonTypes[1])
        button2.position = CGPoint(x: 465, y: 227)
        self.addChild(button2)
        
        let button3 = ButtonNode(type: buttonTypes[2])
        button3.position = CGPoint(x: 558, y: 227)
        self.addChild(button3)
        
        let button4 = ButtonNode(type: buttonTypes[3])
        button4.position = CGPoint(x: 649, y: 227)
        self.addChild(button4)
       
        let button5 = ButtonNode(type: buttonTypes[4])
        button5.position = CGPoint(x: 374, y: 139)
        self.addChild(button5)
        
        let button6 = ButtonNode(type: buttonTypes[5])
        button6.position = CGPoint(x: 465, y: 139)
        self.addChild(button6)
        
        let button7 = ButtonNode(type: buttonTypes[6])
        button7.position = CGPoint(x: 558, y: 139)
        self.addChild(button7)
        
        let button8 = ButtonNode(type: buttonTypes[7])
        button8.position = CGPoint(x: 649, y: 139)
        self.addChild(button8)
        
        let button9 = ButtonNode(type: buttonTypes[8])
        button9.position = CGPoint(x: 374, y: 53)
        self.addChild(button9)
        
        let button10 = ButtonNode(type: buttonTypes[9])
        button10.position = CGPoint(x: 465, y: 53)
        self.addChild(button10)
        
        let button11 = ButtonNode(type: buttonTypes[10])
        button11.position = CGPoint(x: 558, y: 53)
        self.addChild(button11)
        
        let button12 = ButtonNode(type: buttonTypes[11])
        button12.position = CGPoint(x: 649, y: 53)
        self.addChild(button12)
        
        
        //enemy auslesen
        let enemyTypes = Bundle.main.decode([EnemyType].self, from: "enemy-types.json")
        let enemy = EnemyNode(type: enemyTypes[2], startPosition: CGPoint(x:200, y: 200), xOffset: 100, moveStraight: true)
        addChild(enemy)
        
        // Pulse one of the balloon
        let balloonMenu = SKSpriteNode(imageNamed: "balloonMenu.png")
        //balloonMenu.anchorPoint = CGPointMake(0.5, 0.5)
        balloonMenu.size = CGSize(width: 110, height: 150)
        balloonMenu.position = CGPointMake(233, 175)
        balloonMenu.zPosition = 2
        self.addChild(balloonMenu)
        
        let rotateAction = SKAction.sequence ([
            SKAction.rotate(toAngle: 0.08, duration: 1),
            SKAction.rotate(toAngle: -0.08, duration: 1)])
        balloonMenu.run(SKAction.repeatForever(rotateAction))
        /*
        let pulseAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.0, duration: 1.5),
            SKAction.fadeAlpha(to: 1, duration: 1.5),
        ])
        balloonMenu.run(SKAction.repeatForever(pulseAction))*/
    }
   
        func touchesBegan(touches: Set<NSObject>, withEvent
                          event: UIEvent) {
            for touch in (touches as! Set<UITouch>) {
                let location = touch.location(in: self)
                let nodeTouched = atPoint(location)
                
                if nodeTouched.name == "Start1" {
                    self.view?.presentScene(GameScene(size: self.size))
                }
            }
        }
        
}
