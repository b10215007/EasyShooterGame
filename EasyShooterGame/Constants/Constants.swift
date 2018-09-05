//
//  Constants.swift
//  RabbitShooter
//
//  Created by michael on 2018/9/3.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

enum GameMode: String{
  case Easy = "Easy"
  case Normal = "Normal"
  case Hard = "Hard"
}

var currentGameMode = GameMode.Easy
var gameTime = 120
var hideTime = 3.0

let screenHeight = UIScreen.main.bounds.height
let screenWidth = UIScreen.main.bounds.width
