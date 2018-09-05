//
//  HowToPlayView.swift
//  RabbitShooter
//
//  Created by michael on 2018/8/26.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class HowToPlayView: UIView {

  let bgImage = UIImageView()
  let centerView = UIView()
  let textLabel = UILabel()
  let textLabel2 = UILabel()
  let backBtn = UIButton()

  var textArray = ["This is a easyGame."," move the soccer to hit the enmy"]

  var font = UIFont.systemFont(ofSize: 16, weight: .medium)
  var viewHight = CGFloat(480)

  override init(frame: CGRect) {
    super.init(frame: frame)

    if screenHeight < 500 {
      font = UIFont.systemFont(ofSize: 12, weight: .medium)
      viewHight = 400
    }

    initView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func initView() {
    initCenterView()
    initLabel()
    initBtn()
  }

  func initCenterView(){
    centerView.backgroundColor = UIColor.clear
    self.addSubview(centerView)
    centerView.translatesAutoresizingMaskIntoConstraints = false
    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: viewHight))
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

    let infoBg = UIImageView()
    infoBg.image = #imageLiteral(resourceName: "rectangle_yellow_green")
    infoBg.alpha = 0.9
    infoBg.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(infoBg)

    constraints.append(NSLayoutConstraint(item: infoBg, attribute: .top, relatedBy: .equal, toItem: centerView, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: infoBg, attribute: .bottom, relatedBy: .equal, toItem: centerView, attribute: .bottom, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: infoBg, attribute: .trailing, relatedBy: .equal, toItem: centerView, attribute: .trailing, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: infoBg, attribute: .leading, relatedBy: .equal, toItem: centerView, attribute: .leading, multiplier: 1, constant: 0))

    NSLayoutConstraint.activate(constraints)
  }

  func initLabel(){
    textLabel.font = font
    textLabel.textColor = UIColor.black
    textLabel.text = textArray[0]
    textLabel.numberOfLines = 4
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(textLabel)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: centerView, attribute: .top, multiplier: 1, constant: 16))
    constraints.append(NSLayoutConstraint(item: textLabel, attribute: .width, relatedBy: .equal, toItem: centerView, attribute: .width, multiplier: 0.72, constant: 0))
    constraints.append(NSLayoutConstraint(item: textLabel, attribute: .height, relatedBy: .equal, toItem: centerView, attribute: .height, multiplier: 0.25, constant: 0))
    NSLayoutConstraint.activate(constraints)

    textLabel2.font = font
    textLabel2.textColor = UIColor.black
    textLabel2.text = textArray[1]
    textLabel2.numberOfLines = 10
    textLabel2.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(textLabel2)
    constraints = []
    constraints.append(NSLayoutConstraint(item: textLabel2, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: textLabel2, attribute: .top, relatedBy: .equal, toItem: textLabel, attribute: .bottom, multiplier: 1, constant: 8))
    constraints.append(NSLayoutConstraint(item: textLabel2, attribute: .width, relatedBy: .equal, toItem: textLabel, attribute: .width, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: textLabel2, attribute: .height, relatedBy: .equal, toItem: centerView, attribute: .height, multiplier: 0.42, constant: 0))
    NSLayoutConstraint.activate(constraints)
  }

  func initBtn(){
    backBtn.setBackgroundImage(#imageLiteral(resourceName: "button_cancel"), for: .normal)
    backBtn.addTarget(self, action: #selector(backAction(_:)), for: UIControlEvents.touchUpInside)
    backBtn.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(backBtn)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: backBtn, attribute: .trailing, relatedBy: .equal, toItem: centerView, attribute: .trailing, multiplier: 1, constant: -16))
    constraints.append(NSLayoutConstraint(item: backBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 40))
    constraints.append(NSLayoutConstraint(item: backBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40))
    constraints.append(NSLayoutConstraint(item: backBtn, attribute: .centerY, relatedBy: .equal, toItem: centerView, attribute: .centerY, multiplier: 0.15, constant: 0))
    NSLayoutConstraint.activate(constraints)
  }

  @objc func backAction(_ sender: UIButton) {
    self.removeFromSuperview()
  }

}
