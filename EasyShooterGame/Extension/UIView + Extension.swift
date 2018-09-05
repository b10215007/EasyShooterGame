//
//  UIView + Extension.swift
//  soccerHamster
//
//  Created by michael on 2018/7/22.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

extension UIView{

  func rotate(){
    let rotate = CABasicAnimation(keyPath: "transform.rotation")
    rotate.fromValue = 0
    rotate.toValue = -Double.pi * 2
    rotate.duration = 1.2
    rotate.repeatCount = Float.infinity

    layer.add(rotate, forKey: nil)
  }

  func flash(repeatCount: Float){
    let flash = CABasicAnimation(keyPath: "opacity")
    flash.duration = 0.5
    flash.fromValue = 1
    flash.toValue = 0.1
    flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    flash.autoreverses = true
    flash.repeatCount = repeatCount

    layer.add(flash, forKey: nil)
  }

  func move(){
    let shake = CABasicAnimation(keyPath: "position")
    shake.duration = 0.1
    shake.repeatCount = 2
    shake.autoreverses = true

    let fromPoint = CGPoint(x: center.x - 5, y: center.y)
    let fromValue = NSValue(cgPoint: fromPoint)

    let toPoint = CGPoint(x: center.x + 5, y: center.y)
    let toValue = NSValue(cgPoint: toPoint)

    shake.fromValue = fromValue
    shake.toValue = toValue

    layer.add(shake, forKey: "position")

  }

  func scale(){
    let scale = CABasicAnimation(keyPath: "transform.scale")
    scale.toValue = 2
    let opacity = CABasicAnimation(keyPath: "opacity")
    opacity.toValue = 0.2

    let group = CAAnimationGroup()
    group.animations = [scale,opacity]
    group.duration = 0.88
    group.autoreverses = false
    group.repeatCount = Float.infinity
    group.isRemovedOnCompletion = true

    layer.add(group, forKey: "scale")
  }

  func leftRightMove(){
    let shake = CABasicAnimation(keyPath: "position")
    shake.duration = 0.4
    shake.repeatCount = 10
    shake.autoreverses = true

    let fromPoint = CGPoint(x: center.x - 5, y: center.y)
    let fromValue = NSValue(cgPoint: fromPoint)

    let toPoint = CGPoint(x: center.x + 5, y: center.y)
    let toValue = NSValue(cgPoint: toPoint)

    shake.fromValue = fromValue
    shake.toValue = toValue

    layer.add(shake, forKey: "position")
  }

  func upDownMove(repeatCount: Float){
    let shake = CABasicAnimation(keyPath: "position")
    shake.duration = 0.4
    shake.repeatCount = repeatCount
    shake.autoreverses = true

    let fromPoint = CGPoint(x: center.x, y: center.y - 5)
    let fromValue = NSValue(cgPoint: fromPoint)

    let toPoint = CGPoint(x: center.x, y: center.y + 12)
    let toValue = NSValue(cgPoint: toPoint)

    shake.fromValue = fromValue
    shake.toValue = toValue

    layer.add(shake, forKey: "position")
  }


}
