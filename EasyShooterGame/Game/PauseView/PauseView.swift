//
//  PauseView.swift
//  RabbitShooter
//
//  Created by michael on 2018/8/28.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class PauseView: UIView {

  let background = UIImageView()
  let gif = UIImageView()
  let moon = UIImageView()
  let label = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    initView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func initView(){
    self.backgroundColor = UIColor.clear

    background.backgroundColor = UIColor.black
    background.alpha = 0.7
    background.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(background)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: background, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: background, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: background, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: background, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))

    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 64, weight: .bold)
    label.textColor = UIColor.white
    self.addSubview(label)

    constraints.append(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.56, constant: 0))

    gif.loadGif(name: "runner")
    gif.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(gif)

    constraints.append(NSLayoutConstraint(item: gif, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 0.72, constant: 0))
    constraints.append(NSLayoutConstraint(item: gif, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: gif, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.4, constant: 0))
    constraints.append(NSLayoutConstraint(item: gif, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.32, constant: 0))

    moon.image = #imageLiteral(resourceName: "moon")
    moon.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(moon)

    constraints.append(NSLayoutConstraint(item: moon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.5, constant: 0))
    constraints.append(NSLayoutConstraint(item: moon, attribute: .bottom, relatedBy: .equal, toItem: gif, attribute: .top, multiplier: 1, constant: -24))
    constraints.append(NSLayoutConstraint(item: moon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 72))
    constraints.append(NSLayoutConstraint(item: moon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 72))

    NSLayoutConstraint.activate(constraints)
  }
  
}
