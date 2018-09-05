//
//  GameOverViewController.swift
//  soccerHamster
//
//  Created by michael on 2018/7/23.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

  @IBOutlet weak var centerView: UIView!

  @IBOutlet weak var modeLabel: UILabel!
  @IBOutlet weak var modeTextLabel: UILabel!

  @IBOutlet weak var completeLabel: UILabel!
  @IBOutlet weak var completeTextLabel: UILabel!

  @IBOutlet weak var currentScoreLabel: UILabel!
  @IBOutlet weak var currentScoreTextLabel: UILabel!

  @IBOutlet weak var continueBtn: UIButton!
  @IBAction func continueBtnAction(_ sender: UIButton) {
    self.view.removeFromSuperview()
    self.removeFromParentViewController()
    NotificationCenter.default.post(name: NSNotification.Name("reStartGame"), object: nil)
  }

  // Variable
  var currentScore = 0
  var completeLevel = 1
  let cornerRadius = 24

  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }

  func initView(){
    setLabelText()
  }

  func setLabelText(){
    currentScoreTextLabel.text = "\(currentScore)"
    completeTextLabel.text = "Level \(completeLevel)"
    modeTextLabel.text = currentGameMode.rawValue
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
    

}
