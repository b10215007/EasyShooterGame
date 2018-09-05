//
//  ButtonManager.swift
//  RabbitShooter
//
//  Created by michael on 2018/8/22.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class ButtonManager {

  private static var singleton: ButtonManager?
  static func shared() -> ButtonManager? {
    if singleton == nil {
      singleton = ButtonManager()
    }
    return singleton
  }

  
}
