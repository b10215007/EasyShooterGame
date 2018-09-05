//
//  ColorManager.swift
//  KingOfSoccerShooter
//
//  Created by michael on 2018/8/3.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class ColorManager {

  private static var singleton: ColorManager?
  static func shared() -> ColorManager? {
    if singleton == nil {
      singleton = ColorManager()
    }
    return singleton
  }

  var textColor = UIColor(red: 113/255, green: 224/255, blue: 232/255, alpha: 1)
  var btnBgColor = UIColor(red: 113/255, green: 224/255, blue: 232/255, alpha: 1)
  var mainColor = UIColor(red: 26/255, green: 68/255, blue: 49/255, alpha: 1)
  var white = UIColor.white
  var black = UIColor.black
  var lightGray = UIColor.lightGray
  var gray = UIColor.gray
  var darkGray = UIColor.darkGray
  var red = UIColor.red
  var orange = UIColor.orange
  var yellow = UIColor.yellow
  var green = UIColor.green
  var blue = UIColor.blue
  var cyan = UIColor.cyan
  var purple = UIColor.purple
}
