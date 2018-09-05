//
//  GameScene.swift
//  KingOfSoccerShooter
//
//  Created by michael on 2018/7/29.
//  Copyright © 2018年 michael. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
  static let none: UInt32 = 0x1 << 0
  static let floor: UInt32 = 0x1 << 1
  static let soccer: UInt32 = 0x1 << 2
  static let rabbit: UInt32 = 0x1 << 3
}

class GameScene: SKScene {

  struct TouchBallPoint {
    static var start = CGPoint.zero
    static var end = CGPoint.zero

    static func reset(){
      start = .zero
      end = .zero
    }
  }

  struct TouchDuration {
    static var start = 0.0
    static var end = 0.0

    static func reset(){
      start = 0
      end = 0
    }
  }

  struct zPositionCategory {
    static let floor: CGFloat = 10
    static let soccer: CGFloat = 12
    static let wolf: CGFloat = 15
  }

  enum GameStatus {
    case newBall
    case touchBall
    case flying
    case hit
    case removeBall
  }

  private var backgroundNode = SKSpriteNode()
  private var floor = SKSpriteNode()
  private var soccer = SKShapeNode()

  let soundManager = SoundManager.shared()
  var currentGameStatus = GameStatus.newBall

  var characters: [CaveWithRabbit] = []

  var showUpTimer: Timer!
  var hits = 0 {
    didSet{
      if hits % 7 == 0{
        level += 1
      }
      NotificationCenter.default.post(name: NSNotification.Name("score"), object: nil)
    }
  }
  var level = 5

