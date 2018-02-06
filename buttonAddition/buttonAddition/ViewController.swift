import UIKit

struct center {
    var x: CGFloat
    var y: CGFloat
    init(mx: CGFloat, my: CGFloat) {
        x = mx
        y = my
    }
}

class ViewController: UIViewController {
    
    var inputText: UILabel!
    var buttons: Array<UIButton> = []
    var centerArray: [center] = []
    
    var Space: UIButton!
    var Delete: UIButton!
    var Enter: UIButton!
    
    var Cap: UIButton!
    var isCapped: Int = 0
    
    var SwitchMode: UIButton!
    var vState: Int = 0
    var mode: Int = 0
    
    var goBack: UIButton!
    
    var modes: Array<UIButton> = []
    var predWords: Array<UIButton> = []
    var ip: String?
    
    /*var Button11: UIButton!
    var Button12: UIButton!
    var Button13: UIButton!
    var Button14: UIButton!
    var Button21: UIButton!
    var Button22: UIButton!
    var Button23: UIButton!
    var Button24: UIButton!
    var Button31: UIButton!
    var Button32: UIButton!
    var Button33: UIButton!
    var Button34: UIButton!*/ // This can be also sign in number mode
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getip()
        view.backgroundColor = .lightGray
        setButton()
        let ownerview: UIView = self.view
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(funcForGesture))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(funcForGesture))
        upSwipe.direction = .up
        downSwipe.direction = .down
        ownerview.addGestureRecognizer(upSwipe)
        ownerview.addGestureRecognizer(downSwipe)
    }
    
    func getip() -> String{
        
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
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        
        return "dummy"
    }
    
    
    @objc func funcForGesture(sender: UISwipeGestureRecognizer) {
        if mode == 0 {
            if sender.direction == .up {
                if vState == 2 {
                    vState = 0
                } else {
                    vState += 1
                }
            } else if sender.direction == .down{
                if vState == 0 {
                    vState = 2
                } else {
                    vState -= 1
                }
            }
            if vState == 0 {
                buttons[0].setTitle("q", for: .normal)
                buttons[1].setTitle("w", for: .normal)
                buttons[2].setTitle("e", for: .normal)
                buttons[3].setTitle("r", for: .normal)
                buttons[4].setTitle("a", for: .normal)
                buttons[5].setTitle("s", for: .normal)
                buttons[6].setTitle("d", for: .normal)
                buttons[7].setTitle("f", for: .normal)
                buttons[8].setTitle("z", for: .normal)
                buttons[9].setTitle("x", for: .normal)
                buttons[10].setTitle("c", for: .normal)
                buttons[11].setTitle("v", for: .normal)
            } else if vState == 1 {
                buttons[0].setTitle("t", for: .normal)
                buttons[1].setTitle("y", for: .normal)
                buttons[2].setTitle("u", for: .normal)
                buttons[3].setTitle("i", for: .normal)
                buttons[4].setTitle("g", for: .normal)
                buttons[5].setTitle("h", for: .normal)
                buttons[6].setTitle("j", for: .normal)
                buttons[7].setTitle("k", for: .normal)
                buttons[8].setTitle("b", for: .normal)
                buttons[9].setTitle("n", for: .normal)
                buttons[10].setTitle("m", for: .normal)
                buttons[11].setTitle("o", for: .normal)
            } else if vState == 2 {
                buttons[0].setTitle("p", for: .normal)
                buttons[1].setTitle("l", for: .normal)
                buttons[2].setTitle(".", for: .normal)
                buttons[3].setTitle(",", for: .normal)
                buttons[4].setTitle("\"", for: .normal)
                buttons[5].setTitle("?", for: .normal)
                buttons[6].setTitle("(", for: .normal)
                buttons[7].setTitle(")", for: .normal)
                buttons[8].setTitle(";", for: .normal)
                buttons[9].setTitle(":", for: .normal)
                buttons[10].setTitle("@", for: .normal)
                buttons[11].setTitle("$", for: .normal)
            }
        } else if mode == 1 {
            // This is number mode, can add swipe to change vState
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
        inputText = UILabel(frame: CGRect(x: 44, y: 75, width: 680.5, height: 96))
        inputText.textAlignment = .left
        inputText.font = UIFont(name: "", size: 45)
        inputText.text = ""
        inputText.backgroundColor = UIColor.white
        self.view.addSubview(inputText)
        
        var iter: Int = 0
        // setup normal keys
        while iter < 12 {
            var row: Int = 0
            if iter < 4 {
                row = -1
            } else if iter < 8 {
                row = 0
            } else if iter < 12 {
                row = 1
            }
            let bt = UIButton()
            bt.backgroundColor = UIColor.white
            bt.setTitleColor(UIColor.black, for: .normal)
            bt.frame = CGRect(x: centerArray[iter % 4].x, y: centerArray[iter % 4].y + CGFloat(100 * row), width: 80, height: 80)
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
            } else {
                if iter % 4 == 0 {
                    bt.setTitle("z", for: .normal)
                } else if iter % 4 == 1 {
                    bt.setTitle("x", for: .normal)
                } else if iter % 4 == 2 {
                    bt.setTitle("c", for: .normal)
                } else {
                    bt.setTitle("v", for: .normal)
                }
            }
            bt.layer.cornerRadius = bt.frame.height / 2
            buttons.append(bt)
            self.view.addSubview(bt)
            iter += 1
        }
        
        let vLine = lineView(frame: CGRect(x: buttons[7].frame.origin.x + 100, y: 204, width: 197, height: 819))
        vLine.backgroundColor = UIColor.lightGray
        self.view.addSubview(vLine)
        
        Delete = UIButton()
        Delete.backgroundColor = UIColor.red
        Delete.setTitleColor(UIColor.white, for: .normal)
        Delete.frame = CGRect(x: buttons[7].frame.origin.x + 100, y: centerArray.sorted(by: {$0.y < $1.y})[0].y, width: 100, height: 100)
        Delete.addTarget(self, action: #selector(pressDelete(_:)), for: .touchUpInside)
        Delete.setTitle("Del", for: .normal)
        self.view.addSubview(Delete)
        
        Space = UIButton()
        Space.backgroundColor = UIColor.white
        Space.setTitleColor(UIColor.black, for: .normal)
        Space.frame = CGRect(x: buttons[7].frame.origin.x + 100, y: centerArray.sorted(by: {$0.y < $1.y})[0].y + 100, width: 100, height: 150)
        Space.addTarget(self, action: #selector(pressSpace(_:)), for: .touchUpInside)
        Space.setTitle("Space", for: .normal)
        self.view.addSubview(Space)
        
        Cap = UIButton()
        Cap.backgroundColor = UIColor.gray
        Cap.setTitleColor(UIColor.white, for: .normal)
        Cap.frame = CGRect(x: buttons[7].frame.origin.x + 100, y: centerArray.sorted(by: {$0.y < $1.y})[0].y - 100, width: 100, height: 100)
        Cap.addTarget(self, action: #selector(pressCap(_:)), for: .touchUpInside)
        Cap.setTitle("Cap", for: .normal)
        self.view.addSubview(Cap)
        
        Enter = UIButton()
        Enter.backgroundColor = UIColor.gray
        Enter.setTitleColor(UIColor.white, for: .normal)
        Enter.frame = CGRect(x: buttons[7].frame.origin.x + 200, y: centerArray.sorted(by: {$0.y < $1.y})[0].y + 100, width: 100, height: 150)
        Enter.addTarget(self, action: #selector(pressEnter(_:)), for: .touchUpInside)
        Enter.setTitle("Enter", for: .normal)
        self.view.addSubview(Enter)
        
        SwitchMode = UIButton()
        SwitchMode.backgroundColor = UIColor.green
        SwitchMode.setTitleColor(UIColor.blue, for: .normal)
        SwitchMode.frame = CGRect(x: buttons[7].frame.origin.x + 200, y: centerArray.sorted(by: {$0.y < $1.y})[0].y - 100, width: 100, height: 100)
        SwitchMode.setTitle("Mode", for: .normal)
        SwitchMode.addTarget(self, action: #selector(pressMode(_:)), for: .touchUpInside)
        self.view.addSubview(SwitchMode)
        
        goBack = UIButton()
        goBack.backgroundColor = UIColor.red
        goBack.setTitleColor(UIColor.white, for: .normal)
        goBack.frame = CGRect(x: Space.frame.minX, y: self.view.frame.height - 100, width: 100, height: 100)
        goBack.addTarget(self, action: #selector(pressGoBack(_:)), for: .touchUpInside)
        goBack.setTitle("Go back", for: .normal)
        self.view.addSubview(goBack)
        
        iter = 0
        while iter < 4 {
            let bt = UIButton()
            bt.backgroundColor = UIColor.gray
            bt.setTitleColor(UIColor.white, for: .normal)
            bt.frame = CGRect(x: buttons[iter % 4].frame.origin.x - 20, y: buttons[iter % 4].frame.origin.y - 100, width: 100, height: 80)
            bt.addTarget(self, action: #selector(pressWord(_:)), for: .touchUpInside)
            bt.setTitle("predWord" + String(iter), for: .normal)
            predWords.append(bt)
            self.view.addSubview(bt)
            iter += 1
        }
        
        iter = 0
        while iter < 2 {
            let bt = UIButton()
            bt.backgroundColor = UIColor.gray
            bt.setTitleColor(UIColor.black, for: .normal)
            bt.frame = CGRect(x: 150, y: 200 + 150 * iter, width: 100, height: 100)
            bt.addTarget(self, action: #selector(pressSwitchMode(_:)), for: .touchUpInside)
            if iter == 0 {
                bt.setTitle("English", for: .normal)
            } else if iter == 1 {
                bt.setTitle("Number", for: .normal)
            }
            modes.append(bt)
            iter += 1
        }
    }
    
    @objc func pressCharacter(_ sender: UIButton) {
        //        print("\(sender.titleLabel!.text!) pressed")
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
            inputText.text! += sender.titleLabel!.text!
            
            
            if let tmp_url = self.ip {
                let url = URL(string: "http://" + tmp_url + ":3000/input/" + sender.titleLabel!.text!)!
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
                return
            }
        }
    }
    
    @objc func pressDelete(_ sender: UIButton) {
        print("\(sender.titleLabel!.text!) pressed")
        if inputText.text!.count > 0 {
            inputText.text!.remove(at: inputText.text!.index(before: inputText.text!.endIndex))
        }
    }
    
    @objc func pressSpace(_ sender: UIButton) {
        print("\(sender.titleLabel!.text!) pressed")
        inputText.text! += " "
    }
    
    @objc func pressCap(_ sender: UIButton) {
        print("\(sender.titleLabel!.text!) pressed")
        isCapped = 1 - isCapped
        if isCapped == 1 {
            for bt in buttons {
                if isAlpha(text: bt.titleLabel!.text!) {
                    bt.setTitle(bt.titleLabel!.text!.uppercased(), for: .normal)
                }
            }
        } else {
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
        inputText.text! += "\n"
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
        SwitchMode.removeFromSuperview()
    }
    
    @objc func pressSwitchMode(_ sender: UIButton) {
        vState = 0
        if sender.titleLabel!.text! == "English" {
            mode = 0
            buttons[0].setTitle("q", for: .normal)
            buttons[1].setTitle("w", for: .normal)
            buttons[2].setTitle("e", for: .normal)
            buttons[3].setTitle("r", for: .normal)
            buttons[4].setTitle("a", for: .normal)
            buttons[5].setTitle("s", for: .normal)
            buttons[6].setTitle("d", for: .normal)
            buttons[7].setTitle("f", for: .normal)
            buttons[8].setTitle("z", for: .normal)
            buttons[9].setTitle("x", for: .normal)
            buttons[10].setTitle("c", for: .normal)
            buttons[11].setTitle("v", for: .normal)
            
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
                buttons[iter].frame = CGRect(x: centerArray[iter % 4].x, y: centerArray[iter % 4].y + CGFloat(100 * row), width: 80, height: 80)
                iter += 1
            }
            for pred in predWords {
                self.view.addSubview(pred)
            }
        } else if sender.titleLabel!.text! == "Number" {
            mode = 1
            vState = 0
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
            
            var iter: Int = 0
            let tl = Cap.frame.origin.y
            while iter < 12 {
                var column: Int = 0
                if iter < 4 {
                    column = 0
                } else if iter < 8 {
                    column = 1
                } else {
                    column = 2
                }
                buttons[iter].frame = CGRect(x: 100 + 90 * CGFloat(column), y: tl + CGFloat(90 * (iter % 4)), width: 80, height: 80)
                iter += 1
            }
        }
        for bt in buttons {
            self.view.addSubview(bt)
        }
        self.view.addSubview(Space)
        self.view.addSubview(Delete)
        self.view.addSubview(Enter)
        self.view.addSubview(Cap)
        self.view.addSubview(SwitchMode)
        self.view.addSubview(goBack)
        
        for bt in modes {
            bt.removeFromSuperview()
        }
    }
    
    @objc func pressGoBack(_ sender: UIButton) {
        let keyView = WelcomeViewController(nibName: nil, bundle: nil)
        self.present(keyView, animated: true, completion: nil)
    }
    
    @objc func pressWord(_ sender: UIButton) {
        print("Word: \(sender.titleLabel!.text!) pressed")
        inputText.text! += sender.titleLabel!.text!
    }
}
