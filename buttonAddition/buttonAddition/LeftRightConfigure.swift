//
//  LeftRightConfigure.swift
//  buttonAddition
//
//  Created by Nicholas Klein on 3/15/18.
//  Copyright © 2018 jingyu. All rights reserved.
//

import UIKit
import SwiftyButton
import NVActivityIndicatorView

class LeftRightConfigure: UIViewController {
    
    
    var instructions: UILabel!
    var Left_bt: PressableButton!
    var Right_bt: PressableButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let defaults = UserDefaults.standard
        if let hasPos = defaults.string(forKey: "p0_x") {
            // has already configured before
            let keyView = ViewController()
            keyView.modalTransitionStyle = .crossDissolve
            keyView.setCenterArray(x1: CGFloat(defaults.float(forKey: "p0_x")), y1: CGFloat(defaults.float(forKey: "p0_y")),
                                   x2: CGFloat(defaults.float(forKey: "p1_x")), y2: CGFloat(defaults.float(forKey: "p1_y")),
                                   x3: CGFloat(defaults.float(forKey: "p2_x")), y3: CGFloat(defaults.float(forKey: "p2_y")),
                                   x4: CGFloat(defaults.float(forKey: "p3_x")), y4: CGFloat(defaults.float(forKey: "p3_y")))
            self.present(keyView, animated: true, completion: nil)
        } else {
            
            instructions = UILabel(frame: CGRect(x: 50, y: 200, width: self.view.frame.width - 135, height: 80))
            instructions.center = self.view.center
            instructions.center.x = self.view.center.x
            instructions.center.y = self.view.center.y
            instructions.font = instructions.font.withSize(30)
            instructions.text = "Select which hand you prefer to type with"
            instructions.textAlignment = .center
            instructions.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            self.view.addSubview(instructions)
            
            Left_bt = PressableButton()
            Left_bt.frame = CGRect(x: self.view.center.x - 110, y: self.view.center.y/2, width: 110, height: 110)
            Left_bt.center = self.view.center
            Left_bt.center.x = self.view.center.x - 100
            Left_bt.center.y = self.view.center.y - 150
            Left_bt.shadowHeight = 8
            Left_bt.cornerRadius = 20
            Left_bt.colors = .init(
                button: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
                shadow: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            )
            Left_bt.setTitle("left", for: .normal)
            Left_bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            //Left_bt.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
            Left_bt.setTitleColor(.white, for: .normal)
            Left_bt.addTarget(self, action: #selector(chooseHand(_:)), for: .touchUpInside)
            self.view.addSubview(Left_bt)
            
            Right_bt = PressableButton()
            Right_bt.frame = CGRect(x: self.view.center.x + 110, y: self.view.center.y/2, width: 110, height: 110)
            Right_bt.center = self.view.center
            Right_bt.center.x = self.view.center.x + 100
            Right_bt.center.y = self.view.center.y - 150
            Right_bt.shadowHeight = 8
            Right_bt.cornerRadius = 20
            Right_bt.colors = .init(
                button: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
                shadow: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            )
            Right_bt.setTitle("right", for: .normal)
            Right_bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            //Right_bt.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
            Left_bt.setTitleColor(.white, for: .normal)
            Right_bt.addTarget(self, action: #selector(chooseHand(_:)), for: .touchUpInside)
            self.view.addSubview(Right_bt)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func chooseHand(_ sender: UIButton) {
        print("\(sender.titleLabel!.text!) selected")
        let configView = WelcomeViewController(nibName: nil, bundle: nil)
        configView.modalTransitionStyle = .crossDissolve
        let defaults = UserDefaults.standard
        defaults.set(sender.titleLabel!.text!, forKey: "handChosen")
        self.present(configView, animated: true, completion: nil)
    }
}
