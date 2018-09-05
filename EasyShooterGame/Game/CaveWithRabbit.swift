//
//  cave.swift
//  KingOfSoccerShooter
//
//  Created by michael on 2018/7/30.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit
import SpriteKit

class CaveWithRabbit: SKNode {

  enum ZPosition: CGFloat{
    case score = 10
    case rabbit = 9
    case cave = 8
  }

  var scoreLabel = SKLabelNode()
  var rabbit = SKSpriteNode()
  let cropNode = SKCropNode()

  var isVisible = false
  var isHit = false

  func configuarePositionAt(pos: CGPoint) {
    position = pos

    let cave = SKSpriteNode(imageNamed: "cave")
    cave.zPosition = ZPosition.cave.rawValue
    addChild(cave)

    cropNode.position = CGPoint(x: 0, y: 40)
    cropNode.zPosition = ZPosition.cave.rawValue
    cropNode.maskNode = SKSpriteNode(imageNamed: "block")

    rabbit = SKSpriteNode(imageNamed: "rabbit")
    rabbit.position = CGPoint(x: 0, y: -64)
    rabbit.name = "rabbit"
    rabbit.size.width = 96
    rabbit.size.height = 96
    rabbit.physicsBody = nil

    cropNode.addChild(rabbit)
    addChild(cropNode)
  }

  func show(hideTime: Double){
    if isVisible {return}

    cropNode.zPosition = ZPosition.rabbit.rawValue
    rabbit.run(SKAction.moveBy(x: 0, y: 96, duration: 0.05))
    let wait = SKAction.wait(forDuration: 0.056)
    let physicsAction = SKAction.run {
      let frame = self.rabbit.frame
      self.rabbit.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width, height: frame.height / 3), center: CGPoint(x: 0.5, y: 0.5))
      self.rabbit.physicsBody?.categoryBitMask = PhysicsCategory.rabbit
      self.rabbit.physicsBody?.collisionBitMask = PhysicsCategory.soccer
      self.rabbit.physicsBody?.contactTestBitMask = PhysicsCategory.soccer
      self.rabbit.physicsBody?.affectedByGravity = false
      self.rabbit.physicsBody?.isDynamic = false
    }

    rabbit.run(SKAction.sequence([wait,physicsAction]))

    isVisible = true
    isHit = false
    rabbit.run(changeRabbitSize())
    DispatchQueue.main.asyncAfter(deadline: .now() + hideTime) {
      self.hide()
    }
      
  }

  func hide(){
    if !isVisible {return}

    cropNode.zPosition = ZPosition.cave.rawValue
    rabbit.physicsBody = nil
    rabbit.run(SKAction.moveBy(x: 0, y: -96, duration: 0.05))

    isVisible = false
    rabbit.run(changeRabbitSize())
  }

  func hit(){
    isHit = true
    isVisible = false

    cropNode.zPosition = ZPosition.cave.rawValue
    rabbit.physicsBody = nil
    let delay = SKAction.wait(forDuration: 0.25)
    let hide = SKAction.moveBy(x: 0, y: -96, duration: 0.05)

    rabbit.run(SKAction.sequence([delay, hide, changeRabbitSize()]))
  }

  func changeRabbitSize() -> SKAction{
    if isVisible {
      
      let changeTexture = SKAction.run {
        if self.random() < 6 {
          self.rabbit.texture = SKTexture(imageNamed: "rabbit2")
          self.rabbit.name = "rabbit"
        }else{
          self.rabbit.texture = SKTexture(imageNamed: "carrot2")
          self.rabbit.name = "carrot"
        }
        self.rabbit.size.width = 160
        self.rabbit.size.height = 160

      }
      return changeTexture
    }else{
      let changeTexture = SKAction.run({
        self.rabbit.texture = SKTexture(imageNamed: "rabbit")
        self.rabbit.size.width = 96
        self.rabbit.size.height = 96
      })
      return changeTexture
    }
  }

  func random() -> Int {
    return Int(arc4random() % 10)
  }

  func addScoreLabel(score: Int) {
    let label = SKLabelNode(fontNamed: "AvenirNext-Bold")
    label.fontColor = UIColor.yellow
    label.text = "+ \(score)"
    label.fontSize = 56
    label.position = CGPoint(x: 8, y: 72)
    label.zPosition = ZPosition.score.rawValue

    addChild(label)
    label.run(SKAction.fadeOut(withDuration: 1.2)) {
      label.removeFromParent()
    }
   
  }
}
