//
//  MouseView.swift
//  buttonAddition
//
//  Created by 孟高乐 on 2/17/18.
//  Copyright © 2018 jingyu. All rights reserved.
//

import UIKit
import BubbleTransition
import SwiftyButton

class MouseView: UIViewController,  UIViewControllerTransitioningDelegate{
    
    let transition = BubbleTransition()
    var tmp: PressableButton!
    
    var back_pos: center!
    var ip: String?
    
    var startpos: center!
    
    var getlock: Bool!
    
    var counter: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        tmp = PressableButton()
        tmp.frame = CGRect(x: back_pos.x, y: back_pos.y, width: 100, height: 90)
//        tmp.backgroundColor = .red
        tmp.addTarget(self, action: #selector(pressConfirm(_:)), for: .touchUpInside)
        tmp.colors = .init(
            button: UIColor(red: 247 / 255, green: 231 / 255, blue: 183 / 255, alpha: 1),
            shadow: UIColor(red: 163 / 255, green: 152 / 255, blue: 119 / 255, alpha: 1)
        )
        tmp.setTitle("Back", for: .normal)
        tmp.setTitleColor(.black, for: .normal)
        tmp.shadowHeight = 8
        tmp.cornerRadius = 16
        getlock = false
        counter = 0
        self.view.backgroundColor = UIColor(red: 229 / 255, green: 81 / 255, blue: 55 / 255, alpha: 1)
        self.view.addSubview(tmp)
        
        // Do any additional setup after loading the view.
    }
    
    func setpos(x1: CGFloat, y1: CGFloat, inner_ip: String) {
        back_pos = center(mx: x1, my: y1)
        if inner_ip == "" {
            getip()
        }
        else{
            self.ip = inner_ip
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self.view)
            let tpCenter: center = center(mx: location.x, my: location.y)
            startpos = center(mx: tpCenter.x, my: tpCenter.y)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self.view)
            let tpCenter: center = center(mx: location.x, my: location.y)
            //            print(tpCenter.x - startpos.x)
            moveMouse(x1: (tpCenter.x - startpos.x) * 3, y1: (tpCenter.y - startpos.y) * 3)
            startpos = center(mx: tpCenter.x, my: tpCenter.y)
        }
        counter = 0
    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
    }

    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = tmp.center
        transition.bubbleColor = tmp.backgroundColor!
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = tmp.center
        transition.bubbleColor = tmp.backgroundColor!
        return transition
    }
    
    @objc func pressConfirm(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getip() {
        
        let url = URL(string: "https://mboard-middle-server.herokuapp.com/api/getip")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        let parameters = ["name" : "brad"]
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    self.ip = json["ip"] as? String
                    self.getlock = true
                    // handle json...
                }
            } catch let error {
                self.getlock = false
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func moveMouse(x1: CGFloat, y1: CGFloat) {
        if let tmp_url = self.ip {
            let url = URL(string: "http://" + tmp_url + ":3000/api/moveMouse/" + x1.description + "/" + y1.description)!
            
            //create the session object
            let session = URLSession.shared
            //now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            request.httpMethod = "GET" //set http method as POST
        
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            
            //create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                
                guard error == nil else {
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                        print(json)
                        // handle json...
                    }
                } catch let error {
//                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
        else {
//            print("????")
            if getlock == false {
                getip()
                getlock = true
            }
            
        }
    }
    

}
