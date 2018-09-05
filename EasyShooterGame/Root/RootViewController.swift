//
//  RootViewController.swift
//  RabbitShooter
//
//  Created by michael on 2018/8/22.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

  let bgImage: UIImageView = UIImageView()
  let vc1Btn: UIButton = UIButton()
  let vc2Btn: UIButton = UIButton()
  let vc3Btn: UIButton = UIButton()
  var btnArray: [UIButton] = []
  let btnTextArray = ["START", "Function", "Top Player"]

  let soundManager = SoundManager.shared()

  override func viewDidLoad() {
    super.viewDidLoad()
    soundManager.configureAllSound()
    soundManager.backgroundMusicHandler()

    initView()
    print("Screen Height \(screenHeight)")
    print("Screen Width \(screenWidth)")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func initView(){
    initBackground()
    initBtn()
  }

  func initBackground(){
    bgImage.translatesAutoresizingMaskIntoConstraints = false //一定要加
    bgImage.image = #imageLiteral(resourceName: "bg")
    view.addSubview(bgImage)
    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: bgImage, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: bgImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: bgImage, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: bgImage, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0))
    NSLayoutConstraint.activate(constraints)
  }

  func initBtn() {
    vc1Btn.setBackgroundImage(#imageLiteral(resourceName: "button_cyan"), for: .normal)
    vc1Btn.translatesAutoresizingMaskIntoConstraints = false
    vc1Btn.tag = 0
    vc1Btn.setTitle(btnTextArray[0], for: .normal)
    vc1Btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
    view.addSubview(vc1Btn)
    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: vc1Btn, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: vc1Btn, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: vc1Btn, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.72, constant: 0))
    constraints.append(NSLayoutConstraint(item: vc1Btn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 64))

    vc2Btn.setBackgroundImage(#imageLiteral(resourceName: "btn_3"), for: .normal)
    vc2Btn.translatesAutoresizingMaskIntoConstraints = false
    vc2Btn.tag = 1
    vc2Btn.setTitle(btnTextArray[1], for: .normal)
    vc2Btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
    view.addSubview(vc2Btn)

    constraints.append(NSLayoutConstraint(item: vc2Btn, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: vc2Btn, attribute: .top, relatedBy: .equal, toItem: vc1Btn, attribute: .bottom, multiplier: 1, constant: 40))
    constraints.append(NSLayoutConstraint(item: vc2Btn, attribute: .width, relatedBy: .equal, toItem: vc1Btn, attribute: .width, multiplier: 0.56, constant: 0))
    constraints.append(NSLayoutConstraint(item: vc2Btn, attribute: .height, relatedBy: .equal, toItem: vc1Btn, attribute: .height, multiplier: 1, constant: 0))


    vc3Btn.setBackgroundImage(#imageLiteral(resourceName: "btn_3"), for: .normal)
    vc3Btn.translatesAutoresizingMaskIntoConstraints = false
    vc3Btn.tag = 2
    vc3Btn.setTitle(btnTextArray[2], for: .normal)
    vc3Btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
    view.addSubview(vc3Btn)

    constraints.append(NSLayoutConstraint(item: vc3Btn, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: vc3Btn, attribute: .top, relatedBy: .equal, toItem: vc2Btn, attribute: .bottom, multiplier: 1, constant: 16))
    constraints.append(NSLayoutConstraint(item: vc3Btn, attribute: .width, relatedBy: .equal, toItem: vc2Btn, attribute: .width, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: vc3Btn, attribute: .height, relatedBy: .equal, toItem: vc2Btn, attribute: .height, multiplier: 1, constant: 0))


    NSLayoutConstraint.activate(constraints)
  }

  @objc func btnAction(_ sender: UIButton){
    switch sender.tag {
    case 0:
      let vc = ModeViewController()
      self.navigationController?.pushViewController(vc, animated: true)
    case 1:
      let vc = FunctionViewController()
      self.navigationController?.pushViewController(vc, animated: true)
    case 2:
      let vc = RankViewController()
      self.navigationController?.pushViewController(vc, animated: true)
    default:
      print("No More ViewController")
    }
  }
}
