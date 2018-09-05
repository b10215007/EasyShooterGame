//
//  ModeViewController.swift
//  soccorConnectGame
//
//  Created by michael on 2018/7/15.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class ModeViewController: UIViewController {

  let bgImage = UIImageView()

  let centerView = UIView()
  let stackView = UIStackView()
  let easyBtn = UIButton()
  let normalBtn = UIButton()
  let hardBtn = UIButton()

  let introSwitch = UISwitch()

  var btnArray: [UIButton] = []
  let btnTextArray = ["Easy", "Normal", "Hard"]

  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func initView(){
    initBackground()
    initCenterView()
    initBtn()
    initStackView()
    initHowSwitch()
  }

  func initBackground(){
    bgImage.translatesAutoresizingMaskIntoConstraints = false
    bgImage.image = #imageLiteral(resourceName: "bg")
    view.addSubview(bgImage)
    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: bgImage, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: bgImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: bgImage, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: bgImage, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0))
    NSLayoutConstraint.activate(constraints)
  }

  func initCenterView(){
    centerView.backgroundColor = UIColor.clear
    view.addSubview(centerView)
    centerView.translatesAutoresizingMaskIntoConstraints = false
    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.88, constant: 0))
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 300))
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
    NSLayoutConstraint.activate(constraints)
  }

  func initStackView(){
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 32
    centerView.addSubview(stackView)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: centerView, attribute: .width, multiplier: 0.88, constant: 0))
    constraints.append(NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: centerView, attribute: .height, multiplier: 0.8, constant: 0))
    constraints.append(NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: centerView, attribute: .centerY, multiplier: 1.2, constant: 0))
    NSLayoutConstraint.activate(constraints)
  }

  func initBtn(){
    btnArray = [easyBtn, normalBtn, hardBtn]
    for (i,btn) in btnArray.enumerated() {
      btn.setTitle(btnTextArray[i], for: .normal)
      btn.setTitleColor(UIColor.white, for: .normal)
      btn.setBackgroundImage(#imageLiteral(resourceName: "button_green"), for: .normal)
      btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
      btn.addTarget(self, action: #selector(btnAction(_:)), for: UIControlEvents.touchUpInside)
      btn.translatesAutoresizingMaskIntoConstraints = false
      stackView.addArrangedSubview(btn)
    }
  }

  @objc func btnAction(_ sender: UIButton){
    setModeChoosed(title: (sender.titleLabel?.text)!)
    initModeBtn()
    sender.flash(repeatCount: 3)

    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }

  func initModeBtn(){
    switch currentGameMode {
    case .Easy:
      easyBtn.setBackgroundImage(#imageLiteral(resourceName: "button_cyan"), for: .normal)
    case .Normal:
      normalBtn.setBackgroundImage(#imageLiteral(resourceName: "button_cyan"), for: .normal)
    case .Hard:
      hardBtn.setBackgroundImage(#imageLiteral(resourceName: "button_cyan"), for: .normal)
    }
  }

  func initHowSwitch(){
    if let value = UserInfoManager.get(key: UserInfoKey.isIntroOn) as? Bool {
      if value {
        introSwitch.isOn = true
        addHowToPlay()
      }else{
        introSwitch.isOn = false
      }
    }else{
      introSwitch.isOn = true
      addHowToPlay() //First enter Game
    }
    introSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
    introSwitch.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(introSwitch)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: introSwitch, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 32))
    constraints.append(NSLayoutConstraint(item: introSwitch, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -32))

    NSLayoutConstraint.activate(constraints)
  }

  func addHowToPlay(){
    let subView = HowToPlayView()
    subView.backgroundColor = UIColor.clear
    subView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(subView)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: subView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: subView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))

    NSLayoutConstraint.activate(constraints)
  }

  @objc func switchAction(_ sender: UISwitch){
    sender.isOn = !sender.isOn

    UserInfoManager.set(value: introSwitch.isOn, key: UserInfoKey.isIntroOn)
  }

  func setModeChoosed(title: String){
    switch title {
    case "Easy":
      currentGameMode = .Easy
      gameTime = 120
      hideTime = 3.0
    case "Normal":
      currentGameMode = .Normal
      gameTime = 80
      hideTime = 1.5
    default:
      currentGameMode = .Hard
      gameTime = 30
      hideTime = 0.8
    }
  }

}
