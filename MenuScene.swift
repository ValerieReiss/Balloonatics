//
//  Menu.swift
//  Shooter
//
//  Created by Valerie on 02.03.23.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    let backgroundImage = SKSpriteNode(imageNamed: "backgroundMenu")
    
    override func didMove(to view: SKView) {
        backgroundImage.anchorPoint = CGPointMake(0.5, 0.5)
        backgroundImage.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(backgroundImage)
        
        let button1 = SKSpriteNode(imageNamed: "button1.jpg")
        button1.position = CGPoint(x: 374, y: 227)
        button1.size = CGSize(width: 73, height: 73)
        self.addChild(button1)
        
        let but0 = UIButton(type: UIButton.ButtonType.system) as UIButton
        but0.frame = CGRect(x:338, y:125, width:73, height:73)
        but0.backgroundColor = UIColor.white
        but0.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.view?.addSubview(but0)
        
        let button2 = SKSpriteNode(imageNamed: "button2.jpg")
        button2.position = CGPoint(x: 465, y: 227)
        button2.size = CGSize(width: 73, height: 73)
        self.addChild(button2)
        
        let but1 = UIButton(type: UIButton.ButtonType.system) as UIButton
        but1.frame = CGRect(x:430, y:125, width:73, height:73)
        but1.backgroundColor = UIColor.white
        but1.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.view?.addSubview(but1)
        
        let button3 = SKSpriteNode(imageNamed: "button3.jpg")
        button3.position = CGPoint(x: 558, y: 227)
        button3.size = CGSize(width: 73, height: 73)
        self.addChild(button3)
        
        let but2 = UIButton(type: UIButton.ButtonType.system) as UIButton
        but2.frame = CGRect(x:522, y:125, width:73, height:73)
        but2.backgroundColor = UIColor.white
        but2.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.view?.addSubview(but2)
        
        let button4 = SKSpriteNode(imageNamed: "button4.jpg")
        button4.position = CGPoint(x: 649, y: 227)
        button4.size = CGSize(width: 73, height: 73)
        self.addChild(button4)
       
        let but3 = UIButton(type: UIButton.ButtonType.system) as UIButton
        but3.frame = CGRect(x:614, y:125, width:73, height:73)
        but3.backgroundColor = UIColor.white
        but3.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.view?.addSubview(but3)
        
        let button5 = SKSpriteNode(imageNamed: "button5.jpg")
        button5.position = CGPoint(x: 374, y: 139)
        button5.size = CGSize(width: 73, height: 73)
        self.addChild(button5)
        
        let but4 = UIButton(type: UIButton.ButtonType.system) as UIButton
        but4.frame = CGRect(x:338, y:215, width:73, height:73)
        but4.backgroundColor = UIColor.white
        but4.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.view?.addSubview(but4)
        
        let button6 = SKSpriteNode(imageNamed: "button6.jpg")
        button6.position = CGPoint(x: 465, y: 139)
        button6.size = CGSize(width: 73, height: 73)
        self.addChild(button6)
        
        let but5 = UIButton(type: UIButton.ButtonType.system) as UIButton
        but5.frame = CGRect(x:430, y:215, width:73, height:73)
        but5.backgroundColor = UIColor.white
        but5.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.view?.addSubview(but5)
        
        let button7 = SKSpriteNode(imageNamed: "button7.jpg")
        button7.position = CGPoint(x: 558, y: 139)
        button7.size = CGSize(width: 73, height: 73)
        self.addChild(button7)
        
        let but6 = UIButton(type: UIButton.ButtonType.system) as UIButton
        but6.frame = CGRect(x:522, y:215, width:73, height:73)
        but6.backgroundColor = UIColor.white
        but6.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.view?.addSubview(but6)
        
        let button8 = SKSpriteNode(imageNamed: "button8.jpg")
        button8.position = CGPoint(x: 649, y: 139)
        button8.size = CGSize(width: 73, height: 73)
        self.addChild(button8)
        
        let but7 = UIButton(type: UIButton.ButtonType.system) as UIButton
        but7.frame = CGRect(x:614, y:215, width:73, height:73)
        but7.backgroundColor = UIColor.white
        but7.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.view?.addSubview(but7)
        
        let button9 = SKSpriteNode(imageNamed: "button9.jpg")
        button9.position = CGPoint(x: 374, y: 53)
        button9.size = CGSize(width: 73, height: 73)
        self.addChild(button9)
        
        let but8 = UIButton(type: UIButton.ButtonType.system) as UIButton
        but8.frame = CGRect(x:338, y:300, width:73, height:73)
        but8.backgroundColor = UIColor.white
        but8.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.view?.addSubview(but8)
        
        let button10 = SKSpriteNode(imageNamed: "button10.jpg")
        button10.position = CGPoint(x: 465, y: 53)
        button10.size = CGSize(width: 73, height: 73)
        self.addChild(button10)
        
        let but9 = UIButton(type: UIButton.ButtonType.system) as UIButton
        but9.frame = CGRect(x:430, y:300, width:73, height:73)
        but9.backgroundColor = UIColor.white
        but9.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.view?.addSubview(but9)
        
        let button11 = SKSpriteNode(imageNamed: "button11.jpg")
        button11.position = CGPoint(x: 558, y: 53)
        button11.size = CGSize(width: 73, height: 73)
        self.addChild(button11)
        
        let but10 = UIButton(type: UIButton.ButtonType.system) as UIButton
        but10.frame = CGRect(x:522, y:300, width:73, height:73)
        but10.backgroundColor = UIColor.white
        but10.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.view?.addSubview(but10)
        
        let button12 = SKSpriteNode(imageNamed: "button12.jpg")
        button12.position = CGPoint(x: 649, y: 53)
        button12.size = CGSize(width: 73, height: 73)
        self.addChild(button12)
        
        let but11 = UIButton(type: UIButton.ButtonType.system) as UIButton
        but11.frame = CGRect(x:614, y:300, width:73, height:73)
        but11.backgroundColor = UIColor.white
        but11.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.view?.addSubview(but11)
        
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
    
    @objc func buttonAction(_ sender:UIButton!)
        {
            print("Button tapped")
            
            //muss buttons wegkriegen..
            //self.view?.removefromView(but8)
            
            if let view = self.view {
                if let scene = GameScene11(fileNamed: "GameScene11") {
                    view.presentScene(scene)
                }
            }
        }
    
}
