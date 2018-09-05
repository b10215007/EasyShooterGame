//
//  SegmentControlView.swift
//  RabbitShooter
//
//  Created by michael on 2018/8/26.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class SegmentControlView: UIView {

  let imageView = UIImageView()
  let onButton = UIButton()
  let offButton = UIButton()

  var isOn = true

  override init(frame: CGRect) {
    super.init(frame: frame)
    initView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func initView(){
    imageView.image = #imageLiteral(resourceName: "switch_on")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(imageView)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))

    onButton.setTitle("", for: .normal)
    onButton.translatesAutoresizingMaskIntoConstraints = false
    onButton.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
    self.addSubview(onButton)

    constraints.append(NSLayoutConstraint(item: onButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: onButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: onButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: onButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0))

    offButton.setTitle("", for: .normal)
    offButton.translatesAutoresizingMaskIntoConstraints = false
    offButton.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
    self.addSubview(offButton)

    constraints.append(NSLayoutConstraint(item: offButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: offButton, attribute: .left, relatedBy: .equal, toItem: onButton, attribute: .right, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: offButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: offButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0))

    NSLayoutConstraint.activate(constraints)
  }

  @objc func btnAction(_ sender: UIButton){
    if sender == onButton {
      isOn = true
      imageView.image = #imageLiteral(resourceName: "switch_on")
    }else{
      isOn = false
      imageView.image = #imageLiteral(resourceName: "switch_off")
    }
  }

}
