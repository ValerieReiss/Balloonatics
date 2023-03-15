//
//  Menu.swift
//  Shooter
//
//  Created by Valerie on 02.03.23.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    class func newGameScene() -> MenuScene {
        guard let scene = SKScene(fileNamed: "MenuScene") as? MenuScene else {
            print("Failed to load MenuScene.sks")
            abort()
        }
        scene.scaleMode = .aspectFill
        return scene
    }
    
    let backgroundImage = SKSpriteNode(imageNamed: "backgroundMenu")
   
    
    override func didMove(to view: SKView) {
      
        
        backgroundImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        backgroundImage.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundImage.zPosition = -1
        self.addChild(backgroundImage)
        
        let button1 = SKSpriteNode(imageNamed: "button1.jpg")
        button1.name = "button1"
        button1.position = CGPoint(x: 344, y: 227)
        button1.size = CGSize(width: 73, height: 73)
        button1.isUserInteractionEnabled = false
        self.addChild(button1)
        
        let button2 = SKSpriteNode(imageNamed: "button2.jpg")
        button2.name = "button2"
        button2.position = CGPoint(x: 435, y: 227)
        button2.size = CGSize(width: 73, height: 73)
        self.addChild(button2)
  
        let button3 = SKSpriteNode(imageNamed: "button3.jpg")
        button3.name = "button3"
        button3.position = CGPoint(x: 528, y: 227)
        button3.size = CGSize(width: 73, height: 73)
        self.addChild(button3)
   
        let button4 = SKSpriteNode(imageNamed: "button4.jpg")
        button4.name = "button4"
        button4.position = CGPoint(x: 619, y: 227)
        button4.size = CGSize(width: 73, height: 73)
        self.addChild(button4)
    
        let button5 = SKSpriteNode(imageNamed: "button5.jpg")
        button5.name = "button5"
        button5.position = CGPoint(x: 344, y: 139)
        button5.size = CGSize(width: 73, height: 73)
        self.addChild(button5)
      
        let button6 = SKSpriteNode(imageNamed: "button6.jpg")
        button6.name = "button6"
        button6.position = CGPoint(x: 435, y: 139)
        button6.size = CGSize(width: 73, height: 73)
        self.addChild(button6)
    
        let button7 = SKSpriteNode(imageNamed: "button7.jpg")
        button7.name = "button7"
        button7.position = CGPoint(x: 528, y: 139)
        button7.size = CGSize(width: 73, height: 73)
        self.addChild(button7)
    
        let button8 = SKSpriteNode(imageNamed: "button8.jpg")
        button8.name = "button8"
        button8.position = CGPoint(x: 619, y: 139)
        button8.size = CGSize(width: 73, height: 73)
        self.addChild(button8)
      
        let button9 = SKSpriteNode(imageNamed: "button9.jpg")
        button9.name = "button9"
        button9.position = CGPoint(x: 344, y: 53)
        button9.size = CGSize(width: 73, height: 73)
        self.addChild(button9)
   
        let button10 = SKSpriteNode(imageNamed: "button10.jpg")
        button10.name = "button10"
        button10.position = CGPoint(x: 435, y: 53)
        button10.size = CGSize(width: 73, height: 73)
        self.addChild(button10)
    
        let button11 = SKSpriteNode(imageNamed: "button11.jpg")
        button11.name = "button11"
        button11.position = CGPoint(x: 528, y: 53)
        button11.size = CGSize(width: 73, height: 73)
        self.addChild(button11)
      
        let button12 = SKSpriteNode(imageNamed: "button12.jpg")
        button12.name = "button12"
        button12.position = CGPoint(x: 619, y: 53)
        button12.size = CGSize(width: 73, height: 73)
        self.addChild(button12)
     
        
        let balloonMenu = SKSpriteNode(imageNamed: "balloonMenu.png")
        balloonMenu.size = CGSize(width: 110, height: 150)
        balloonMenu.position = CGPoint(x: 100, y: 175)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
                    if nodeTouched.name == "button12" {
                        self.view?.presentScene(GameScene12(size: self.size),
                       transition: .crossFade(withDuration: 2))
                        run("sound-button")
                    } else if nodeTouched.name == "button1" {
                        self.view?.presentScene(GameScene(size: self.size),
                       transition: .crossFade(withDuration: 2))
                        run("sound-button")
                    } else if nodeTouched.name == "button2" {
                        self.view?.presentScene(GameScene2(size: self.size),
                       transition: .crossFade(withDuration: 2))
                        run("sound-button")
                    } else if nodeTouched.name == "button3" {
                        self.view?.presentScene(GameScene3(size: self.size),
                       transition: .crossFade(withDuration: 2))
                        run("sound-button")
                    } else if nodeTouched.name == "button4" {
                        self.view?.presentScene(GameScene4(size: self.size),
                       transition: .crossFade(withDuration: 2))
                        run("sound-button")
                    } else if nodeTouched.name == "button5" {
                        self.view?.presentScene(GameScene5(size: self.size),
                       transition: .crossFade(withDuration: 2))
                        run("sound-button")
                    } else if nodeTouched.name == "button6" {
                        self.view?.presentScene(GameScene6(size: self.size),
                       transition: .crossFade(withDuration: 2))
                        run("sound-button")
                    } else if nodeTouched.name == "button7" {
                        self.view?.presentScene(GameScene7(size: self.size),
                       transition: .crossFade(withDuration: 2))
                        run("sound-button")
                    } else if nodeTouched.name == "button8" {
                        self.view?.presentScene(GameScene8(size: self.size),
                       transition: .crossFade(withDuration: 2))
                        run("sound-button")
                    }else if nodeTouched.name == "button9" {
                        self.view?.presentScene(GameScene9(size: self.size),
                       transition: .crossFade(withDuration: 2))
                        run("sound-button")
                    } else if nodeTouched.name == "button10" {
                        self.view?.presentScene(GameScene10(size: self.size),
                       transition: .crossFade(withDuration: 2))
                        run("sound-button")
                    } else if nodeTouched.name == "button11" {
                        self.view?.presentScene(GameScene11(size: self.size),
                       transition: .crossFade(withDuration: 2))
                        run("sound-button")
                    }
            
           }
    }
    
    func run(_ fileName: String){
            run(SKAction.playSoundFileNamed(fileName, waitForCompletion: true))
        
    }
    
}
