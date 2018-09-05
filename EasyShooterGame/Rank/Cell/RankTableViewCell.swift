//
//  RankTableViewCell.swift
//  soccorConnectGame
//
//  Created by michael on 2018/7/15.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class RankTableViewCell: UITableViewCell {
  static let identifier = "RankTableViewCell"

  var numLabel = UILabel()
  var valueLabel = UILabel()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initCell()
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initCell()
  }

  func initCell(){

    numLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(numLabel)
    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: numLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: numLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 24))

    valueLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(valueLabel)
    constraints.append(NSLayoutConstraint(item: valueLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: valueLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -16))
    NSLayoutConstraint.activate(constraints)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
    
}
