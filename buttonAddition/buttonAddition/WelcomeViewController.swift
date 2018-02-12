//
//  WelcomeViewController.swift
//  buttonAddition
//
//  Created by jingyu on 2/1/18.
//  Copyright © 2018 jingyu. All rights reserved.
//

import UIKit
import Pulsator
import SwiftyButton
import NVActivityIndicatorView

class WelcomeViewController: UIViewController {
    
    let dumpingRate:CGFloat = 0.7
    var instrLabel: UILabel!
    var counter: Int = 0
    var pos:[center] = []
    var bt1: UIImageView!
    var bt2: UIImageView!
    var bt3: UIImageView!
    var bt4: UIImageView!
    
    var pulsebt1: Pulsator!
    var pulsebt2: Pulsator!
    var pulsebt3: Pulsator!
    var pulsebt4: Pulsator!
    
    var settle: PressableButton!
    

    var reset: PressableButton!
    
    // track the position of the four finger
    var checkpos1: [center] = []
    var checkpos2: [center] = []
    var checkpos3: [center] = []
    var checkpos4: [center] = []
    
    var touchLock: Bool = false
    var okLock: Bool = false
    var timer = Timer()
    
    var loadingicon: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isMultipleTouchEnabled = true
        //        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        //        self.view.addGestureRecognizer(tapGes)
        self.view.backgroundColor = .white
        //let vLine = rectangular(frame: CGRect(x: 5, y: 110, width: self.view.frame.width - 135, height: self.view.frame.height - 250))
        let vLine1 = lineView(frame: CGRect(x: 5, y: 300, width: 2, height: self.view.frame.height - 440))
        let vLine2 = lineView(frame: CGRect(x: 5 + self.view.frame.width - 135, y: 300, width: 2, height: self.view.frame.height - 440))
        let hLine1 = rectangular(frame: CGRect(x: 5, y: 300, width: self.view.frame.width - 135, height: 2))
        let hLine2 = rectangular(frame: CGRect(x: 5, y: 300 + self.view.frame.height - 440, width: self.view.frame.width - 135, height: 2))
        vLine1.backgroundColor = UIColor(white: 1, alpha: 0.5)
        vLine2.backgroundColor = UIColor(white: 1, alpha: 0.5)
        hLine1.backgroundColor = UIColor(white: 1, alpha: 0.5)
        hLine2.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.view.addSubview(vLine1)
        self.view.addSubview(vLine2)
        self.view.addSubview(hLine1)
        self.view.addSubview(hLine2)
        instrLabel = UILabel(frame: CGRect(x: 50, y: 200, width: self.view.frame.width - 135, height: 80))
        instrLabel.font = instrLabel.font.withSize(30)
        instrLabel.text = "Place and keep your four fingers inside"
        instrLabel.textAlignment = .left
        instrLabel.textColor = .gray
        instrLabel.backgroundColor = .white
        touchLock = false
        self.view.addSubview(instrLabel)
        
        loadingicon = NVActivityIndicatorView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width - 135, height: 80), color: UIColor(red: 229 / 255, green: 81 / 255, blue: 55 / 255, alpha: 1))
        
        self.view.addSubview(loadingicon)
