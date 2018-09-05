//
//  TimeBottomView.swift
//  RabbitShooter
//
//  Created by michael on 2018/8/22.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class BottomTimeView: UIView {

  let timeImage = UIImageView()
  var timeImageTrailingConstraint: NSLayoutConstraint!
  let timeTextLabel = UILabel()

  let font = UIFont.systemFont(ofSize: 20, weight: .semibold)

  override init(frame: CGRect) {
    super.init(frame: frame)
    initView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func initView(){
    self.backgroundColor = UIColor.white

    timeImage.image = #imageLiteral(resourceName: "rectangle_green")
    timeImage.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(timeImage)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: timeImage, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: timeImage, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
    timeImageTrailingConstraint = NSLayoutConstraint(item: timeImage, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
    constraints.append(timeImageTrailingConstraint)
    constraints.append(NSLayoutConstraint(item: timeImage, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))

    timeTextLabel.text = "120s"
    timeTextLabel.textColor = UIColor.white
    timeTextLabel.font = font
    timeTextLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(timeTextLabel)

    constraints.append(NSLayoutConstraint(item: timeTextLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: timeTextLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -12))

    NSLayoutConstraint.activate(constraints)
  }
}
