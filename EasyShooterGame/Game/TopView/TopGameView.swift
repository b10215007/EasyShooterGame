//
//  GameTopView.swift
//  RabbitShooter
//
//  Created by michael on 2018/8/22.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class TopGameView: UIView {

  let backgroundImage = UIImageView()
  let homeButton = UIButton()
  let functionButton = UIButton()
  let pauseButton = UIButton()
  let scoreTextLabel = UILabel()
  let centerImage = UIImageView()

  let colorManager = ColorManager.shared()

  override init(frame: CGRect) {
    super.init(frame: frame)
    initView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func initView(){
    initBackground()
    initScoreView()
    initButton()
  }

  func initBackground(){
    backgroundImage.backgroundColor = colorManager?.mainColor
    backgroundImage.alpha = 0.7
    backgroundImage.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(backgroundImage)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: backgroundImage, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: backgroundImage, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: backgroundImage, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: backgroundImage, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    NSLayoutConstraint.activate(constraints)
  }

  func initScoreView(){
    centerImage.image = #imageLiteral(resourceName: "button_white")
    centerImage.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(centerImage)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: centerImage, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 0.88, constant: 0))
    constraints.append(NSLayoutConstraint(item: centerImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: centerImage, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.4, constant: 0))
    constraints.append(NSLayoutConstraint(item: centerImage, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.64, constant: 0))

    scoreTextLabel.text = "\(0)"
    scoreTextLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    scoreTextLabel.textColor = UIColor.black
    scoreTextLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(scoreTextLabel)

    constraints.append(NSLayoutConstraint(item: scoreTextLabel, attribute: .centerX, relatedBy: .equal, toItem: centerImage, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: scoreTextLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

    NSLayoutConstraint.activate(constraints)
  }

  func initButton(){
    homeButton.setBackgroundImage(#imageLiteral(resourceName: "home"), for: .normal)
    homeButton.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(homeButton)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: homeButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: homeButton, attribute: .trailing, relatedBy: .equal, toItem: centerImage, attribute: .leading, multiplier: 1, constant: -16))
    constraints.append(NSLayoutConstraint(item: homeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 40))
    constraints.append(NSLayoutConstraint(item: homeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40))

    pauseButton.setBackgroundImage(#imageLiteral(resourceName: "pause"), for: .normal)
    pauseButton.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(pauseButton)

    constraints.append(NSLayoutConstraint(item: pauseButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: pauseButton, attribute: .leading, relatedBy: .equal, toItem: centerImage, attribute: .trailing, multiplier: 1, constant: 16))
    constraints.append(NSLayoutConstraint(item: pauseButton, attribute: .width, relatedBy: .equal, toItem: homeButton, attribute: .width, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: pauseButton, attribute: .height, relatedBy: .equal, toItem: homeButton, attribute: .height, multiplier: 1, constant: 0))


    functionButton.setBackgroundImage(#imageLiteral(resourceName: "setting"), for: .normal)
    functionButton.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(functionButton)

    constraints.append(NSLayoutConstraint(item: functionButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: functionButton, attribute: .leading, relatedBy: .equal, toItem: pauseButton, attribute: .trailing, multiplier: 1, constant: 16))
    constraints.append(NSLayoutConstraint(item: functionButton, attribute: .width, relatedBy: .equal, toItem: homeButton, attribute: .width, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: functionButton, attribute: .height, relatedBy: .equal, toItem: homeButton, attribute: .height, multiplier: 1, constant: 0))


    NSLayoutConstraint.activate(constraints)
  }

  @objc func functionButtonAction(_ sender: UIButton) {
    let functionVC = FunctionViewController()
    functionVC.viewPushedByGame = true
  }
}
