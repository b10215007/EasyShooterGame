//
//  GameViewController.swift
//  KingOfSoccerShooter
//
//  Created by michael on 2018/7/29.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

  @objc func homeBtnAction(_ sender: UIButton) {
    self.navigationController?.popToRootViewController(animated: false)
  }

  @objc func pauseBtnAction(_ sender: UIButton) {
    NotificationCenter.default.post(name: Notification.Name("pause"), object: nil)
    downTimer.invalidate()
    downTimer = nil
    addPauseView()
  }

  @objc func functionBtnAction(_ sender: UIButton) {
    let functionVC = FunctionViewController()
    functionVC.viewPushedByGame = true
    self.navigationController?.pushViewController(functionVC, animated: false)
  }

  let topView = TopGameView()
  let bottomView = BottomTimeView()

  var level = 5
  var scoreValue = 0 {
    didSet{
      topView.scoreTextLabel.text = "\(scoreValue)"
    }
  }
  @objc func Score(){
    scoreValue += level
    if scoreValue % 7 == 0 {
      level += 1
    }
  }

  var restOfGameTime = gameTime{
    didSet{
      bottomView.timeImageTrailingConstraint.constant -= self.view.frame.width / CGFloat(gameTime)
      if abs(bottomView.timeImageTrailingConstraint.constant) > 32 {
        bottomView.timeTextLabel.textColor = UIColor.black
      }else{
        bottomView.timeTextLabel.textColor = UIColor.white
      }
      bottomView.timeTextLabel.text = "\(restOfGameTime)s"
    }
  }
  var downTimer: Timer!
  var countDown3Timer: Timer!
  let scene = GKScene(fileNamed: "GameScene")!
  var gameScene: GameScene!

  override func viewDidLoad() {
    super.viewDidLoad()

    addGameScene()
    initView()
    NotificationCenter.default.addObserver(self, selector: #selector(initGameVC), name: NSNotification.Name("reStartGame"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(Score), name: NSNotification.Name("score"), object: nil)
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func initView(){
    initTopView()
    initBottomTimeView()
    initGameVC()
  }

  func initTopView(){
    topView.backgroundColor = UIColor.clear
    topView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(topView)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: topView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 8))
    constraints.append(NSLayoutConstraint(item: topView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: topView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: topView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 64))

    NSLayoutConstraint.activate(constraints)

    topView.homeButton.addTarget(self, action: #selector(homeBtnAction(_:)), for: .touchUpInside)
    topView.pauseButton.addTarget(self, action: #selector(pauseBtnAction(_:)), for: .touchUpInside)
    topView.functionButton.addTarget(self, action: #selector(functionBtnAction(_:)), for: .touchUpInside)
  }

  func initBottomTimeView(){
    bottomView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bottomView)

    var constraints = [NSLayoutConstraint]()
    if screenHeight > 500{
      constraints.append(NSLayoutConstraint(item: bottomView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -32))
    }else{
      constraints.append(NSLayoutConstraint(item: bottomView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
    }
    constraints.append(NSLayoutConstraint(item: bottomView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: bottomView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
    if screenHeight < 500 {
      constraints.append(NSLayoutConstraint(item: bottomView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 24))
    }else{
      constraints.append(NSLayoutConstraint(item: bottomView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40))
    }

    NSLayoutConstraint.activate(constraints)
  }

  func addGameScene(){
    gameScene = scene.rootNode as! GameScene
    gameScene.scaleMode = .aspectFill

    if let view = self.view as! SKView? {
      view.presentScene(gameScene)

      view.ignoresSiblingOrder = true
      view.showsPhysics = false
      view.showsFPS = false
      view.showsNodeCount = false
    }
  }

  func addPauseView(){
    let pauseView = PauseView()
    pauseView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(pauseView)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: pauseView, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: pauseView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: pauseView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: pauseView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))

    NSLayoutConstraint.activate(constraints)
    countDownFive(view: pauseView)
  }

  @objc func initGameVC(){
    gameScene.hits = 0
    gameScene.level = 5
    gameScene.fireTimer()
    scoreValue = 0
    level = 5
    restOfGameTime = gameTime
    topView.pauseButton.isUserInteractionEnabled = true
    bottomView.timeImageTrailingConstraint.constant = 0
    timerCountDown()
  }

  func timerCountDown(){
    if(self.downTimer == nil){
      self.downTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown(timer:)), userInfo: nil, repeats: true)
    }
  }

  @objc func countDown(timer : Timer) {
    self.restOfGameTime -= 1

    if self.restOfGameTime <= 0{
      self.setCountDownTimerToNil()
      self.gameOver()
    }
  }

  func setCountDownTimerToNil(){
    if downTimer != nil {
      downTimer.invalidate()
      downTimer = nil
    }
  }

  func countDownFive(view: PauseView){
    var i = 8

    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
      if i == 0 {
        NotificationCenter.default.post(name: Notification.Name("resume"), object: nil)
        self.timerCountDown()
        view.removeFromSuperview()
        timer.invalidate()
      }
      view.label.text = "\(i)"
      view.label.scale()
      i -= 1
    }

  }

  func gameOver(){
    saveRecord()
    topView.pauseButton.isUserInteractionEnabled = false
    NotificationCenter.default.post(name: Notification.Name("pause"), object: nil)
    self.callGameOverView()
  }

  func callGameOverView(){
    let gameOverView = GameOverView()

    gameOverView.modeTextLabel.text = currentGameMode.rawValue
    gameOverView.currentScoreTextLabel.text = "\(scoreValue)"

    gameOverView.backgroundColor = UIColor.clear
    gameOverView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(gameOverView)

    var contraints = [NSLayoutConstraint]()
    contraints.append(NSLayoutConstraint(item: gameOverView, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1, constant: 0))
    contraints.append(NSLayoutConstraint(item: gameOverView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
    contraints.append(NSLayoutConstraint(item: gameOverView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
    contraints.append(NSLayoutConstraint(item: gameOverView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
    
    NSLayoutConstraint.activate(contraints)
  }

  func saveRecord(){
    switch currentGameMode {
    case .Easy:
      if var array = UserInfoManager.getArray(key: UserInfoKey.easyRecord) as? [Int] {
        array.append(scoreValue)
        array.sort(by:>)
        UserInfoManager.setArray(array: array, key: UserInfoKey.easyRecord)
      }else{
        var array: [Int] = []
        array.append(scoreValue)
        UserInfoManager.setArray(array: array, key: UserInfoKey.easyRecord)
      }
    case .Normal:
      if var array = UserInfoManager.getArray(key: UserInfoKey.normalRecord) as? [Int] {
        array.append(scoreValue)
        array.sort(by:>)
        UserInfoManager.setArray(array: array, key: UserInfoKey.normalRecord)
      }else{
        var array: [Int] = []
        array.append(scoreValue)
        UserInfoManager.setArray(array: array, key: UserInfoKey.normalRecord)
      }
    case .Hard:
      if var array = UserInfoManager.getArray(key: UserInfoKey.hardRecord) as? [Int] {
        array.append(scoreValue)
        array.sort(by:>)
        UserInfoManager.setArray(array: array, key: UserInfoKey.hardRecord)
      }else{
        var array: [Int] = []
        array.append(scoreValue)
        UserInfoManager.setArray(array: array, key: UserInfoKey.hardRecord)
      }
    }
  }

  override var shouldAutorotate: Bool {
    return false
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }

  override var prefersStatusBarHidden: Bool {
    return true
  }
}