//        loadingicon.startAnimating()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scheduledTimerWithTimeInterval(){
        // do checking the position of the four button ever 0.4 second
        self.timer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(checker),
            userInfo: nil,
            repeats: true)
    }
    
    @objc func checker () {
        if okLock {
            return
        }
        checkpos1.append(center(mx: bt1.frame.midX, my: bt1.frame.midY))
        checkpos2.append(center(mx: bt2.frame.midX, my: bt2.frame.midY))
        checkpos3.append(center(mx: bt3.frame.midX, my: bt3.frame.midY))
        checkpos4.append(center(mx: bt4.frame.midX, my: bt4.frame.midY))
        
        if checkpos1.count > 8 {
            // pop the first value and check the other 5
            var succeed = true
            var cur = center(mx: bt1.frame.midX, my: bt1.frame.midY)
            checkpos1.removeFirst()
            checkpos2.removeFirst()
            checkpos3.removeFirst()
            checkpos4.removeFirst()
            for cc in checkpos1 {
                if abs(cur.x - cc.x) + abs(cur.y - cc.y) > 3 {
                    succeed = false
                }
            }
            
            
            cur = center(mx: bt2.frame.midX, my: bt2.frame.midY)
            for cc in checkpos2 {
                if abs(cur.x - cc.x) + abs(cur.y - cc.y) > 3 {
                    succeed = false
                }
            }
            
            cur = center(mx: bt3.frame.midX, my: bt3.frame.midY)
            for cc in checkpos3 {
                if abs(cur.x - cc.x) + abs(cur.y - cc.y) > 3 {
                    succeed = false
                }
            }
            
            cur = center(mx: bt4.frame.midX, my: bt4.frame.midY)
            for cc in checkpos4 {
                if abs(cur.x - cc.x) + abs(cur.y - cc.y) > 3 {
                    succeed = false
                }
            }
            if succeed {
                if isOverlap() || invalidRegion() {
                    print("overlap")
                    print(isOverlap())
                    print("invalid")
                    print(invalidRegion())
                    print("----")
                    print("not valid")
                }
                else {
                    // the check is ok, we then progress to the finalize of the button
                    
                    pulsebt1 = Pulsator()
                    view.layer.addSublayer(pulsebt1)
                    pulsebt1.radius = 110
                    pulsebt1.position = bt1.center
                    pulsebt1.numPulse = 2
                    
                    pulsebt2 = Pulsator()
                    view.layer.addSublayer(pulsebt2)
                    pulsebt2.radius = 110
                    pulsebt2.position = bt2.center
                    pulsebt2.numPulse = 2
                    
                    pulsebt3 = Pulsator()
                    view.layer.addSublayer(pulsebt3)
                    pulsebt3.radius = 110
                    pulsebt3.position = bt3.center
                    pulsebt3.numPulse = 2
                    
                    pulsebt4 = Pulsator()
                    view.layer.addSublayer(pulsebt4)
                    pulsebt4.radius = 110
                    pulsebt4.position = bt4.center
                    pulsebt4.numPulse = 2
                    
                    pulsebt1.start()
                    pulsebt2.start()
                    pulsebt3.start()
                    pulsebt4.start()
                    
                    settle = PressableButton()
                    //                    settle.backgroundColor = UIColor.green
                    settle.colors = .init(
                        button: UIColor(red: 229 / 255, green: 81 / 255, blue: 55 / 255, alpha: 1),
                        shadow: UIColor(red: 175 / 255, green: 57 / 255, blue: 36 / 255, alpha: 1)
                    )
                    
                    settle.shadowHeight = 7
                    settle.cornerRadius = 5
                    //                    settle.setTitleColor(UIColor.blue, for: .normal)
                    settle.frame = CGRect(x: self.view.frame.width - 120, y: self.view.frame.height / 2 - 75, width: 100, height: 100)
                    settle.setTitle("Comfirm", for: .normal)
                    settle.addTarget(self, action: #selector(pressConfirm(_:)), for: .touchUpInside)
                    settle.alpha = 0
                    
                    self.view.addSubview(self.settle)
//                    UIView.animate(withDuration: 1.5) {
//                        self.settle.alpha = 1.0
//                    }
                    
                    reset = PressableButton()
                    reset.colors = .init(
                        button: UIColor(red: 96 / 255, green: 201 / 255, blue: 92 / 255, alpha: 1),
                        shadow: UIColor(red: 65 / 255, green: 130 / 255, blue: 63 / 255, alpha: 1)
                    )
                    reset.shadowHeight = 7
                    reset.cornerRadius = 5
                    
                    reset.setTitleColor(UIColor.white, for: .normal)
                    reset.frame = CGRect(x: self.view.frame.width - 120, y: self.view.frame.height / 2 + 75, width: 100, height: 100)
                    reset.setTitle("Reset", for: .normal)
                    reset.addTarget(self, action: #selector(pressReset(_:)), for: .touchUpInside)
                    
                    reset.alpha = 0
                    
                    
                    self.view.addSubview(self.reset)
                    
                    UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
                        self.settle.alpha = 1
                        self.reset.alpha = 1
                    }, completion: nil)
                    
                    UIView.animate(withDuration: 1) {
                        self.reset.colors = .init(
                            button: UIColor(red: 96 / 255, green: 201 / 255, blue: 92 / 255, alpha: 1),
                            shadow: UIColor(red: 65 / 255, green: 130 / 255, blue: 63 / 255, alpha: 1)
                        )
                    }
                    
                    self.okLock = true
                }
            }
        }
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
                    
                    bt1 = UIImageView()
                    bt1.backgroundColor = UIColor.lightGray
                    bt1.frame = CGRect(x: sortedPos[0].x - 40, y: sortedPos[0].y - 40, width: 80, height: 80)
                    bt1.layer.cornerRadius = bt1.frame.height / 2
                    
                    bt2 = UIImageView()
                    bt2.backgroundColor = UIColor.lightGray
                    bt2.frame = CGRect(x: sortedPos[1].x - 40, y: sortedPos[1].y - 40, width: 80, height: 80)
                    bt2.layer.cornerRadius = bt2.frame.height / 2
                    
                    bt3 = UIImageView()
                    bt3.backgroundColor = UIColor.lightGray
                    bt3.frame = CGRect(x: sortedPos[2].x - 40, y: sortedPos[2].y - 40, width: 80, height: 80)
                    bt3.layer.cornerRadius = bt3.frame.height / 2
                    
                    bt4 = UIImageView()
                    bt4.backgroundColor = UIColor.lightGray
                    bt4.frame = CGRect(x: sortedPos[3].x - 40, y: sortedPos[3].y - 40, width: 80, height: 80)
                    bt4.layer.cornerRadius = bt4.frame.height / 2
                    
                    self.view.addSubview(bt1)
                    self.view.addSubview(bt2)
                    self.view.addSubview(bt3)
                    self.view.addSubview(bt4)
                    
                    self.touchLock = true
                    scheduledTimerWithTimeInterval()
                }
            }
        }
    }
    
    
    // return the index of the cloest button on the view
    func getTheClosestButton (_ x: Float, _ y: Float) -> Int{
        
        var min_bt = 0
        var min_dis: Float = 100000.0
        
        var xDist = Float(bt1.frame.midX) - x;
        var yDist = Float(bt1.frame.midY) - y;
        var thisDist = xDist * xDist + yDist * yDist
        if thisDist < min_dis {
            min_dis = thisDist
            min_bt = 1
        }
        
        xDist = Float(bt2.frame.midX) - x;
        yDist = Float(bt2.frame.midY) - y;
        thisDist = xDist * xDist + yDist * yDist
        if thisDist < min_dis {
            min_dis = thisDist
            min_bt = 2
        }
        
        xDist = Float(bt3.frame.midX) - x;
        yDist = Float(bt3.frame.midY) - y;
        thisDist = xDist * xDist + yDist * yDist
        if thisDist < min_dis {
            min_dis = thisDist
            min_bt = 3
        }
        
        xDist = Float(bt4.frame.midX) - x;
        yDist = Float(bt4.frame.midY) - y;
        thisDist = xDist * xDist + yDist * yDist
        if thisDist < min_dis {
            min_dis = thisDist
            min_bt = 4
        }
        
        return min_bt
    }
    
    // the function to track the position for four finger
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.touchLock == true && self.okLock == false {
            for touch in touches {
                let location = touch.location(in: self.view)
                let bb = getTheClosestButton(Float(location.x), Float(location.y))
                if bb == 1 {
                    bt1.frame = CGRect(x: location.x - 40, y: location.y - 40, width: 80, height: 80)
                }
                else if bb == 2 {
                    bt2.frame = CGRect(x: location.x - 40, y: location.y - 40, width: 80, height: 80)
                }
                else if bb == 3 {
                    bt3.frame = CGRect(x: location.x - 40, y: location.y - 40, width: 80, height: 80)
                }
                else if bb == 4 {
                    bt4.frame = CGRect(x: location.x - 40, y: location.y - 40, width: 80, height: 80)
                }
            }
        }
    }
    
    
    func isOverlap() -> Bool {
        var bxArray: [CGFloat] = []
        bxArray.append(bt1.frame.midX)
        bxArray.append(bt2.frame.midX)
        bxArray.append(bt3.frame.midX)
        bxArray.append(bt4.frame.midX)
        bxArray = bxArray.sorted(by: {$0 < $1})
        //print(bxArray)
        if bxArray[1] - bxArray[0] <= 70
            || bxArray[2] - bxArray[1] <= 80
            || bxArray[3] - bxArray[2] <= 70 {
            return true
        }
        return false
    }
    
    func invalidRegion() -> Bool {
        var bxArray: [CGFloat] = []
        bxArray.append(bt1.frame.midX)
        bxArray.append(bt2.frame.midX)
        bxArray.append(bt3.frame.midX)
        bxArray.append(bt4.frame.midX)
        bxArray = bxArray.sorted(by: {$0 < $1})
        //print(bxArray)
        if bxArray[3] > self.view.frame.width - 170
            || bxArray[0] < 40
            || bt1.frame.origin.y < 300 || bt1.frame.origin.y > self.view.frame.height - 210
            || bt2.frame.origin.y < 300 || bt2.frame.origin.y > self.view.frame.height - 210
            || bt3.frame.origin.y < 300 || bt3.frame.origin.y > self.view.frame.height - 210
            || bt4.frame.origin.y < 300 || bt4.frame.origin.y > self.view.frame.height - 210 {
            return true
        }
        return false
    }
    
    
    @objc func pressConfirm(_ sender: UIButton) {
        var bxArray: [UIImageView] = []
        bxArray.append(bt1)
        bxArray.append(bt2)
        bxArray.append(bt3)
        bxArray.append(bt4)
        bxArray = bxArray.sorted(by: {$0.frame.origin.x < $1.frame.origin.x})
        let keyView = ViewController()
        keyView.modalTransitionStyle = .crossDissolve
        keyView.setCenterArray(x1: bxArray[0].frame.origin.x, y1: bxArray[0].frame.origin.y,
                               x2: bxArray[1].frame.origin.x, y2: bxArray[1].frame.origin.y,
                               x3: bxArray[2].frame.origin.x, y3: bxArray[2].frame.origin.y,
                               x4: bxArray[3].frame.origin.x, y4: bxArray[3].frame.origin.y)
        
        self.present(keyView, animated: true, completion: nil)
    }
    
    @objc func pressReset(_ sender: UIButton) {
        self.timer.invalidate()
        
        bt1.removeFromSuperview()
        bt2.removeFromSuperview()
        bt3.removeFromSuperview()
        bt4.removeFromSuperview()
        
        settle.removeFromSuperview()
        reset.removeFromSuperview()
        
        counter = 0
        okLock = false
        touchLock = false
        checkpos1.removeAll()
        checkpos2.removeAll()
        checkpos3.removeAll()
        checkpos4.removeAll()
        
        pulsebt1.stop()
        pulsebt2.stop()
        pulsebt3.stop()
        pulsebt4.stop()
        
        pos = []
    }
    
    
    
    @objc func tapAction() {
        // dummy code
    }
    
}

