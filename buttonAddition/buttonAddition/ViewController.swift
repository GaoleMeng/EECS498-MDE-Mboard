import UIKit
import SwiftyButton
import BubbleTransition


struct center {
    var x: CGFloat
    var y: CGFloat
    init(mx: CGFloat, my: CGFloat) {
        x = mx
        y = my
    }
}

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    //var inputText: UILabel!
    var buttons: Array<PressableButton> = []
    var centerArray: [center] = []
    
    var Space: PressableButton!
    var Delete: PressableButton!
    var Enter: PressableButton!
    var Helper: PressableButton!
    
    var Cap: PressableButton!
    var isCapped: Int = 0
    
    var timer = Timer()
    var deleteTimer: Timer?
    
    //var SwitchMode: PressableButton!
    var hstate: Int = 0
    var mode: Int = 0
    
    var goBack: PressableButton!
    
    var mouseButton: PressableButton!
    
    var modes: Array<UIButton> = []
    
    var words: Array<String> = []
    var predWords: Array<UIButton> = []
    var str1 = ""
    var str2 = ""
    var pred_flag = -1 // 0: autocomplete, 1: predict new word
    
    var ip: String?
    var nav_arrows: Array<UIButton> = []
    var nav_left = UIButton()
    var nav_right = UIButton()
    var nav_up = UIButton()
    var nav_down = UIButton()
    
    // the boolean to tell whether it is the num mode
    var whether_num: Bool!
    
    let transition = BubbleTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getip()
        whether_num = false
        view.backgroundColor = .lightGray
        setButton()
        let ownerview: UIView = self.view
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(funcForGesture))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(funcForGesture))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(funcForGesture))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(funcForGesture))
        
        upSwipe.direction = .up
        downSwipe.direction = .down
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        ownerview.addGestureRecognizer(upSwipe)
        ownerview.addGestureRecognizer(downSwipe)
        ownerview.addGestureRecognizer(leftSwipe)
        ownerview.addGestureRecognizer(rightSwipe)
        scheduledTimerWithTimeInterval()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if (!whether_num) {
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
                self.buttons[0].alpha = 1
                self.buttons[0].frame.origin.y = self.buttons[4].frame.origin.y - 100
                self.buttons[1].alpha = 1
                self.buttons[1].frame.origin.y = self.buttons[5].frame.origin.y - 100
                self.buttons[2].alpha = 1
                self.buttons[2].frame.origin.y = self.buttons[6].frame.origin.y - 100
                self.buttons[3].alpha = 1
                self.buttons[3].frame.origin.y = self.buttons[7].frame.origin.y -  100
                
                self.buttons[8].alpha = 1
                self.buttons[8].frame.origin.y = self.buttons[4].frame.origin.y + 100
                self.buttons[9].alpha = 1
                self.buttons[9].frame.origin.y = self.buttons[5].frame.origin.y + 100
                self.buttons[10].alpha = 1
                self.buttons[10].frame.origin.y = self.buttons[6].frame.origin.y + 100
                self.buttons[11].alpha = 1
                self.buttons[11].frame.origin.y = self.buttons[7].frame.origin.y + 100
                
                self.buttons[12].alpha = 1
                self.buttons[12].frame.origin.y = self.buttons[7].frame.origin.y - 200
            }, completion: nil)
        }
        
    }
    
    func scheduledTimerWithTimeInterval(){
        // do checking the position of the four button ever 0.4 second
        self.timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(self.getip),
            userInfo: nil,
            repeats: true)
    }
    
    
    @objc func getip(){
        if let tmp = self.ip {
            return;
        }
        
        print("finding ip")
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
                    
                    if let tmp_url = json["ip"] as? String {
                        print("ddd")
                        let url = URL(string: "http://" + tmp_url + ":3000/connect")!
                        //create the session object
                        let session = URLSession.shared
                        
                        //now create the URLRequest object using the url object
                        var request = URLRequest(url: url)
                        request.httpMethod = "GET" //set http method as POST
                        
                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.addValue("application/json", forHTTPHeaderField: "Accept")
                        
                        //create dataTask using the session object to send data to the server
                        let task = session.dataTask(with: request as URLRequest, completionHandler: { new_data, response, error in
                            
                            guard error == nil else {
                                return
                            }
                            
                            guard let new_data = new_data else {
                                return
                            }
                            
                            
                            do {
                                if (try JSONSerialization.jsonObject(with: new_data, options: .mutableContainers) as? [String: Any]) != nil {
                                    print(json)
                                    
                                    self.ip = json["ip"] as? String
                                    self.timer.invalidate()
                                }
                            
                            } catch let error {
                                print(error.localizedDescription)
                            }
                            
                        })
                        task.resume()
                    }
                    else {
                    }
                    
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        
    }
    
    @objc func funcForGesture(sender: UISwipeGestureRecognizer) {
        isCapped = 0
        Cap.setTitle("cap", for: .normal)
        
        if mode == 0 {
            if sender.direction == .left {
                self.hstate = (self.hstate + 1) % 3
                
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
                    
                    for bt in self.buttons {
                        bt.alpha = 0
                        bt.frame.origin.x -= 60
                    }
                    self.nav_left.alpha = 0
                    self.nav_left.frame.origin.x -= 5
                    self.nav_right.alpha = 0
                    self.nav_right.frame.origin.x -= 5
                    
                }, completion: { (finished: Bool) in
                    
                    for bt in self.buttons {
                        bt.alpha = 0
                        bt.frame.origin.x += 120
                    }
                    if(self.hstate == 0){
                        self.nav_left.setTitle("!@$.?", for: .normal)
                        self.nav_right.setTitle("yuiop", for: .normal)
                    }
                    else if(self.hstate == 1){
                        self.nav_left.setTitle("qwert", for: .normal)
                        self.nav_right.setTitle("!@$.?", for: .normal)
                    }
                    else{
                        self.nav_left.setTitle("yuiop", for: .normal)
                        self.nav_right.setTitle("qwert", for: .normal)
                    }
                    
                    self.nav_left.alpha = 0
                    self.nav_left.frame.origin.x += 10
                    self.nav_right.alpha = 0
                    self.nav_right.frame.origin.x += 10
                    
                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
                        for bt in self.buttons {
                            bt.alpha = 1
                            bt.frame.origin.x -= 60
                            if self.hstate == 0 {
                                self.buttons[0].setTitle("q", for: .normal)
                                self.buttons[1].setTitle("w", for: .normal)
                                self.buttons[2].setTitle("e", for: .normal)
                                self.buttons[3].setTitle("r", for: .normal)
                                self.buttons[12].setTitle("t", for: .normal)
                                self.buttons[4].setTitle("a", for: .normal)
                                self.buttons[5].setTitle("s", for: .normal)
                                self.buttons[6].setTitle("d", for: .normal)
                                self.buttons[7].setTitle("f", for: .normal)
                                self.buttons[8].setTitle("z", for: .normal)
                                self.buttons[9].setTitle("x", for: .normal)
                                self.buttons[10].setTitle("c", for: .normal)
                                self.buttons[11].setTitle("v", for: .normal)
                            } else if self.hstate == 1 {
                                self.buttons[0].setTitle("y", for: .normal)
                                self.buttons[1].setTitle("u", for: .normal)
                                self.buttons[2].setTitle("i", for: .normal)
                                self.buttons[3].setTitle("o", for: .normal)
                                self.buttons[4].setTitle("g", for: .normal)
                                self.buttons[12].setTitle("p", for: .normal)
                                self.buttons[5].setTitle("h", for: .normal)
                                self.buttons[6].setTitle("j", for: .normal)
                                self.buttons[7].setTitle("k", for: .normal)
                                self.buttons[8].setTitle("b", for: .normal)
                                self.buttons[9].setTitle("n", for: .normal)
                                self.buttons[10].setTitle("m", for: .normal)
                                self.buttons[11].setTitle("l", for: .normal)
                            } else if self.hstate == 2 {
                                self.buttons[0].setTitle("!", for: .normal)
                                self.buttons[1].setTitle("#", for: .normal)
                                self.buttons[2].setTitle("'", for: .normal)
                                self.buttons[3].setTitle(",", for: .normal)
                                self.buttons[12].setTitle(".", for: .normal)
                                self.buttons[4].setTitle("\"", for: .normal)
                                self.buttons[5].setTitle("?", for: .normal)
                                self.buttons[6].setTitle("(", for: .normal)
                                self.buttons[7].setTitle(")", for: .normal)
                                self.buttons[8].setTitle(";", for: .normal)
                                self.buttons[9].setTitle(":", for: .normal)
                                self.buttons[10].setTitle("@", for: .normal)
                                self.buttons[11].setTitle("$", for: .normal)
                            }
                        }
                        self.nav_left.alpha = 1
                        self.nav_left.frame.origin.x -= 5
                        self.nav_right.alpha = 1
                        self.nav_right.frame.origin.x -= 5
                    }, completion: nil)
                })
            }
            else if sender.direction == .right {
                self.hstate -= 1
                if (self.hstate < 0){
                    self.hstate += 3
                }
                
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
                    
                    for bt in self.buttons {
                        bt.alpha = 0
                        bt.frame.origin.x += 60
                    }
                    self.nav_left.alpha = 0
                    self.nav_left.frame.origin.x += 5
                    self.nav_right.alpha = 0
                    self.nav_right.frame.origin.x += 5
                    
                }, completion: { (finished: Bool) in
                    
                    for bt in self.buttons {
                        bt.alpha = 0
                        bt.frame.origin.x -= 120
                    }
                    
                    if(self.hstate == 0){
                        self.nav_left.setTitle("!@$.?", for: .normal)
                        self.nav_right.setTitle("yuiop", for: .normal)
                    }
                    else if(self.hstate == 1){
                        self.nav_left.setTitle("qwert", for: .normal)
                        self.nav_right.setTitle("!@$.?", for: .normal)
                    }
                    else{
                        self.nav_left.setTitle("yuiop", for: .normal)
                        self.nav_right.setTitle("qwert", for: .normal)
                    }
                    
                    self.nav_left.alpha = 0
                    self.nav_left.frame.origin.x -= 10
                    self.nav_right.alpha = 0
                    self.nav_right.frame.origin.x -= 10
                    
                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
                        for bt in self.buttons {
                            bt.alpha = 1
                            bt.frame.origin.x += 60
                            if self.hstate == 0 {
                                self.buttons[0].setTitle("q", for: .normal)
                                self.buttons[1].setTitle("w", for: .normal)
                                self.buttons[2].setTitle("e", for: .normal)
                                self.buttons[3].setTitle("r", for: .normal)
                                self.buttons[12].setTitle("t", for: .normal)
                                self.buttons[4].setTitle("a", for: .normal)
                                self.buttons[5].setTitle("s", for: .normal)
                                self.buttons[6].setTitle("d", for: .normal)
                                self.buttons[7].setTitle("f", for: .normal)
                                self.buttons[8].setTitle("z", for: .normal)
                                self.buttons[9].setTitle("x", for: .normal)
                                self.buttons[10].setTitle("c", for: .normal)
                                self.buttons[11].setTitle("v", for: .normal)
                            } else if self.hstate == 1 {
                                self.buttons[0].setTitle("y", for: .normal)
                                self.buttons[1].setTitle("u", for: .normal)
                                self.buttons[2].setTitle("i", for: .normal)
                                self.buttons[3].setTitle("o", for: .normal)
                                self.buttons[4].setTitle("g", for: .normal)
                                self.buttons[12].setTitle("p", for: .normal)
                                self.buttons[5].setTitle("h", for: .normal)
                                self.buttons[6].setTitle("j", for: .normal)
                                self.buttons[7].setTitle("k", for: .normal)
                                self.buttons[8].setTitle("b", for: .normal)
                                self.buttons[9].setTitle("n", for: .normal)
                                self.buttons[10].setTitle("m", for: .normal)
                                self.buttons[11].setTitle("l", for: .normal)
                            } else if self.hstate == 2 {
                                self.buttons[0].setTitle("!", for: .normal)
                                self.buttons[1].setTitle("#", for: .normal)
                                self.buttons[2].setTitle("'", for: .normal)
                                self.buttons[3].setTitle(",", for: .normal)
                                self.buttons[12].setTitle(".", for: .normal)
                                self.buttons[4].setTitle("\"", for: .normal)
                                self.buttons[5].setTitle("?", for: .normal)
                                self.buttons[6].setTitle("(", for: .normal)
                                self.buttons[7].setTitle(")", for: .normal)
                                self.buttons[8].setTitle(";", for: .normal)
                                self.buttons[9].setTitle(":", for: .normal)
                                self.buttons[10].setTitle("@", for: .normal)
                                self.buttons[11].setTitle("$", for: .normal)
                            }
                        }
                        self.nav_left.alpha = 1
                        self.nav_left.frame.origin.x += 5
                        self.nav_right.alpha = 1
                        self.nav_right.frame.origin.x += 5
                    }, completion: nil)
                })
                
            }
                //switch to number mode
            else if sender.direction == .up {
                whether_num = true
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
                    
                    for bt in self.buttons {
                        bt.alpha = 0
                        bt.frame.origin.y -= 60
                    }
                    for bt in self.predWords{
                        bt.alpha = 0
                        bt.frame.origin.y -= 60
                    }
                    for arrow in self.nav_arrows{
                        arrow.alpha = 0
                        arrow.frame.origin.y -= 5
                    }
                }, completion: { (finished: Bool) in
                    
                    for arrow in self.nav_arrows{
                        arrow.setTitle("", for: .normal)
                    }
                    if(self.hstate == 0){
                        self.nav_up.setTitle("qwert", for: .normal)
                    }
                    else if(self.hstate == 1){
                        self.nav_up.setTitle("yuiop", for: .normal)
                    }
                    else{
                        self.nav_up.setTitle("!@$.?", for: .normal)
                    }
                    
                    
                    // buttons being removed
                    for arrow in self.nav_arrows{
                        arrow.alpha = 0
                        arrow.frame.origin.y += 10
                    }
                    for bt in self.predWords{
                        bt.alpha = 0
                        bt.frame.origin.y += 60
                        bt.removeFromSuperview()
                    }
                    self.buttons[12].alpha = 0
                    self.buttons[12].removeFromSuperview()
                    
                    // change keys
                    self.buttons[0].setTitle("1", for: .normal)
                    self.buttons[1].setTitle("4", for: .normal)
                    self.buttons[2].setTitle("7", for: .normal)
                    self.buttons[3].setTitle(".", for: .normal)
                    self.buttons[4].setTitle("2", for: .normal)
                    self.buttons[5].setTitle("5", for: .normal)
                    self.buttons[6].setTitle("8", for: .normal)
                    self.buttons[7].setTitle("0", for: .normal)
                    self.buttons[8].setTitle("3", for: .normal)
                    self.buttons[9].setTitle("6", for: .normal)
                    self.buttons[10].setTitle("9", for: .normal)
                    self.buttons[11].setTitle("Sign", for: .normal)
                    // reformat keys
                    var iter: Int = 0
                    //let tl = self.Cap.frame.origin.y
                    let tl = self.Delete.frame.origin.y
                    
                    while iter < 12 {
                        var column: Int = 0
                        if iter < 4 {
                            column = 0
                        } else if iter < 8 {
                            column = 1
                        } else {
                            column = 2
                        }
                        // self.buttons[iter].frame = CGRect(x: 100 + 110 * CGFloat(column), y: tl + CGFloat(100 * (iter % 4)), width: 90, height: 90)
                        self.buttons[iter].frame = CGRect(x: self.view.frame.maxX / 2 - 110 + 110 * CGFloat(column), y: tl + CGFloat(100 * (iter % 4)), width: 90, height: 90)
                        iter += 1
                    }
                    
                    for bt in self.buttons {
                        bt.alpha = 0
                        bt.frame.origin.y += 120
                    }
                    
                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
                        for bt in self.buttons {
                            bt.alpha = 1
                            bt.frame.origin.y -= 60
                        }
                        for arrow in self.nav_arrows{
                            arrow.alpha = 1
                            arrow.frame.origin.y -= 5
                        }
                        
                        
                    }, completion: nil)
                })
                mode = 1
            }
        } else if mode == 1 {
            //switch to alpha mode
            if sender.direction == .down {
                whether_num = false
                
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
                    
                    for bt in self.buttons[0...11] {
                        bt.alpha = 0
                        bt.frame.origin.y += 60
                    }
                    for arrow in self.nav_arrows{
                        arrow.alpha = 0
                        arrow.frame.origin.y += 5
                    }
                }, completion: { (finished: Bool) in
                    
                    self.nav_down.setTitle("#", for: .normal)
                    self.nav_up.setTitle("", for: .normal)
                    if(self.hstate == 0){
                        self.nav_left.setTitle("!@$.?", for: .normal)
                        self.nav_right.setTitle("yuiop", for: .normal)
                    }
                    else if(self.hstate == 1){
                        self.nav_left.setTitle("qwert", for: .normal)
                        self.nav_right.setTitle("!@$.?", for: .normal)
                    }
                    else{
                        self.nav_left.setTitle("yuiop", for: .normal)
                        self.nav_right.setTitle("qwert", for: .normal)
                    }
                    
                    // change buttons
                    if self.hstate == 0 {
                        self.buttons[0].setTitle("q", for: .normal)
                        self.buttons[1].setTitle("w", for: .normal)
                        self.buttons[2].setTitle("e", for: .normal)
                        self.buttons[3].setTitle("r", for: .normal)
                        self.buttons[12].setTitle("t", for: .normal)
                        self.buttons[4].setTitle("a", for: .normal)
                        self.buttons[5].setTitle("s", for: .normal)
                        self.buttons[6].setTitle("d", for: .normal)
                        self.buttons[7].setTitle("f", for: .normal)
                        self.buttons[8].setTitle("z", for: .normal)
                        self.buttons[9].setTitle("x", for: .normal)
                        self.buttons[10].setTitle("c", for: .normal)
                        self.buttons[11].setTitle("v", for: .normal)
                    } else if self.hstate == 1 {
                        self.buttons[0].setTitle("y", for: .normal)
                        self.buttons[1].setTitle("u", for: .normal)
                        self.buttons[2].setTitle("i", for: .normal)
                        self.buttons[3].setTitle("o", for: .normal)
                        self.buttons[4].setTitle("g", for: .normal)
                        self.buttons[12].setTitle("p", for: .normal)
                        self.buttons[5].setTitle("h", for: .normal)
                        self.buttons[6].setTitle("j", for: .normal)
                        self.buttons[7].setTitle("k", for: .normal)
                        self.buttons[8].setTitle("b", for: .normal)
                        self.buttons[9].setTitle("n", for: .normal)
                        self.buttons[10].setTitle("m", for: .normal)
                        self.buttons[11].setTitle("l", for: .normal)
                    } else if self.hstate == 2 {
                        self.buttons[0].setTitle("!", for: .normal)
                        self.buttons[1].setTitle("#", for: .normal)
                        self.buttons[2].setTitle("'", for: .normal)
                        self.buttons[3].setTitle(",", for: .normal)
                        self.buttons[12].setTitle(".", for: .normal)
                        self.buttons[4].setTitle("\"", for: .normal)
                        self.buttons[5].setTitle("?", for: .normal)
                        self.buttons[6].setTitle("(", for: .normal)
                        self.buttons[7].setTitle(")", for: .normal)
                        self.buttons[8].setTitle(";", for: .normal)
                        self.buttons[9].setTitle(":", for: .normal)
                        self.buttons[10].setTitle("@", for: .normal)
                        self.buttons[11].setTitle("$", for: .normal)
                    }
                    //reformat
                    var iter: Int = 0
                    while iter < 12 {
                        var row: Int = 0
                        if iter < 4 {
                            row = -1
                        } else if iter < 8 {
                            row = 0
                        } else {
                            row = 1
                        }
                        self.buttons[iter].frame = CGRect(x: self.centerArray[iter % 4].x, y: self.centerArray[iter % 4].y + CGFloat(100 * row), width: 90, height: 90)
                        iter += 1
                    }
                    self.view.addSubview(self.buttons[12])
                    for bt in self.buttons {
                        bt.alpha = 0
                        bt.frame.origin.y -= 60
                    }
                    for pred in self.predWords {
                        self.view.addSubview(pred)
                        pred.alpha = 0
                        pred.frame.origin.y -= 60
                    }
                    for arrow in self.nav_arrows{
                        arrow.alpha = 0
                        arrow.frame.origin.y -= 10
                    }
                    
                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
                        for bt in self.buttons {
                            bt.alpha = 1
                            bt.frame.origin.y += 60
                        }
                        for bt in self.predWords {
                            bt.alpha = 1
                            bt.frame.origin.y += 60
                        }
                        for arrow in self.nav_arrows{
                            arrow.alpha = 1
                            arrow.frame.origin.y += 5
                        }
                    }, completion: nil)
                })
                mode = 0
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCenterArray(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, x3: CGFloat, y3: CGFloat, x4: CGFloat, y4: CGFloat) {
        let tempCenter1: center = center(mx: x1, my: y1)
        centerArray.append(tempCenter1)
        let tempCenter2: center = center(mx: x2, my: y2)
        centerArray.append(tempCenter2)
        let tempCenter3: center = center(mx: x3, my: y3)
        centerArray.append(tempCenter3)
        let tempCenter4: center = center(mx: x4, my: y4)
        centerArray.append(tempCenter4)
    }
    
    func setButton() {
        /*inputText = UILabel(frame: CGRect(x: 44, y: 75, width: 680.5, height: 96))
         inputText.textAlignment = .left
         inputText.font = UIFont(name: "", size: 45)
         inputText.text = ""
         inputText.backgroundColor = UIColor.white
         self.view.addSubview(inputText)*/
        
        let defaults = UserDefaults.standard
        let thumb_center = CGFloat(defaults.float(forKey: "thumb"))
        
        var iter: Int = 0
        // setup normal keys
        while iter < 13 {
            var row: Int = 0
            if iter < 4 {
                row = -1
            } else if iter < 8 {
                row = 0
            } else if iter < 12 {
                row = 1
            } else if iter == 12{
                row = 2
            }
            let bt = PressableButton()
            //print(centerArray.count)
            if iter < 12{
                bt.frame = CGRect(x: centerArray[iter % 4].x, y: centerArray[iter % 4].y, width: 90, height: 90) // jingyu
            } else if iter == 12{
                bt.frame = CGRect(x: centerArray[3].x, y: centerArray[3].y, width: 90, height: 90) // jingyu
            }
            bt.shadowHeight = 8
            bt.cornerRadius = 20
            
            // transition of the button:
            
            bt.addTarget(self, action: #selector(pressCharacter(_:)), for: .touchUpInside)
            if row == -1 {
                if iter % 4 == 0 {
                    bt.setTitle("q", for: .normal)
                } else if iter % 4 == 1 {
                    bt.setTitle("w", for: .normal)
                } else if iter % 4 == 2 {
                    bt.setTitle("e", for: .normal)
                } else {
                    bt.setTitle("r", for: .normal)
                }
            } else if row == 0 {
                if iter % 4 == 0 {
                    bt.setTitle("a", for: .normal)
                } else if iter % 4 == 1 {
                    bt.setTitle("s", for: .normal)
                } else if iter % 4 == 2 {
                    bt.setTitle("d", for: .normal)
                } else {
                    bt.setTitle("f", for: .normal)
                }
            } else if row == 1{
                if iter % 4 == 0 {
                    bt.setTitle("z", for: .normal)
                } else if iter % 4 == 1 {
                    bt.setTitle("x", for: .normal)
                } else if iter % 4 == 2 {
                    bt.setTitle("c", for: .normal)
                } else {
                    bt.setTitle("v", for: .normal)
                }
            } else if row == 2{
                bt.setTitle("t", for: .normal)
            }
            bt.layer.cornerRadius = bt.frame.height / 2
            
            bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
            
            buttons.append(bt)
            self.view.addSubview(bt)
            
            //            UIView.animate(withDuration: 0.3, delay: 1, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
            //                bt.alpha = 1
            //                bt.frame.origin.y += CGFloat(100 * row)
            //            }, completion: nil)
            //
            iter += 1
        }
        
        //let vLine = lineView(frame: CGRect(x: buttons[7].frame.origin.x + 120, y: 204, width: 197, height: 819)) // jingyu
        //vLine.backgroundColor = UIColor.lightGray // jingyu
        //self.view.addSubview(vLine) // jingyu
        
        let center_y = centerArray.sorted(by: {$0.y < $1.y})[0].y
        var benchmark : CGFloat
        var go_back_benchmark_x : CGFloat
        var go_back_benchmark_y : CGFloat
        if center_y < 400 {
            benchmark = center_y - 200
            go_back_benchmark_x = buttons[7].frame.origin.x + 120 // jingyu
            go_back_benchmark_y = self.view.frame.height - 150
        } else if center_y < self.view.frame.height - 450{
            benchmark = center_y - 300
            go_back_benchmark_x = buttons[7].frame.origin.x + 120 // jingyu
            go_back_benchmark_y = self.view.frame.height - 150
        } else {
            benchmark = center_y - 400
            go_back_benchmark_x = buttons[7].frame.origin.x + 120 // jingyu
            go_back_benchmark_y = 44
        }
        
        
        /*SwitchMode = PressableButton()
         //        SwitchMode.backgroundColor = UIColor.green
         //        SwitchMode.setTitleColor(UIColor.blue, for: .normal)
         SwitchMode.frame = CGRect(x: buttons[7].frame.origin.x + 100, y: benchmark - 100, width: 100, height: 90)
         SwitchMode.colors = .init(
         button: UIColor(red: 80 / 255, green: 90 / 255, blue: 100 / 255, alpha: 1),
         shadow: UIColor(red: 50 / 255, green: 60 / 255, blue: 50 / 255, alpha: 1)
         )
         
         SwitchMode.shadowHeight = 8
         SwitchMode.cornerRadius = 16 */
        
        
        mouseButton = PressableButton()
        //        SwitchMode.backgroundColor = UIColor.green
        //        SwitchMode.setTitleColor(UIColor.blue, for: .normal)
        // mouseButton.frame = CGRect(x: buttons[7].frame.origin.x + 120, y: benchmark, width: 100, height: 90) // jingyu
        mouseButton.frame = CGRect(x: thumb_center - 50, y: benchmark + 100, width: 100, height: 90) // jingyu
        mouseButton.colors = .init(
            button: UIColor(red: 52 / 255, green: 125 / 255, blue: 219 / 255, alpha: 1),
            shadow: UIColor(red: 38 / 255, green: 116 / 255, blue: 168 / 255, alpha: 1)
        )
        
        mouseButton.setTitle("🖱️", for: .normal)
        mouseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        mouseButton.addTarget(self, action: #selector(pressMouse(_:)), for: .touchUpInside)
        mouseButton.shadowHeight = 8
        mouseButton.cornerRadius = 16
        
        self.view.addSubview(mouseButton)
        //SwitchMode.setTitle("Switch", for: .normal)
        //SwitchMode.addTarget(self, action: #selector(pressMode(_:)), for: .touchUpInside)
        //self.view.addSubview(SwitchMode)
        
        Cap = PressableButton()
        //        Cap.backgroundColor = UIColor.gray
        //        Cap.setTitleColor(UIColor.white, for: .normal)
        // Cap.frame = CGRect(x: buttons[7].frame.origin.x + 120, y: benchmark + 100, width: 100, height: 90) // jingyu
        Cap.frame = CGRect(x: thumb_center - 50, y: benchmark + 200, width: 100, height: 90) // jingyu
        Cap.colors = .init(
            button: UIColor(red: 41 / 255, green: 128 / 255, blue: 185 / 255, alpha: 1),
            shadow: UIColor(red: 31 / 255, green: 95 / 255, blue: 137 / 255, alpha: 1)
        )
        
        Cap.shadowHeight = 8
        Cap.cornerRadius = 16
        
        Cap.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        Cap.addTarget(self, action: #selector(pressCap(_:)), for: .touchUpInside)
        Cap.setTitle("cap", for: .normal)
        self.view.addSubview(Cap)
        
        Delete = PressableButton()
        //        Delete.setTitleColor(UIColor.white, for: .normal)
        // Delete.frame = CGRect(x: buttons[7].frame.origin.x + 120, y: benchmark + 200, width: 100, height: 90) // jingyu
        Delete.frame = CGRect(x: thumb_center - 50, y: benchmark, width: 100, height: 90) // jingyu
        Delete.colors = .init(
            button: UIColor(red: 229 / 255, green: 80 / 255, blue: 57 / 255, alpha: 1),
            shadow: UIColor(red: 175 / 255, green: 57 / 255, blue: 36 / 255, alpha: 1)
        ) // jingyu add color
        Delete.shadowHeight = 8
        Delete.cornerRadius = 16
        Delete.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        // Delete.addTarget(self, action: #selector(pressDelete(_:)), for: .touchUpInside)
        Delete.addTarget(self, action: #selector(buttonDown(_:)), for: .touchDown)
        Delete.addTarget(self, action: #selector(buttonUp(_:)), for: [.touchUpInside, .touchUpOutside])
        Delete.setTitle("Del", for: .normal)
        self.view.addSubview(Delete)
        
        Space = PressableButton()
        //        Space.backgroundColor = UIColor.white
        //        Space.setTitleColor(UIColor.black, for: .normal)
        Space.frame = CGRect(x: thumb_center - 50, y: benchmark + 300, width: 100, height: 130) // jingyu
        Space.colors = .init(
            // button: UIColor(red: 39 / 255, green: 174 / 255, blue: 96 / 255, alpha: 1),
            // shadow: UIColor(red: 25 / 255, green: 112 / 255, blue: 61 / 255, alpha: 1)
            button: UIColor(red: 73 / 255, green: 85 / 255, blue: 89 / 255, alpha: 1), // jingyu
            shadow: UIColor(red: 40 / 255, green: 42 / 255, blue: 45 / 255, alpha: 1) // jingyu
        )
        
        Space.shadowHeight = 8
        Space.cornerRadius = 16
        Space.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        Space.addTarget(self, action: #selector(pressSpace(_:)), for: .touchUpInside)
        Space.setTitle("Space", for: .normal)
        self.view.addSubview(Space)
        
        Enter = PressableButton()
        //        Enter.backgroundColor = UIColor.gray
        //        Enter.setTitleColor(UIColor.white, for: .normal)
        Enter.frame = CGRect(x: thumb_center - 50, y: benchmark + 450, width: 100, height: 130) // jingyu
        
        Enter.colors = .init(
            button: UIColor(red: 73 / 255, green: 85 / 255, blue: 89 / 255, alpha: 1),
            shadow: UIColor(red: 40 / 255, green: 42 / 255, blue: 45 / 255, alpha: 1)
        )
        Enter.shadowHeight = 8
        Enter.cornerRadius = 16
        Enter.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        Enter.addTarget(self, action: #selector(pressEnter(_:)), for: .touchUpInside)
        Enter.setTitle("Enter", for: .normal)
        self.view.addSubview(Enter)
        
        Helper = PressableButton()
        Helper.frame = CGRect(x: thumb_center - 25, y: benchmark - 75, width: 50, height: 50) // jingyu
        Helper.colors = .init(
            button: UIColor(red: 73 / 255, green: 85 / 255, blue: 89 / 255, alpha: 1), // jingyu
            shadow: UIColor(red: 40 / 255, green: 42 / 255, blue: 45 / 255, alpha: 1) // jingyu
        )
        Helper.shadowHeight = 0
        Helper.cornerRadius = 25
        Helper.addTarget(self, action: #selector(pressHelper(_:)), for: .touchUpInside)
        Helper.setTitle("?", for: .normal)
        Helper.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        self.view.addSubview(Helper)
        
        goBack = PressableButton()
        //        goBack.backgroundColor = UIColor.red
        //        goBack.setTitleColor(UIColor.white, for: .normal)
        goBack.frame = CGRect(x: thumb_center - 50, y: go_back_benchmark_y, width: 100, height: 90)
        goBack.addTarget(self, action: #selector(pressGoBack(_:)), for: .touchUpInside)
        goBack.setTitle("Configure", for: .normal)
        goBack.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.view.addSubview(goBack)
        
        iter = 0
        let pred_width = (buttons[3].frame.origin.x - buttons[0].frame.origin.x + 80) / 2 // jingyu
        while iter < 4 {
            let bt = UIButton()
            //bt.backgroundColor = UIColor.gray
            bt.backgroundColor = UIColor(red: 73 / 255, green: 85 / 255, blue: 89 / 255, alpha: 1)
            
            bt.setTitleColor(UIColor.white, for: .normal)
            bt.frame = CGRect(x: Int(buttons[0].frame.origin.x + CGFloat(iter % 2) * pred_width),
                              y: Int(center_y - 300 + CGFloat((iter / 2) * 52)), width: Int(pred_width - 2), height: 50)
            bt.addTarget(self, action: #selector(pressWord(_:)), for: .touchUpInside)
            //bt.setTitle("predWord" + String(iter), for: .normal)
            bt.setTitle("", for: .normal)
            //bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
            predWords.append(bt)
            self.view.addSubview(bt)
            iter += 1
        }
        
        // setup navigational buttons
        let nav_bt_size = CGFloat(55)
        let nav_bt_x = (buttons[3].frame.origin.x + buttons[0].frame.origin.x + pred_width - nav_bt_size) / 2
        //let nav_bt_y = view.frame.maxY - (2.5 * nav_bt_size)
        
        var nav_bt_y = CGFloat(0.0)
        if go_back_benchmark_y >= self.view.frame.height / 2 {
            nav_bt_y = go_back_benchmark_y
        } else {
            nav_bt_y = go_back_benchmark_y + nav_bt_size
        }
        
        let bt = UIButton()
        bt.backgroundColor = UIColor.black
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.frame = CGRect(x: Int(nav_bt_x), y: Int(nav_bt_y), width: Int(nav_bt_size), height: Int(nav_bt_size))
        bt.layer.cornerRadius = 0.5 * bt.bounds.size.width
        bt.clipsToBounds = true
        bt.setTitle("Swipe", for: .normal)
        self.view.addSubview(bt)
        // arrows for character modes
        let up_arrow = UIButton()
        up_arrow.setTitleColor(UIColor.white, for: .normal)
        up_arrow.frame = CGRect(x: Int(nav_bt_x), y: Int(nav_bt_y - nav_bt_size - 2), width: Int(nav_bt_size), height: Int(nav_bt_size))
        up_arrow.setTitle("", for: .normal)
        nav_arrows.append(up_arrow)
        nav_up = up_arrow
        
        let down_arrow = UIButton()
        down_arrow.setTitleColor(UIColor.white, for: .normal)
        down_arrow.frame = CGRect(x: Int(nav_bt_x), y: Int(nav_bt_y + nav_bt_size + 2), width: Int(nav_bt_size), height: Int(nav_bt_size))
        down_arrow.setTitle("#", for: .normal)
        nav_arrows.append(down_arrow)
        nav_down = down_arrow
        
        let right_arrow = UIButton()
        right_arrow.setTitleColor(UIColor.white, for: .normal)
        right_arrow.frame = CGRect(x: Int(nav_bt_x + nav_bt_size + 2), y: Int(nav_bt_y), width: Int(nav_bt_size), height: Int(nav_bt_size))
        right_arrow.setTitle("yuiop", for: .normal)
        nav_arrows.append(right_arrow)
        nav_right = right_arrow
        
        let left_arrow = UIButton()
        left_arrow.setTitleColor(UIColor.white, for: .normal)
        left_arrow.frame = CGRect(x: Int(nav_bt_x - nav_bt_size - 2), y: Int(nav_bt_y), width: Int(nav_bt_size), height: Int(nav_bt_size))
        left_arrow.setTitle("!@$.?", for: .normal)
        nav_arrows.append(left_arrow)
        nav_left = left_arrow
        
        for arrow in nav_arrows{
            self.view.addSubview(arrow)
        }
    }
    
    func postRequest(text : String) -> Bool {
        if let tmp_url = self.ip {
            let url = URL(string: "http://" + tmp_url + ":3000/input/" + text)!
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
            return false
        }
        return true
    }
    
    func postPred(text: String) -> Bool {
        if let tmp_url = self.ip {
            let url = URL(string: "http://" + tmp_url + ":3000/pred/" + text)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
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
                        //print("in")
                        //print(json)
                        // pred_string_list = a;b;... at most four
                        //var pred_line = json["pred"] as? String
                        // TODO: parse and update predWords button texts
                        //print(pred_line!.split(separator: ";"))
                        var pred_line = json["pred"] as? String
                        let end = pred_line!.split(separator: ";").count
                        var it = 0
                        self.words = []
                        while it < end {
                            self.words.append(String(pred_line!.split(separator: ";")[it]))
                            it += 1
                        }
                        while it < 4 {
                            self.words.append("")
                            it += 1
                        }
                        //print(self.words)
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        } else {
            return false
        }
        return true
    }
    
    @objc func buttonDown(_ sender: UIButton) {
        singleDelete()
        deleteTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(rapidDelete), userInfo: nil, repeats: true)
    }
    
    @objc func buttonUp(_ sender: UIButton) {
        deleteTimer?.invalidate()
    }
    
    func updatePredWords(time: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(time), execute: {
            // Put your code which should be executed with a delay here
            let end = self.words.count
            var it = 0
            var flag = 0
            while it < end {
                //print("============")
                //print(self.words[it])
                if self.words[it] == "``" {
                    flag += 1
                } else if self.words[it] != "" {
                    self.predWords[it - flag].setTitle(self.words[it], for: .normal)
                } else {
                    self.predWords[it - flag].setTitle(" ", for: .normal)
                }
                //print(self.predWords[it].titleLabel!.text!)
                it += 1
            }
            /*print(self.predWords[0].titleLabel!.text!)
            print(self.predWords[1].titleLabel!.text!)
            print(self.predWords[2].titleLabel!.text!)
            print(self.predWords[3].titleLabel!.text!)*/
        })
    }
    
    @objc func pressCharacter(_ sender: UIButton) {
        print("\(sender.titleLabel!.text!) pressed")
        if sender.titleLabel!.text! == "Sign" {
            buttons[0].setTitle("+", for: .normal)
            buttons[1].setTitle("-", for: .normal)
            buttons[2].setTitle("*", for: .normal)
            buttons[3].setTitle("/", for: .normal)
            buttons[4].setTitle("<", for: .normal)
            buttons[5].setTitle(">", for: .normal)
            buttons[6].setTitle("%", for: .normal)
            buttons[7].setTitle("(", for: .normal)
            buttons[8].setTitle(")", for: .normal)
            buttons[9].setTitle("{", for: .normal)
            buttons[10].setTitle("}", for: .normal)
            buttons[11].setTitle("Num", for: .normal)
        } else if sender.titleLabel!.text! == "Num" {
            buttons[0].setTitle("1", for: .normal)
            buttons[1].setTitle("4", for: .normal)
            buttons[2].setTitle("7", for: .normal)
            buttons[3].setTitle(".", for: .normal)
            buttons[4].setTitle("2", for: .normal)
            buttons[5].setTitle("5", for: .normal)
            buttons[6].setTitle("8", for: .normal)
            buttons[7].setTitle("0", for: .normal)
            buttons[8].setTitle("3", for: .normal)
            buttons[9].setTitle("6", for: .normal)
            buttons[10].setTitle("9", for: .normal)
            buttons[11].setTitle("Sign", for: .normal)
        } else {
            //inputText.text! += sender.titleLabel!.text!
            if sender.titleLabel!.text! == "%" {
                postRequest(text: "key_percent")
            } else if sender.titleLabel!.text! == "\"" {
                postRequest(text: "key_quotation")
            } else if sender.titleLabel!.text! == "?" {
                postRequest(text: "key_question")
            } else if sender.titleLabel!.text! == "<" {
                postRequest(text: "key_less")
            } else if sender.titleLabel!.text! == ">" {
                postRequest(text: "key_more")
            } else if sender.titleLabel!.text! == "{" {
                postRequest(text: "key_lbracket")
            } else if sender.titleLabel!.text! == "}" {
                postRequest(text: "key_rbracket")
            } else if sender.titleLabel!.text! == "/" {
                postRequest(text: "key_slash")
            } else if sender.titleLabel!.text! == "!" {
                postRequest(text: "key_exclam")
            } else if sender.titleLabel!.text! == "#" {
                postRequest(text: "key_hashtag")
            } else {
                postRequest(text: sender.titleLabel!.text!)
            }
            //debug()
            if isAlpha(text: sender.titleLabel!.text!) {
                // update str2
                str2 += sender.titleLabel!.text!
                if str1.count == 0 {
                    // autocomplete using one word
                    postPred(text: str2)
                    pred_flag = 0
                } else {
                    // autocomplete using two words
                    postPred(text: str1 + "_" + str2)
                    pred_flag = 0
                }
                updatePredWords(time: 300)
            }
            //debug()
        }
    }
    
    func singleDelete() {
        print("Delete pressed")
        postRequest(text: "key_delete")
        /*if inputText.text!.count > 0 {
         inputText.text!.remove(at: inputText.text!.index(before: inputText.text!.endIndex))
         }*/
        //debug()
        if str2.count > 0 {
            str2.remove(at: str2.index(before: str2.endIndex))
            if str2.count > 0 {
                if str1.count == 0 {
                    // autocomplete using one word
                    postPred(text: str2)
                    pred_flag = 0
                } else {
                    // autocomplete using two words
                    postPred(text: str1 + "_" + str2)
                    pred_flag = 0
                }
                updatePredWords(time: 300)
            } else {
                if str1.count > 0 {
                    // predict next word using one word
                    postPred(text: str1 + "_")
                    pred_flag = 1
                    updatePredWords(time: 300)
                } else {
                    self.words = []
                    var it = 0
                    while it < 4 {
                        self.words.append("")
                        it += 1
                    }
                    updatePredWords(time: 0)
                }
            }
        } else {
            if str1.count > 0 {
                // delete a space
                // autocomplete using one word
                str2 = str1
                str1 = ""
                postPred(text: str2)
                pred_flag = 0
                updatePredWords(time: 300)
            } 
        }
    }
    
    @objc func rapidDelete() {
        print("Delete pressed")
        postRequest(text: "key_delete")
        /*if inputText.text!.count > 0 {
         inputText.text!.remove(at: inputText.text!.index(before: inputText.text!.endIndex))
         }*/
        //debug()
        if str2.count > 0 {
            str2.remove(at: str2.index(before: str2.endIndex))
            if str2.count > 0 {
                if str1.count == 0 {
                    // autocomplete using one word
                    postPred(text: str2)
                    pred_flag = 0
                } else {
                    // autocomplete using two words
                    postPred(text: str1 + "_" + str2)
                    pred_flag = 0
                }
                updatePredWords(time: 300)
            } else {
                if str1.count > 0 {
                    // predict next word using one word
                    postPred(text: str1 + "_")
                    pred_flag = 1
                    updatePredWords(time: 300)
                } else {
                    self.words = []
                    var it = 0
                    while it < 4 {
                        self.words.append("")
                        it += 1
                    }
                    updatePredWords(time: 0)
                }
            }
        } else {
            if str1.count > 0 {
                // delete a space
                // autocomplete using one word
                str2 = str1
                str1 = ""
                postPred(text: str2)
                pred_flag = 0
                updatePredWords(time: 300)
            }
        }
    }
    
    @objc func pressDelete(_ sender: UIButton) {
        print("\(sender.titleLabel!.text!) pressed")
        postRequest(text: "key_delete")
        /*if inputText.text!.count > 0 {
         inputText.text!.remove(at: inputText.text!.index(before: inputText.text!.endIndex))
         }*/
        //debug()
        if str2.count > 0 {
            str2.remove(at: str2.index(before: str2.endIndex))
            if str2.count > 0 {
                if str1.count == 0 {
                    // autocomplete using one word
                    postPred(text: str2)
                    pred_flag = 0
                } else {
                    // autocomplete using two words
                    postPred(text: str1 + "_" + str2)
                    pred_flag = 0
                }
                updatePredWords(time: 300)
            } else {
                if str1.count > 0 {
                    // predict next word using one word
                    postPred(text: str1 + "_")
                    pred_flag = 1
                    updatePredWords(time: 300)
                }
            }
        } else {
            if str1.count > 0 {
                // delete a space
                // autocomplete using one word
                str2 = str1
                str1 = ""
                postPred(text: str2)
                pred_flag = 0
                updatePredWords(time: 300)
            }
        }
        //debug()
    }
    
    @objc func pressSpace(_ sender: UIButton) {
        print("\(sender.titleLabel!.text!) pressed")
        postRequest(text: "key_space")
        /*inputText.text! += " "*/
        //debug()
        if str2.count > 0 {
            pred_flag = 1
            if str1.count == 0 {
                // predict for next word using one word
                postPred(text: str2 + "_")
            } else {
                // predict for next word using two words
                postPred(text: str1 + "_" + str2 + "_")
            }
            str1 = str2
            str2 = ""
            updatePredWords(time: 300)
            // Predicate word should later go directly to str2
        } else {
            // fix two successive space
            if str1.count > 0 {
                str1 = ""
                str2 = ""
                pred_flag = -1
            }
        }
        //debug()
    }
    
    @objc func pressCap(_ sender: UIButton) {
        print("\(sender.titleLabel!.text!) pressed")
        isCapped = 1 - isCapped
        if isCapped == 1 {
            Cap.setTitle("CAP", for: .normal)
            for bt in buttons {
                if isAlpha(text: bt.titleLabel!.text!) {
                    bt.setTitle(bt.titleLabel!.text!.uppercased(), for: .normal)
                }
            }
        } else {
            Cap.setTitle("cap", for: .normal)
            for bt in buttons {
                if isAlpha(text: bt.titleLabel!.text!) {
                    bt.setTitle(bt.titleLabel!.text!.lowercased(), for: .normal)
                }
            }
        }
    }
    
    func isAlpha(text: String) -> Bool {
        let letters = CharacterSet.letters
        for uni in text.unicodeScalars {
            if letters.contains(uni) {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    @objc func pressEnter(_ sender: UIButton) {
        print("\(sender.titleLabel!.text!) pressed")
        /*inputText.text! += "\n"*/
        postRequest(text: "key_newline")
        str1 = ""
        str2 = ""
        //debug()
        pred_flag = -1
        //debug()
    }
    
    
    @objc func pressMode(_ sender: UIButton) {
        print("Mode switch")
        for bt in modes {
            self.view.addSubview(bt)
        }
        for bt in buttons {
            bt.removeFromSuperview()
        }
        for bt in predWords {
            bt.removeFromSuperview()
        }
        Space.removeFromSuperview()
        Delete.removeFromSuperview()
        Enter.removeFromSuperview()
        Cap.removeFromSuperview()
        goBack.removeFromSuperview()
        //SwitchMode.removeFromSuperview()
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = mouseButton.center
        transition.duration = 0.3
        transition.bubbleColor = UIColor(red: 229 / 255, green: 81 / 255, blue: 55 / 255, alpha: 1)
        
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = mouseButton.center
        transition.duration = 0.3
        transition.bubbleColor = UIColor(red: 229 / 255, green: 81 / 255, blue: 55 / 255, alpha: 1)
        
        return transition
    }
    
    @objc func pressMouse(_ sender: UIButton) {
        let keyView = MouseView()
        keyView.transitioningDelegate = self
        keyView.modalPresentationStyle = .custom
        
        if let tmp_ip = self.ip {
            keyView.setpos(x1: self.mouseButton.center.x - 50, y1: self.mouseButton.center.y - 45, inner_ip: tmp_ip)
        }
        else {
            keyView.setpos(x1: self.mouseButton.center.x - 50, y1: self.mouseButton.center.y - 45, inner_ip: "")
            getip()
        }
        
        self.present(keyView, animated: true, completion: nil)
    }
    
    @objc func pressHelper(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "isAppAlreadyLaunchedOnce")
        let keyView = Tutorial(nibName: nil, bundle: nil)
        keyView.modalTransitionStyle = .crossDissolve
        self.present(keyView, animated: true, completion: nil)
    }
    
    @objc func pressGoBack(_ sender: UIButton) {
        // TODO: defaults may not be deleted at once
        /*let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "p0_x")
        defaults.removeObject(forKey: "p0_y")
        defaults.removeObject(forKey: "p1_x")
        defaults.removeObject(forKey: "p1_y")
        defaults.removeObject(forKey: "p2_x")
        defaults.removeObject(forKey: "p2_y")
        defaults.removeObject(forKey: "p3_x")
        defaults.removeObject(forKey: "p3_y")*/
        let keyView = WelcomeViewController(nibName: nil, bundle: nil)
        keyView.modalTransitionStyle = .crossDissolve
        self.present(keyView, animated: true, completion: nil)
    }
    
    @objc func pressWord(_ sender: UIButton) {
        sender.backgroundColor = .white
        sender.setTitleColor(.black, for: .normal)
        //postRequest(text: sender.titleLabel!.text!)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
            // sender.backgroundColor = .gray
            sender.backgroundColor = UIColor(red: 73 / 255, green: 85 / 255, blue: 89 / 255, alpha: 1)
            sender.setTitleColor(.white, for: .normal)
        })
        //debug()
        if let tmp = sender.titleLabel!.text {
            //print("Word: \(sender.titleLabel!.text!) pressed")
            /*inputText.text! += sender.titleLabel!.text!*/
            print(sender.titleLabel!.text!)
            if sender.titleLabel!.text! == " " {
                // pass
            } else {
                if pred_flag == 1 {
                    // this is the next word
                    str2 = sender.titleLabel!.text!
                    // predict next word using two words
                    postPred(text: str1 + "_" + str2 + "_")
                    
                    //postRequest(text: str2)
                    //postRequest(text: "key_space")
                    postRequest(text: str2 + "_keyspace")
                    str1 = str2
                    str2 = ""
                    pred_flag = 1
                    updatePredWords(time: 300)
                } else if pred_flag == 0 {
                    // this is an autocompletion
                    let fullword = sender.titleLabel!.text!
                    var subString = ""
                    subString = String(fullword.suffix(fullword.count - str2.count))
                    str2 = fullword
                    if str1.count > 0 {
                        // predict next word using two words
                        postPred(text: str1 + "_" + str2 + "_")
                    } else {
                        // predict next word using one word
                        postPred(text: str2 + "_")
                    }
                    
                    //postRequest(text: subString)
                    //postRequest(text: "key_space")
                    postRequest(text: subString + "_keyspace")
                    str1 = str2
                    str2 = ""
                    pred_flag = 1
                    updatePredWords(time: 300)
                } else if pred_flag == -1 {
                    //postRequest(text: sender.titleLabel!.text!)
                    //postRequest(text: "key_space")
                    postRequest(text: sender.titleLabel!.text! + "_keyspace")
                    str1 = sender.titleLabel!.text!
                    postPred(text: str1 + "_")
                    pred_flag = 1
                    updatePredWords(time: 300)
                }
            }
            //debug()
        }
    }
    
    func debug() {
        print(pred_flag)
        if str1 == "" {
            print("empty")
        } else {
            print(str1)
        }
        if str2 == "" {
            print("empty")
        } else {
            print(str2)
        }
    }
}

