//
//  ViewController.swift
//  Tumblr Menu
//
//  Created by nimo on 2017/5/14.
//  Copyright © 2017年 nimoAndHisFriends. All rights reserved.
//

import UIKit

//todo use CGAffineTrans class to finish the similar effct!
class ViewController: UIViewController {

//    var counter: I
    let dumpingRate:CGFloat = 0.7
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isMultipleTouchEnabled = true
//        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapAction))
//        self.view.addGestureRecognizer(tapGes)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self.view)
            print(location)
        }
        print(touches.count)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self.view)
            print(location)
        }
    }

    
    @objc func tapAction() {
//        for touch in touches {
//            let location = touch.location(in: self.view)
//            print(location)
//        }
    }
    
}

