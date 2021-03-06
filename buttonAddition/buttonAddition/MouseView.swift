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
    
    var lightup: PressableButton!
    var lightdown: PressableButton!
    
    var volumnup: PressableButton!
    var volumndown: PressableButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(pressleft))
        self.view.addGestureRecognizer(tapGes)
        
        
        let tapDouble = UITapGestureRecognizer(target: self, action: #selector(pressright(_:)))
        tapDouble.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(tapDouble)
        
        let tapDoublecc = UITapGestureRecognizer(target: self, action: #selector(pressdouble(_:)))
        tapDoublecc.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tapDoublecc)
        
        let mouseMove = UIPanGestureRecognizer(target: self, action: #selector(testfunc))
        mouseMove.maximumNumberOfTouches = 1
        mouseMove.minimumNumberOfTouches = 1
        //        mouseMove.setTranslation(CGPoint(x: 0.001, y:0.001), in: self.view)
        self.view.addGestureRecognizer(mouseMove)
        
        
        let scrollMouse = UIPanGestureRecognizer(target: self, action: #selector(scrollfunc))
        scrollMouse.maximumNumberOfTouches = 2
        scrollMouse.minimumNumberOfTouches = 2
        self.view.addGestureRecognizer(scrollMouse)
        
        let drag = UIPanGestureRecognizer(target: self, action: #selector(dragfunc))
        drag.maximumNumberOfTouches = 3
        drag.minimumNumberOfTouches = 3
        self.view.addGestureRecognizer(drag)
        
        
        tmp = PressableButton()
        tmp.frame = CGRect(x: back_pos.x, y: back_pos.y, width: 100, height: 90)
        //        tmp.backgroundColor = .red
        tmp.addTarget(self, action: #selector(pressConfirm(_:)), for: .touchUpInside)
        tmp.colors = .init(
            button: UIColor(red: 99 / 255, green: 110 / 255, blue: 114 / 255, alpha: 1),
            shadow: UIColor(red: 62 / 255, green: 68 / 255, blue: 71 / 255, alpha: 1)
        )
        tmp.setTitle("Back", for: .normal)
        tmp.setTitleColor(.white, for: .normal)
        tmp.shadowHeight = 8
        tmp.cornerRadius = 16
        getlock = false
        counter = 0
        self.view.backgroundColor = UIColor(red: 229 / 255, green: 81 / 255, blue: 55 / 255, alpha: 1)
        
        //        self.view.backgroundColor = UIColor(red: 52 / 255, green: 73 / 255, blue: 94 / 255, alpha: 1)

        lightup = PressableButton()
        lightdown = PressableButton()
        
        
        lightup = PressableButton()
        lightup.frame = CGRect(x: back_pos.x, y: back_pos.y, width: 100, height: 90)
        lightup.shadowHeight = 8
        lightup.cornerRadius = 16

        lightup.colors = .init(
            button: UIColor(red: 149 / 255, green: 165 / 255, blue: 166 / 255, alpha: 1),
            shadow: UIColor(red: 93 / 255, green: 103 / 255, blue: 104 / 255, alpha: 1)
        )
        lightup.addTarget(self, action: #selector(presslightup(_:)), for: .touchUpInside)
        lightup.setTitle("☀️up", for: .normal)

        
        lightdown = PressableButton()
        lightdown.frame = CGRect(x: back_pos.x, y: back_pos.y, width: 100, height: 90)
        lightdown.shadowHeight = 8
        lightdown.cornerRadius = 16

        lightdown.colors = .init(
            button: UIColor(red: 99 / 255, green: 110 / 255, blue: 114 / 255, alpha: 1),
            shadow: UIColor(red: 73 / 255, green: 81 / 255, blue: 84 / 255, alpha: 1)
        )
        
        lightdown.addTarget(self, action: #selector(presslightdown(_:)), for: .touchUpInside)
        lightdown.setTitle("☀️down", for: .normal)
        
        lightup.alpha = 0
        lightdown.alpha = 0
        
        
        
        volumnup = PressableButton()
        volumndown = PressableButton()


        lightdown.colors = .init(
            button: UIColor(red: 99 / 255, green: 110 / 255, blue: 114 / 255, alpha: 1),
            shadow: UIColor(red: 73 / 255, green: 81 / 255, blue: 84 / 255, alpha: 1)
        )

        lightdown.addTarget(self, action: #selector(presslightdown(_:)), for: .touchUpInside)
        lightdown.setTitle("☀️down", for: .normal)

        lightup.alpha = 0
        lightdown.alpha = 0
        
        
        
        volumnup = PressableButton()
        volumndown = PressableButton()
        
        
        volumnup = PressableButton()
        volumnup.frame = CGRect(x: back_pos.x, y: back_pos.y, width: 100, height: 90)
        volumnup.shadowHeight = 8
        volumnup.cornerRadius = 16
        
        volumnup.colors = .init(
            button: UIColor(red: 149 / 255, green: 165 / 255, blue: 166 / 255, alpha: 1),
            shadow: UIColor(red: 93 / 255, green: 103 / 255, blue: 104 / 255, alpha: 1)
        )
        volumnup.addTarget(self, action: #selector(pressvolumnup(_:)), for: .touchUpInside)
        volumnup.setTitle("🔊up", for: .normal)
        
        
        volumndown = PressableButton()
        volumndown.frame = CGRect(x: back_pos.x, y: back_pos.y, width: 100, height: 90)
        volumndown.shadowHeight = 8
        volumndown.cornerRadius = 16
        
        volumndown.colors = .init(
            button: UIColor(red: 99 / 255, green: 110 / 255, blue: 114 / 255, alpha: 1),
            shadow: UIColor(red: 73 / 255, green: 81 / 255, blue: 84 / 255, alpha: 1)
        )
        
        volumndown.addTarget(self, action: #selector(pressvolumndown(_:)), for: .touchUpInside)
        volumndown.setTitle("🔊down", for: .normal)
        
        volumnup.alpha = 0
        volumndown.alpha = 0

        self.view.addSubview(lightup)
        self.view.addSubview(lightdown)
        
        self.view.addSubview(volumnup)
        self.view.addSubview(volumndown)
        self.view.addSubview(tmp)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
            self.lightup.frame.origin.y = self.lightup.frame.origin.y + 200
            self.lightdown.frame.origin.y = self.lightdown.frame.origin.y + 100
            self.volumnup.frame.origin.y = self.volumnup.frame.origin.y + 400
            self.volumndown.frame.origin.y = self.volumndown.frame.origin.y + 300
            self.lightup.alpha = 1
            self.lightdown.alpha = 1
            self.volumnup.alpha = 1
            self.volumndown.alpha = 1
        }, completion: nil)
        
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
        pressUP()
        startpos = center(mx: 0, my: 0)
    }
    //
    //    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        print("moved")
    //        print(touches.count)
    //        for touch in touches {
    //            let location = touch.location(in: self.view)
    //            let tpCenter: center = center(mx: location.x, my: location.y)
    //            //            print(tpCenter.x - startpos.x)
    //            moveMouse(x1: (tpCenter.x - startpos.x) * 3, y1: (tpCenter.y - startpos.y) * 3)
    //            startpos = center(mx: tpCenter.x, my: tpCenter.y)
    //        }
    //        counter = 0
    //    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressUP()
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
    
    @objc func testfunc(_ sender: UIPanGestureRecognizer) {
        let tpCenter: center = center(mx: sender.translation(in: self.view).x, my: sender.translation(in: self.view).y)
        moveMouse(x1: (tpCenter.x - startpos.x) * 3, y1: (tpCenter.y - startpos.y) * 3)
        startpos = center(mx: tpCenter.x, my: tpCenter.y)
    }
    
    
    @objc func dragfunc(_ sender: UIPanGestureRecognizer) {
        let tpCenter: center = center(mx: sender.translation(in: self.view).x, my: sender.translation(in: self.view).y)
        dragMouse(x1: (tpCenter.x - startpos.x) * 3, y1: (tpCenter.y - startpos.y) * 3)
        startpos = center(mx: tpCenter.x, my: tpCenter.y)
    }
    
    
    @objc func scrollfunc(_ sender: UIPanGestureRecognizer) {
        let tpCenter: center = center(mx: sender.translation(in: self.view).x, my: sender.translation(in: self.view).y)
        scrollMouseSend(x1: (tpCenter.x - startpos.x) * 3, y1: (tpCenter.y - startpos.y) * 3)
        startpos = center(mx: tpCenter.x, my: tpCenter.y)
    }
    
    
    @objc func pressConfirm(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func pressvolumnup(_ sender: UIButton) {
        if let tmp_url = self.ip {
            let url = URL(string: "http://" + tmp_url + ":3000/volumnup")!
            
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
            })
            task.resume()
        }
        else {
            if getlock == false {
                getip()
                getlock = true
            }
        }
    }
    
    @objc func pressvolumndown(_ sender: UIButton) {
        if let tmp_url = self.ip {
            let url = URL(string: "http://" + tmp_url + ":3000/volumndown")!
            
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
            })
            task.resume()
        }
        else {
            if getlock == false {
                getip()
                getlock = true
            }
        }
    }
    
    
    @objc func pressright(_ sender: UIButton) {
        if let tmp_url = self.ip {
            let url = URL(string: "http://" + tmp_url + ":3000/rightclick")!
            
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
            })
            task.resume()
        }
        else {
            if getlock == false {
                getip()
                getlock = true
            }
        }
    }
    
    @objc func pressleft(_ sender: UIButton) {
        if let tmp_url = self.ip {
            let url = URL(string: "http://" + tmp_url + ":3000/leftclick")!
            
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
            })
            task.resume()
        }
        else {
            if getlock == false {
                getip()
                getlock = true
            }
        }
    }
    
    @objc func pressdouble(_ sender: UIButton) {
        if let tmp_url = self.ip {
            let url = URL(string: "http://" + tmp_url + ":3000/doubleclick")!
            
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
            })
            task.resume()
        }
        else {
            if getlock == false {
                getip()
                getlock = true
            }
        }
    }
    
    @objc func pressUP() {
        if let tmp_url = self.ip {
            let url = URL(string: "http://" + tmp_url + ":3000/api/mouseup")!
            
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
            })
            task.resume()
        }
        else {
            if getlock == false {
                getip()
                getlock = true
            }
        }
    }
    
    @objc func presslightdown(_ sender: UIButton) {
        if let tmp_url = self.ip {
            let url = URL(string: "http://" + tmp_url + ":3000/lightdown")!
            
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

    @objc func presslightup(_ sender: UIButton) {
        if let tmp_url = self.ip {
            let url = URL(string: "http://" + tmp_url + ":3000/lightup")!
            
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
    
    func dragMouse(x1: CGFloat, y1: CGFloat) {
        if let tmp_url = self.ip {
            let url = URL(string: "http://" + tmp_url + ":3000/api/dragMouse/" + x1.description + "/" + y1.description)!
            
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
    
    
    func scrollMouseSend(x1: CGFloat, y1: CGFloat) {
        if let tmp_url = self.ip {
            let url = URL(string: "http://" + tmp_url + ":3000/api/scrollMouse/" + x1.description + "/" + y1.description)!
            
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

