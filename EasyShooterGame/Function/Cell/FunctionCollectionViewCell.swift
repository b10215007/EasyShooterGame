//
//  FunctionCollectionViewCell.swift
//  soccerHamster
//
//  Created by michael on 2018/7/22.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class FunctionCollectionViewCell: UICollectionViewCell {
  static let identifier = "FunctionCollectionViewCell"

  var imageView = UIImageView()
  var textLabel = UILabel()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initCell()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    initCell()
  }

  func initCell(){
    self.backgroundColor = UIColor.clear

    imageView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(imageView)
    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))

    textLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(textLabel)
    constraints.append(NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: textLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

    NSLayoutConstraint.activate(constraints)
  }

}
