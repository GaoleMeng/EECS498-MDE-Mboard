//
//  WelcomeViewController.swift
//  buttonAddition
//
//  Created by jingyu on 2/1/18.
//  Copyright © 2018 jingyu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    let dumpingRate:CGFloat = 0.7
    var topLabel: UILabel!
    var instrLabel: UILabel!
    var counter: Int = 0
    var pos:[center] = []
    var bt1: UIButton!
    var bt2: UIButton!
    var bt3: UIButton!
    var bt4: UIButton!
    var settle: UIButton!
    var reset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isMultipleTouchEnabled = true
        //        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        //        self.view.addGestureRecognizer(tapGes)
        self.view.backgroundColor = .white
        let vLine = lineView(frame: CGRect(x: self.view.frame.width - 220 /*551*/, y: 204, width: 180, height: self.view.frame.height))
        vLine.backgroundColor = UIColor.white
        self.view.addSubview(vLine)
        topLabel = UILabel(frame: CGRect(x: 44, y: 75, width: 680.5, height: 96))
        topLabel.font = topLabel.font.withSize(70)
        topLabel.text = "Welcome to M-Board"
        topLabel.textAlignment = .center
        topLabel.textColor = .black
        topLabel.backgroundColor = .white
        self.view.addSubview(topLabel)
        instrLabel = UILabel(frame: CGRect(x: 20, y: 204, width: 523, height: 80))
        instrLabel.font = topLabel.font.withSize(35)
        instrLabel.text = "Place your four fingers below"
        instrLabel.textAlignment = .center
        instrLabel.textColor = .black
        instrLabel.backgroundColor = .white
        self.view.addSubview(instrLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if counter < 4 {
                let location = touch.location(in: self.view)
                let tpCenter: center = center(mx: location.x, my: location.y)
                pos.append(tpCenter)
                print(location)
                counter += 1
                if counter == 4 {
                    let sortedPos = pos.sorted(by: {$0.x < $1.x})
                    
                    bt1 = UIButton()
                    bt1.backgroundColor = UIColor.lightGray
                    bt1.setTitleColor(UIColor.blue, for: .normal)
                    bt1.frame = CGRect(x: sortedPos[0].x - 40, y: sortedPos[0].y - 40, width: 80, height: 80)
                    bt1.setTitle("a", for: .normal)
                    bt1.layer.cornerRadius = bt1.frame.height / 2
                    
                    bt2 = UIButton()
                    bt2.backgroundColor = UIColor.lightGray
                    bt2.setTitleColor(UIColor.blue, for: .normal)
                    bt2.frame = CGRect(x: sortedPos[1].x - 40, y: sortedPos[1].y - 40, width: 80, height: 80)
                    bt2.setTitle("s", for: .normal)
                    bt2.layer.cornerRadius = bt2.frame.height / 2
                    
                    bt3 = UIButton()
                    bt3.backgroundColor = UIColor.lightGray
                    bt3.setTitleColor(UIColor.blue, for: .normal)
                    bt3.frame = CGRect(x: sortedPos[2].x - 40, y: sortedPos[2].y - 40, width: 80, height: 80)
                    bt3.setTitle("d", for: .normal)
                    bt3.layer.cornerRadius = bt3.frame.height / 2
                    
                    bt4 = UIButton()
                    bt4.backgroundColor = UIColor.lightGray
                    bt4.setTitleColor(UIColor.blue, for: .normal)
                    bt4.frame = CGRect(x: sortedPos[3].x - 40, y: sortedPos[3].y - 40, width: 80, height: 80)
                    bt4.setTitle("f", for: .normal)
                    bt4.layer.cornerRadius = bt4.frame.height / 2
                    
                    self.view.addSubview(bt1)
                    self.view.addSubview(bt2)
                    self.view.addSubview(bt3)
                    self.view.addSubview(bt4)
                    
                    if isOverlap() || invalidRegion() {
                        instrLabel.text = "Bad position, try again"
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            self.bt1.removeFromSuperview()
                            self.bt2.removeFromSuperview()
                            self.bt3.removeFromSuperview()
                            self.bt4.removeFromSuperview()
                            self.instrLabel.text = "Place your four fingers below"
                            self.counter = 0
                            self.pos = []
                        })
                    } else {
                        settle = UIButton()
                        settle.backgroundColor = UIColor.green
                        settle.setTitleColor(UIColor.blue, for: .normal)
                        settle.frame = CGRect(x: self.view.frame.width - 220, y: 200, width: 150, height: 100)
                        settle.setTitle("Sure?", for: .normal)
                        settle.addTarget(self, action: #selector(pressConfirm(_:)), for: .touchUpInside)
                        self.view.addSubview(settle)
                    
                        reset = UIButton()
                        reset.backgroundColor = UIColor.red
                        reset.setTitleColor(UIColor.white, for: .normal)
                        reset.frame = CGRect(x: self.view.frame.width - 220, y: 300, width: 150, height: 100)
                        reset.setTitle("Reset", for: .normal)
                        reset.addTarget(self, action: #selector(pressReset(_:)), for: .touchUpInside)
                        self.view.addSubview(reset)
                    }
                }
            }
        }
    }
    
    func isOverlap() -> Bool {
        if bt2.frame.origin.x - bt1.frame.origin.x <= 80
            || bt3.frame.origin.x - bt2.frame.origin.x <= 80
            || bt4.frame.origin.x - bt3.frame.origin.x <= 80 {
            return true
        }
        return false
    }
    
    func invalidRegion() -> Bool {
        if bt4.frame.origin.x > self.view.frame.width - 300 || bt1.frame.origin.x < 20
            || bt1.frame.origin.y < 250
            || bt2.frame.origin.y < 250
            || bt3.frame.origin.y < 250
            || bt4.frame.origin.y < 250 {
            return true
        }
        return false
    }
    
    /*func distanceButton(bt1: UIButton, bt2: UIButton) -> CGFloat {
        let dist = (bt1.frame.origin.x - bt2.frame.origin.x) * (bt1.frame.origin.x - bt2.frame.origin.x)
            + (bt1.frame.origin.y - bt2.frame.origin.y) * (bt1.frame.origin.y - bt2.frame.origin.y)
        return dist.squareRoot()
    }*/
    
     @objc func pressConfirm(_ sender: UIButton) {
        let keyView = ViewController()
        keyView.setCenterArray(x1: bt1.frame.origin.x, y1: bt1.frame.origin.y,
                               x2: bt2.frame.origin.x, y2: bt2.frame.origin.y,
                               x3: bt3.frame.origin.x, y3: bt3.frame.origin.y,
                               x4: bt4.frame.origin.x, y4: bt4.frame.origin.y)
        self.present(keyView, animated: true, completion: nil)
    }
    
    @objc func pressReset(_ sender: UIButton) {
        bt1.removeFromSuperview()
        bt2.removeFromSuperview()
        bt3.removeFromSuperview()
        bt4.removeFromSuperview()
        settle.removeFromSuperview()
        reset.removeFromSuperview()
        counter = 0
        pos = []
    }
    
    /*override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self.view)
            print(location)
        }
    }*/
    
    
    @objc func tapAction() {
        //        for touch in touches {
        //            let location = touch.location(in: self.view)
        //            print(location)
        //        }
    }
    
}