  override func sceneDidLoad() {
    physicsWorld.contactDelegate = self

    createScene()
    newBall()

    fireTimer()
    NotificationCenter.default.addObserver(self, selector: #selector(pauseTimer), name: NSNotification.Name("pause"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(fireTimer), name: NSNotification.Name("resume"), object: nil)
  }

  deinit {
    if showUpTimer != nil {
      showUpTimer = nil
    }

    NotificationCenter.default.removeObserver(self)
  }

  @objc func pauseTimer(){
    if showUpTimer != nil{
      showUpTimer.invalidate()
      showUpTimer = nil
    }
  }
  
  @objc func fireTimer(){
    if showUpTimer == nil {
      showUpTimer = Timer.scheduledTimer(withTimeInterval: hideTime, repeats: true) { (timer) in
        self.showUp()
      }
    }else{
      showUpTimer.fire()
    }
  }

  func createScene(){
    backgroundNode = self.childNode(withName: "background") as! SKSpriteNode
    backgroundNode.texture = SKTexture(image: #imageLiteral(resourceName: "bg"))

    floor = self.childNode(withName: "floor") as! SKSpriteNode
    floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
    floor.physicsBody?.categoryBitMask = PhysicsCategory.floor
    floor.physicsBody?.collisionBitMask = PhysicsCategory.soccer
    floor.physicsBody?.affectedByGravity = false
    floor.physicsBody?.isDynamic = false

    for i in 0...2 {createCracterAt(position: CGPoint(x: -230 + (i * 220), y: 280))}
    for i in 0...2 {createCracterAt(position: CGPoint(x: -230 + (i * 220), y: 80))}
    for i in 0...2 {createCracterAt(position: CGPoint(x: -230 + (i * 220), y: -120))}
  }

  func createCracterAt(position: CGPoint){
    let rabbit = CaveWithRabbit()
    rabbit.configuarePositionAt(pos: position)
    addChild(rabbit)
    characters.append(rabbit)
  }

  func newBall(){

    currentGameStatus = .newBall
    soccer.removeFromParent()

    let soccerNode = SKSpriteNode(imageNamed: "soccer")
    soccerNode.size.width = 88
    soccerNode.size.height = 88

    let circleRadius = soccerNode.frame.width / 2
    soccer = SKShapeNode(circleOfRadius: circleRadius)
    soccer.position = CGPoint(x: -10, y: -330)
    soccer.zPosition = zPositionCategory.soccer
    soccer.name = "soccer"
    soccer.physicsBody = SKPhysicsBody(circleOfRadius: circleRadius)
    soccer.physicsBody?.categoryBitMask = PhysicsCategory.soccer
    soccer.physicsBody?.collisionBitMask = PhysicsCategory.floor
    soccer.physicsBody?.contactTestBitMask = PhysicsCategory.rabbit
    soccer.physicsBody?.friction = 0      //摩擦力
    soccer.physicsBody?.restitution = 0   //彈力
    soccer.physicsBody?.isDynamic = true
    soccer.physicsBody?.affectedByGravity = true

    soccer.addChild(soccerNode)
    self.addChild(soccer)
  }

  func showUp(){
    let count = characters.count
    for _ in 0...2 {
      let random = Int(arc4random_uniform(UInt32(count)))
      characters[random].show(hideTime: hideTime)
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches{
      let location = touch.location(in: self)
      if soccer.contains(location) {
        currentGameStatus = .touchBall

        TouchBallPoint.start = location
        TouchDuration.start = Date().timeIntervalSince1970
      }
    }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let location = touch.location(in: self)
      if currentGameStatus == .touchBall {
        TouchBallPoint.end = location
        TouchDuration.end = Date().timeIntervalSince1970

        ballMove()
      }
    }
  }

  func ballMove(){
    var dx = (TouchBallPoint.end.x - TouchBallPoint.start.x) / 2.5
    let dy = (TouchBallPoint.end.y - TouchBallPoint.start.y)
    if dx == 0 {dx = 0.000001}
    let theta = atan2(dy, dx)
    let time = TouchDuration.end - TouchDuration.start + 0.56
    let velocity = sqrt(pow(dx, 2) + pow(dy, 2)) / CGFloat(time)
    let velocityVector = CGVector(dx: velocity * cos(theta), dy: velocity * sin(theta))
    soccer.physicsBody?.applyImpulse(velocityVector, at: floor.position)
    currentGameStatus = .flying

    let flyTime:Double = 1
    let scale = 0.8
    soccer.run(SKAction.scale(by: CGFloat(scale), duration: flyTime))

    //change BitMask when flying
    let wait = SKAction.wait(forDuration: flyTime / 2)
    let change = SKAction.run {
      self.floor.physicsBody?.collisionBitMask = PhysicsCategory.none
      self.soccer.physicsBody?.collisionBitMask = PhysicsCategory.rabbit | PhysicsCategory.floor
    }
    let finish = SKAction.run {
      self.soccer.physicsBody?.collisionBitMask = PhysicsCategory.floor
    }
    self.run(SKAction.sequence([wait,change,wait,finish]))
  }

  func wolfShowUp(){
    soundManager.playSoundEffectWith(soundType: .wolf)
    let wolf = SKSpriteNode(imageNamed: "wolf")
    wolf.position = CGPoint(x: 330, y: -330)
    wolf.zPosition = zPositionCategory.wolf
    wolf.size = CGSize(width: 330, height: 330)
    self.addChild(wolf)

    let move = SKAction.moveTo(x: -400, duration: 5)
    wolf.run(move) {
      wolf.removeFromParent()
    }
  }

  //check if flying outside
  override func update(_ currentTime: TimeInterval) {
    if currentGameStatus == .flying {
      if soccer.position.x > 320 || soccer.position.x < -320 || soccer.position.y > 640 || soccer.position.y < -640{
        newBall()
      }
    }
  }

}

extension GameScene: SKPhysicsContactDelegate {

  func didEnd(_ contact: SKPhysicsContact) {
    var firstBody: SKPhysicsBody //soccer
    var secondBody: SKPhysicsBody //character

    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
      firstBody = contact.bodyA
      secondBody = contact.bodyB
    }else {
      firstBody = contact.bodyB
      secondBody = contact.bodyA
    }

    if firstBody.categoryBitMask == PhysicsCategory.soccer && secondBody.categoryBitMask == PhysicsCategory.rabbit{
      let rabbit = secondBody.node?.parent?.parent as! CaveWithRabbit

      if rabbit.rabbit.name == "carrot" {
        soundManager.playSoundEffectWith(soundType: .hitSoundEffetct)
        rabbit.addScoreLabel(score: 0)
        newBall()
        return
      }
      if !rabbit.isVisible {return}
      if rabbit.isHit {return}
      rabbit.hit()

      rabbit.addScoreLabel(score: level)
      soundManager.playSoundEffectWith(soundType: .score)
      currentGameStatus = .hit
      hits += 1
      newBall()
    }
  }
}
