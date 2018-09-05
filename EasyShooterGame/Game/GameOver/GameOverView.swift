//
//  GameOverView.swift
//  RabbitShooter
//
//  Created by michael on 2018/8/22.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class GameOverView: UIView {

  let blackImage = UIImageView()
  let centerView = UIView()
  let centerImage = UIImageView()

  let modeLabel = UILabel()
  let modeTextLabel = UILabel()

  let crossLine = UIImageView()

  let currentScoreLabel = UILabel()
  let currentScoreTextLabel = UILabel()

  let continueButton = UIButton()

  let textArray = ["Mode", "Score", "Again"]
  let topMarginBetween = CGFloat(12)
  let topMarginAround = CGFloat(25)
  let font = UIFont.systemFont(ofSize: 28, weight: .medium)
  let bigFont = UIFont.systemFont(ofSize: 50, weight: .medium)
  let colorManager = ColorManager.shared()

  override init(frame: CGRect) {
    super.init(frame: frame)
    initView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func initView(){
    initCenterView()
    initAllLabel()
    initBackButton()
  }

  func initCenterView(){
    blackImage.backgroundColor = UIColor.black
    blackImage.alpha = 0.7
    blackImage.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(blackImage)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: blackImage, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: blackImage, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: blackImage, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: blackImage, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))

    centerView.backgroundColor = UIColor.clear
    centerView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(centerView)

    constraints.append(NSLayoutConstraint(item: centerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.88, constant: 0))
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 300))

    NSLayoutConstraint.activate(constraints)
  }

  func initAllLabel(){
    modeLabel.text = textArray[0]
    modeLabel.textColor = UIColor.yellow
    modeLabel.font = font
    modeLabel.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(modeLabel)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: modeLabel, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: modeLabel, attribute: .centerY, relatedBy: .equal, toItem: centerView, attribute: .centerY, multiplier: 0.16, constant: 0))

    modeTextLabel.text = "Easy"
    modeTextLabel.textColor = UIColor.white
    modeTextLabel.font = bigFont
    modeTextLabel.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(modeTextLabel)

    constraints.append(NSLayoutConstraint(item: modeTextLabel, attribute: .centerX, relatedBy: .equal, toItem: modeLabel, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: modeTextLabel, attribute: .top, relatedBy: .equal, toItem: modeLabel, attribute: .bottom, multiplier: 1, constant: topMarginBetween))

    crossLine.image = #imageLiteral(resourceName: "line")
    crossLine.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(crossLine)

    constraints.append(NSLayoutConstraint(item: crossLine, attribute: .centerX, relatedBy: .equal, toItem: modeLabel, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: crossLine, attribute: .top, relatedBy: .equal, toItem: modeTextLabel, attribute: .bottom, multiplier: 1, constant: topMarginBetween))
    constraints.append(NSLayoutConstraint(item: crossLine, attribute: .width, relatedBy: .equal, toItem: centerView, attribute: .width, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: crossLine, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 8))

    currentScoreLabel.text = textArray[1]
    currentScoreLabel.textColor = UIColor.yellow
    currentScoreLabel.font = font
    currentScoreLabel.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(currentScoreLabel)

    constraints.append(NSLayoutConstraint(item: currentScoreLabel, attribute: .centerX, relatedBy: .equal, toItem: modeLabel, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: currentScoreLabel, attribute: .top, relatedBy: .equal, toItem: crossLine, attribute: .bottom, multiplier: 1, constant: topMarginAround))

    currentScoreTextLabel.text = "0"
    currentScoreTextLabel.textColor = UIColor.white
    currentScoreTextLabel.font = bigFont
    currentScoreTextLabel.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(currentScoreTextLabel)

    constraints.append(NSLayoutConstraint(item: currentScoreTextLabel, attribute: .centerX, relatedBy: .equal, toItem: modeLabel, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: currentScoreTextLabel, attribute: .top, relatedBy: .equal, toItem: currentScoreLabel, attribute: .bottom, multiplier: 1, constant: topMarginBetween))

    NSLayoutConstraint.activate(constraints)
  }

  func initBackButton() {
    continueButton.setTitle(textArray[2], for: .normal)
    continueButton.titleLabel?.font = font
    continueButton.setTitleColor(UIColor.white, for: .normal)
    continueButton.setBackgroundImage(#imageLiteral(resourceName: "button_green"), for: .normal)
    continueButton.addTarget(self, action: #selector(continueButtonAction(_:)), for: .touchUpInside)
    continueButton.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(continueButton)

    var constraints = [NSLayoutConstraint]()

    constraints.append(NSLayoutConstraint(item: continueButton, attribute: .centerX, relatedBy: .equal, toItem: modeLabel, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: continueButton, attribute: .top, relatedBy: .equal, toItem: currentScoreTextLabel, attribute: .bottom, multiplier: 1, constant: topMarginAround))
    constraints.append(NSLayoutConstraint(item: continueButton, attribute: .width, relatedBy: .equal, toItem: centerView, attribute: .width, multiplier: 0.64, constant: 0))
    constraints.append(NSLayoutConstraint(item: continueButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 56))

    NSLayoutConstraint.activate(constraints)
  }

  @objc func continueButtonAction(_ sender: UIButton) {
    self.removeFromSuperview()
    NotificationCenter.default.post(name: NSNotification.Name("reStartGame"), object: nil)
  }

}
