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
    var Button11: UIButton!
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
    var Button34: UIButton! // This can be also sign in number mode
    var Space: UIButton!
    var Delete: UIButton!
    var Enter: UIButton!
    var Cap: UIButton!
    // isCapped: 0 not on
    //           1 on one time
    var isCapped: Int = 0
    var SwitchMode: UIButton!
    var vState: Int = 0
    var mode: Int = 0
    var modeNum0: UIButton!
    var modeNum1: UIButton!
    var predWord1: UIButton!
    var predWord2: UIButton!
    var predWord3: UIButton!
    var predWord4: UIButton!
    var goBack: UIButton!
    //var Button2Array: [UIButton] = Array(repeating: UIButton(type: .system), count: 4)
    var centerArray: [center] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
                Button11.setTitle("q", for: .normal)
                Button12.setTitle("w", for: .normal)
                Button13.setTitle("e", for: .normal)
                Button14.setTitle("r", for: .normal)
                Button21.setTitle("a", for: .normal)
                Button22.setTitle("s", for: .normal)
                Button23.setTitle("d", for: .normal)
                Button24.setTitle("f", for: .normal)
                Button31.setTitle("z", for: .normal)
                Button32.setTitle("x", for: .normal)
                Button33.setTitle("c", for: .normal)
                Button34.setTitle("v", for: .normal)
            } else if vState == 1 {
                Button11.setTitle("t", for: .normal)
                Button12.setTitle("y", for: .normal)
                Button13.setTitle("u", for: .normal)
                Button14.setTitle("i", for: .normal)
                Button21.setTitle("g", for: .normal)
                Button22.setTitle("h", for: .normal)
                Button23.setTitle("j", for: .normal)
                Button24.setTitle("k", for: .normal)
                Button31.setTitle("b", for: .normal)
                Button32.setTitle("n", for: .normal)
                Button33.setTitle("m", for: .normal)
                Button34.setTitle("o", for: .normal)
            } else if vState == 2 {
                Button11.setTitle("p", for: .normal)
                Button12.setTitle("l", for: .normal)
                Button13.setTitle(".", for: .normal)
                Button14.setTitle(",", for: .normal)
                Button21.setTitle("\"", for: .normal)
                Button22.setTitle("?", for: .normal)
                Button23.setTitle("(", for: .normal)
                Button24.setTitle(")", for: .normal)
                Button31.setTitle(";", for: .normal)
                Button32.setTitle(":", for: .normal)
                Button33.setTitle("@", for: .normal)
                Button34.setTitle("$", for: .normal)
            }
        } else if mode == 1 {
            Button11.setTitle("1", for: .normal)
            Button12.setTitle("4", for: .normal)
            Button13.setTitle("7", for: .normal)
            Button14.setTitle(".", for: .normal)
            Button21.setTitle("2", for: .normal)
            Button22.setTitle("5", for: .normal)
            Button23.setTitle("8", for: .normal)
            Button24.setTitle("0", for: .normal)
            Button31.setTitle("3", for: .normal)
            Button32.setTitle("6", for: .normal)
            Button33.setTitle("9", for: .normal)
            Button34.setTitle("Sign", for: .normal) // TODO: Sign need to be implemented
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
        while iter < 4 {
            /*Button2Array[iter].backgroundColor = UIColor.lightGray
            Button2Array[iter].setTitleColor(UIColor.black, for: .normal)
            Button2Array[iter].frame = CGRect(x: centerArray[iter].x, y: centerArray[iter].y, width: 80, height: 80)
            Button2Array[iter].addTarget(self, action: #selector(pressCharacter(_:)), for: .allTouchEvents)*/
            if iter == 0 {
                Button11 = UIButton()
                Button11.backgroundColor = UIColor.white
                Button11.setTitleColor(UIColor.black, for: .normal)
                Button11.frame = CGRect(x: centerArray[iter].x, y: centerArray[iter].y - 100, width: 80, height: 80)
                Button11.addTarget(self, action: #selector(pressCharacter(_:)), for: .touchUpInside)
                Button11.setTitle("q", for: .normal)
                Button11.layer.cornerRadius = Button11.frame.height / 2
                self.view.addSubview(Button11)
                Button21 = UIButton()
                Button21.backgroundColor = UIColor.white
                Button21.setTitleColor(UIColor.black, for: .normal)
                Button21.frame = CGRect(x: centerArray[iter].x, y: centerArray[iter].y, width: 80, height: 80)
                Button21.addTarget(self, action: #selector(pressCharacter(_:)), for: .touchUpInside)
                Button21.setTitle("a", for: .normal)
                Button21.layer.cornerRadius = Button21.frame.height / 2
                self.view.addSubview(Button21)
                Button31 = UIButton()
                Button31.backgroundColor = UIColor.white
                Button31.setTitleColor(UIColor.black, for: .normal)
                Button31.frame = CGRect(x: centerArray[iter].x, y: centerArray[iter].y + 100, width: 80, height: 80)
                Button31.addTarget(self, action: #selector(pressCharacter(_:)), for: .touchUpInside)
                Button31.setTitle("z", for: .normal)
                Button31.layer.cornerRadius = Button31.frame.height / 2
                self.view.addSubview(Button31)
            } else if iter == 1 {
                Button12 = UIButton()
                Button12.backgroundColor = UIColor.white
                Button12.setTitleColor(UIColor.black, for: .normal)
                Button12.frame = CGRect(x: centerArray[iter].x, y: centerArray[iter].y - 100, width: 80, height: 80)
                Button12.addTarget(self, action: #selector(pressCharacter(_:)), for: .touchUpInside)
                Button12.setTitle("w", for: .normal)
                Button12.layer.cornerRadius = Button12.frame.height / 2
                self.view.addSubview(Button12)
                Button22 = UIButton()
                Button22.backgroundColor = UIColor.white
                Button22.setTitleColor(UIColor.black, for: .normal)
                Button22.frame = CGRect(x: centerArray[iter].x, y: centerArray[iter].y, width: 80, height: 80)
                Button22.addTarget(self, action: #selector(pressCharacter(_:)), for: .touchUpInside)
                Button22.setTitle("s", for: .normal)
                Button22.layer.cornerRadius = Button22.frame.height / 2
                self.view.addSubview(Button22)
                Button32 = UIButton()
                Button32.backgroundColor = UIColor.white
                Button32.setTitleColor(UIColor.black, for: .normal)
                Button32.frame = CGRect(x: centerArray[iter].x, y: centerArray[iter].y + 100, width: 80, height: 80)
                Button32.addTarget(self, action: #selector(pressCharacter(_:)), for: .touchUpInside)
                Button32.setTitle("x", for: .normal)
                Button32.layer.cornerRadius = Button32.frame.height / 2
                self.view.addSubview(Button32)
            } else if iter == 2 {
                Button13 = UIButton()
                Button13.backgroundColor = UIColor.white
                Button13.setTitleColor(UIColor.black, for: .normal)
                Button13.frame = CGRect(x: centerArray[iter].x, y: centerArray[iter].y - 100, width: 80, height: 80)
                Button13.addTarget(self, action: #selector(pressCharacter(_:)), for: .touchUpInside)
                Button13.setTitle("e", for: .normal)
                Button13.layer.cornerRadius = Button13.frame.height / 2
                self.view.addSubview(Button13)
                Button23 = UIButton()
                Button23.backgroundColor = UIColor.white
                Button23.setTitleColor(UIColor.black, for: .normal)
                Button23.frame = CGRect(x: centerArray[iter].x, y: centerArray[iter].y, width: 80, height: 80)
                Button23.addTarget(self, action: #selector(pressCharacter(_:)), for: .touchUpInside)
                Button23.setTitle("d", for: .normal)
                Button23.layer.cornerRadius = Button23.frame.height / 2
                self.view.addSubview(Button23)
                Button33 = UIButton()
                Button33.backgroundColor = UIColor.white
                Button33.setTitleColor(UIColor.black, for: .normal)
                Button33.frame = CGRect(x: centerArray[iter].x, y: centerArray[iter].y + 100, width: 80, height: 80)
                Button33.addTarget(self, action: #selector(pressCharacter(_:)), for: .touchUpInside)
                Button33.setTitle("c", for: .normal)
                Button33.layer.cornerRadius = Button33.frame.height / 2
                self.view.addSubview(Button33)
            } else {
                Button14 = UIButton()
                Button14.backgroundColor = UIColor.white
                Button14.setTitleColor(UIColor.black, for: .normal)
                Button14.frame = CGRect(x: centerArray[iter].x, y: centerArray[iter].y - 100, width: 80, height: 80)
                Button14.addTarget(self, action: #selector(pressCharacter(_:)), for: .touchUpInside)
                Button14.setTitle("r", for: .normal)
                Button14.layer.cornerRadius = Button14.frame.height / 2
                self.view.addSubview(Button14)
                Button24 = UIButton()
                Button24.backgroundColor = UIColor.white
                Button24.setTitleColor(UIColor.black, for: .normal)
                Button24.frame = CGRect(x: centerArray[iter].x, y: centerArray[iter].y, width: 80, height: 80)
                Button24.addTarget(self, action: #selector(pressCharacter(_:)), for: .touchUpInside)
                Button24.setTitle("f", for: .normal)
                Button24.layer.cornerRadius = Button24.frame.height / 2
                self.view.addSubview(Button24)
                Button34 = UIButton()
                Button34.backgroundColor = UIColor.white
                Button34.setTitleColor(UIColor.black, for: .normal)
                Button34.frame = CGRect(x: centerArray[iter].x, y: centerArray[iter].y + 100, width: 80, height: 80)
                Button34.addTarget(self, action: #selector(pressCharacter(_:)), for: .touchUpInside)
                Button34.setTitle("v", for: .normal)
                Button34.layer.cornerRadius = Button34.frame.height / 2
                self.view.addSubview(Button34)
            }
            // self.view.addSubview(Button2Array[iter])
            iter += 1
        }
        
        let vLine = lineView(frame: CGRect(x: Button24.frame.origin.x + 100, y: 204, width: 197, height: 819))
        vLine.backgroundColor = UIColor.lightGray
        self.view.addSubview(vLine)
        
        Delete = UIButton()
        Delete.backgroundColor = UIColor.red
        Delete.setTitleColor(UIColor.white, for: .normal)
        Delete.frame = CGRect(x: Button24.frame.origin.x + 100, y: centerArray.sorted(by: {$0.y < $1.y})[0].y, width: 100, height: 100)
        Delete.addTarget(self, action: #selector(pressDelete(_:)), for: .touchUpInside)
        Delete.setTitle("Del", for: .normal)
        self.view.addSubview(Delete)
        
        Space = UIButton()
        Space.backgroundColor = UIColor.white
        Space.setTitleColor(UIColor.black, for: .normal)
        Space.frame = CGRect(x: Button24.frame.origin.x + 100, y: centerArray.sorted(by: {$0.y < $1.y})[0].y + 100, width: 100, height: 150)
        Space.addTarget(self, action: #selector(pressSpace(_:)), for: .touchUpInside)
        Space.setTitle("Space", for: .normal)
        self.view.addSubview(Space)
        
        Cap = UIButton()
        Cap.backgroundColor = UIColor.gray
        Cap.setTitleColor(UIColor.white, for: .normal)
        Cap.frame = CGRect(x: Button24.frame.origin.x + 100, y: centerArray.sorted(by: {$0.y < $1.y})[0].y - 100, width: 100, height: 100)
        Cap.addTarget(self, action: #selector(pressCap(_:)), for: .touchUpInside)
        Cap.setTitle("Cap", for: .normal)
        self.view.addSubview(Cap)
        
        Enter = UIButton()
        Enter.backgroundColor = UIColor.gray
        Enter.setTitleColor(UIColor.white, for: .normal)
        Enter.frame = CGRect(x: Button24.frame.origin.x + 200, y: centerArray.sorted(by: {$0.y < $1.y})[0].y + 100, width: 100, height: 150)
        Enter.addTarget(self, action: #selector(pressEnter(_:)), for: .touchUpInside)
        Enter.setTitle("Enter", for: .normal)
        self.view.addSubview(Enter)
        
        SwitchMode = UIButton()
        SwitchMode.backgroundColor = UIColor.green
        SwitchMode.setTitleColor(UIColor.blue, for: .normal)
        SwitchMode.frame = CGRect(x: Button24.frame.origin.x + 200, y: centerArray.sorted(by: {$0.y < $1.y})[0].y - 100, width: 100, height: 100)
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
        
        predWord1 = UIButton()
        predWord1.backgroundColor = UIColor.gray
        predWord1.setTitleColor(UIColor.white, for: .normal)
        predWord1.frame = CGRect(x: Button11.frame.origin.x - 20, y: Button11.frame.origin.y - 100, width: 100, height: 80)
        predWord1.addTarget(self, action: #selector(pressWord(_:)), for: .touchUpInside)
        predWord1.setTitle("predWord1", for: .normal)
        self.view.addSubview(predWord1)
        
        predWord2 = UIButton()
        predWord2.backgroundColor = UIColor.gray
        predWord2.setTitleColor(UIColor.white, for: .normal)
        predWord2.frame = CGRect(x: Button12.frame.origin.x - 20, y: Button12.frame.origin.y - 100, width: 100, height: 80)
        predWord2.addTarget(self, action: #selector(pressWord(_:)), for: .touchUpInside)
        predWord2.setTitle("predWord2", for: .normal)
        self.view.addSubview(predWord2)
        
        predWord3 = UIButton()
        predWord3.backgroundColor = UIColor.gray
        predWord3.setTitleColor(UIColor.white, for: .normal)
        predWord3.frame = CGRect(x: Button13.frame.origin.x - 20, y: Button13.frame.origin.y - 100, width: 100, height: 80)
        predWord3.addTarget(self, action: #selector(pressWord(_:)), for: .touchUpInside)
        predWord3.setTitle("predWord3", for: .normal)
        self.view.addSubview(predWord3)
        
        predWord4 = UIButton()
        predWord4.backgroundColor = UIColor.gray
        predWord4.setTitleColor(UIColor.white, for: .normal)
        predWord4.frame = CGRect(x: Button14.frame.origin.x - 20, y: Button14.frame.origin.y - 100, width: 100, height: 80)
        predWord4.addTarget(self, action: #selector(pressWord(_:)), for: .touchUpInside)
        predWord4.setTitle("predWord4", for: .normal)
        self.view.addSubview(predWord4)
    }
    
    @objc func pressGoBack(_ sender: UIButton) {
        let keyView = WelcomeViewController(nibName: nil, bundle: nil)
        self.present(keyView, animated: true, completion: nil)
    }
    
    @objc func pressWord(_ sender: UIButton) {
        print("Word: \(sender.titleLabel!.text!) pressed")
        inputText.text! += sender.titleLabel!.text!
    }
    
    @objc func pressCharacter(_ sender: UIButton) {
        print("\(sender.titleLabel!.text!) pressed")
        if sender.titleLabel!.text! == "Sign" {
            Button11.setTitle("+", for: .normal)
            Button12.setTitle("-", for: .normal)
            Button13.setTitle("*", for: .normal)
            Button14.setTitle("/", for: .normal)
            Button21.setTitle("<", for: .normal)
            Button22.setTitle(">", for: .normal)
            Button23.setTitle("%", for: .normal)
            Button24.setTitle("(", for: .normal)
            Button31.setTitle(")", for: .normal)
            Button32.setTitle("{", for: .normal)
            Button33.setTitle("}", for: .normal)
            Button34.setTitle("Num", for: .normal)
        } else if sender.titleLabel!.text! == "Num" {
            Button11.setTitle("1", for: .normal)
            Button12.setTitle("4", for: .normal)
            Button13.setTitle("7", for: .normal)
            Button14.setTitle(".", for: .normal)
            Button21.setTitle("2", for: .normal)
            Button22.setTitle("5", for: .normal)
            Button23.setTitle("8", for: .normal)
            Button24.setTitle("0", for: .normal)
            Button31.setTitle("3", for: .normal)
            Button32.setTitle("6", for: .normal)
            Button33.setTitle("9", for: .normal)
            Button34.setTitle("Sign", for: .normal)
        } else {
            inputText.text! += sender.titleLabel!.text!
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
    
    @objc func pressEnter(_ sender: UIButton) {
        print("\(sender.titleLabel!.text!) pressed")
        inputText.text! += "\n"
    }
    
    @objc func pressMode(_ sender: UIButton) {
        print("detect")
        modeNum0 = UIButton()
        modeNum0.backgroundColor = UIColor.gray
        modeNum0.setTitleColor(UIColor.black, for: .normal)
        modeNum0.frame = CGRect(x: 150, y: 200, width: 100, height: 100)
        modeNum0.addTarget(self, action: #selector(pressSwitchMode(_:)), for: .touchUpInside)
        modeNum0.setTitle("English", for: .normal)
        self.view.addSubview(modeNum0)
        modeNum1 = UIButton()
        modeNum1.backgroundColor = UIColor.gray
        modeNum1.setTitleColor(UIColor.black, for: .normal)
        modeNum1.frame = CGRect(x: 150, y: 350, width: 100, height: 100)
        modeNum1.addTarget(self, action: #selector(pressSwitchMode(_:)), for: .touchUpInside)
        modeNum1.setTitle("Number", for: .normal)
        self.view.addSubview(modeNum1)
        Button11.removeFromSuperview()
        Button12.removeFromSuperview()
        Button13.removeFromSuperview()
        Button14.removeFromSuperview()
        Button21.removeFromSuperview()
        Button22.removeFromSuperview()
        Button23.removeFromSuperview()
        Button24.removeFromSuperview()
        Button31.removeFromSuperview()
        Button32.removeFromSuperview()
        Button33.removeFromSuperview()
        Button34.removeFromSuperview()
        Space.removeFromSuperview()
        Delete.removeFromSuperview()
        Enter.removeFromSuperview()
        Cap.removeFromSuperview()
        goBack.removeFromSuperview()
        SwitchMode.removeFromSuperview()
        predWord1.removeFromSuperview()
        predWord2.removeFromSuperview()
        predWord3.removeFromSuperview()
        predWord4.removeFromSuperview()
    }
    
    @objc func pressSwitchMode(_ sender: UIButton) {
        vState = 0
        if sender.titleLabel!.text! == "English" {
            mode = 0
            Button11.setTitle("q", for: .normal)
            Button12.setTitle("w", for: .normal)
            Button13.setTitle("e", for: .normal)
            Button14.setTitle("r", for: .normal)
            Button21.setTitle("a", for: .normal)
            Button22.setTitle("s", for: .normal)
            Button23.setTitle("d", for: .normal)
            Button24.setTitle("f", for: .normal)
            Button31.setTitle("z", for: .normal)
            Button32.setTitle("x", for: .normal)
            Button33.setTitle("c", for: .normal)
            Button34.setTitle("v", for: .normal)
            Button11.frame = CGRect(x: centerArray[0].x, y: centerArray[0].y - 100, width: 80, height: 80)
            Button21.frame = CGRect(x: centerArray[0].x, y: centerArray[0].y, width: 80, height: 80)
            Button31.frame = CGRect(x: centerArray[0].x, y: centerArray[0].y + 100, width: 80, height: 80)
            Button12.frame = CGRect(x: centerArray[1].x, y: centerArray[1].y - 100, width: 80, height: 80)
            Button22.frame = CGRect(x: centerArray[1].x, y: centerArray[1].y, width: 80, height: 80)
            Button32.frame = CGRect(x: centerArray[1].x, y: centerArray[1].y + 100, width: 80, height: 80)
            Button13.frame = CGRect(x: centerArray[2].x, y: centerArray[2].y - 100, width: 80, height: 80)
            Button23.frame = CGRect(x: centerArray[2].x, y: centerArray[2].y, width: 80, height: 80)
            Button33.frame = CGRect(x: centerArray[2].x, y: centerArray[2].y + 100, width: 80, height: 80)
            Button14.frame = CGRect(x: centerArray[3].x, y: centerArray[3].y - 100, width: 80, height: 80)
            Button24.frame = CGRect(x: centerArray[3].x, y: centerArray[3].y, width: 80, height: 80)
            Button34.frame = CGRect(x: centerArray[3].x, y: centerArray[3].y + 100, width: 80, height: 80)
            self.view.addSubview(predWord1)
            self.view.addSubview(predWord2)
            self.view.addSubview(predWord3)
            self.view.addSubview(predWord4)
        } else if sender.titleLabel!.text! == "Number" {
            mode = 1
            vState = 0
            Button11.setTitle("1", for: .normal)
            Button12.setTitle("4", for: .normal)
            Button13.setTitle("7", for: .normal)
            Button14.setTitle(".", for: .normal)
            Button21.setTitle("2", for: .normal)
            Button22.setTitle("5", for: .normal)
            Button23.setTitle("8", for: .normal)
            Button24.setTitle("0", for: .normal)
            Button31.setTitle("3", for: .normal)
            Button32.setTitle("6", for: .normal)
            Button33.setTitle("9", for: .normal)
            Button34.setTitle("Sign", for: .normal)
            let tl = Cap.frame.origin.y
            Button11.frame = CGRect(x: 100, y: tl, width: 80, height: 80)
            Button21.frame = CGRect(x: 190, y: tl, width: 80, height: 80)
            Button31.frame = CGRect(x: 280, y: tl, width: 80, height: 80)
            Button12.frame = CGRect(x: 100, y: tl + 90, width: 80, height: 80)
            Button22.frame = CGRect(x: 190, y: tl + 90, width: 80, height: 80)
            Button32.frame = CGRect(x: 280, y: tl + 90, width: 80, height: 80)
            Button13.frame = CGRect(x: 100, y: tl + 180, width: 80, height: 80)
            Button23.frame = CGRect(x: 190, y: tl + 180, width: 80, height: 80)
            Button33.frame = CGRect(x: 280, y: tl + 180, width: 80, height: 80)
            Button14.frame = CGRect(x: 100, y: tl + 270, width: 80, height: 80)
            Button24.frame = CGRect(x: 190, y: tl + 270, width: 80, height: 80)
            Button34.frame = CGRect(x: 280, y: tl + 270, width: 80, height: 80)
        }
        self.view.addSubview(Button11)
        self.view.addSubview(Button12)
        self.view.addSubview(Button13)
        self.view.addSubview(Button14)
        self.view.addSubview(Button21)
        self.view.addSubview(Button22)
        self.view.addSubview(Button23)
        self.view.addSubview(Button24)
        self.view.addSubview(Button31)
        self.view.addSubview(Button32)
        self.view.addSubview(Button33)
        self.view.addSubview(Button34)
        self.view.addSubview(Space)
        self.view.addSubview(Delete)
        self.view.addSubview(Enter)
        self.view.addSubview(Cap)
        self.view.addSubview(SwitchMode)
        self.view.addSubview(goBack)
        modeNum0.removeFromSuperview()
        modeNum1.removeFromSuperview()
    }
    
    @objc func pressCap(_ sender: UIButton) {
        print("\(sender.titleLabel!.text!) pressed")
        isCapped = 1 - isCapped
        print(isCapped)
        if isCapped == 1 {
            if isAlpha(text: Button11.titleLabel!.text!) {
                Button11.setTitle(Button11.titleLabel!.text!.uppercased(), for: .normal)
            }
            if isAlpha(text: Button12.titleLabel!.text!) {
                Button12.setTitle(Button12.titleLabel!.text!.uppercased(), for: .normal)
            }
            if isAlpha(text: Button13.titleLabel!.text!) {
                Button13.setTitle(Button13.titleLabel!.text!.uppercased(), for: .normal)
            }
            if isAlpha(text: Button14.titleLabel!.text!) {
                Button14.setTitle(Button14.titleLabel!.text!.uppercased(), for: .normal)
            }
            if isAlpha(text: Button21.titleLabel!.text!) {
                Button21.setTitle(Button21.titleLabel!.text!.uppercased(), for: .normal)
            }
            if isAlpha(text: Button22.titleLabel!.text!) {
                Button22.setTitle(Button22.titleLabel!.text!.uppercased(), for: .normal)
            }
            if isAlpha(text: Button23.titleLabel!.text!) {
                Button23.setTitle(Button23.titleLabel!.text!.uppercased(), for: .normal)
            }
            if isAlpha(text: Button24.titleLabel!.text!) {
                Button24.setTitle(Button24.titleLabel!.text!.uppercased(), for: .normal)
            }
            if isAlpha(text: Button31.titleLabel!.text!) {
                Button31.setTitle(Button31.titleLabel!.text!.uppercased(), for: .normal)
            }
            if isAlpha(text: Button32.titleLabel!.text!) {
                Button32.setTitle(Button32.titleLabel!.text!.uppercased(), for: .normal)
            }
            if isAlpha(text: Button33.titleLabel!.text!) {
                Button33.setTitle(Button33.titleLabel!.text!.uppercased(), for: .normal)
            }
            if isAlpha(text: Button34.titleLabel!.text!) {
                Button34.setTitle(Button34.titleLabel!.text!.uppercased(), for: .normal)
            }
        } else {
            if isAlpha(text: Button11.titleLabel!.text!) {
                Button11.setTitle(Button11.titleLabel!.text!.lowercased(), for: .normal)
            }
            if isAlpha(text: Button12.titleLabel!.text!) {
                Button12.setTitle(Button12.titleLabel!.text!.lowercased(), for: .normal)
            }
            if isAlpha(text: Button13.titleLabel!.text!) {
                Button13.setTitle(Button13.titleLabel!.text!.lowercased(), for: .normal)
            }
            if isAlpha(text: Button14.titleLabel!.text!) {
               Button14.setTitle(Button14.titleLabel!.text!.lowercased(), for: .normal)
            }
            if isAlpha(text: Button21.titleLabel!.text!) {
                Button21.setTitle(Button21.titleLabel!.text!.lowercased(), for: .normal)
            }
            if isAlpha(text: Button22.titleLabel!.text!) {
                Button22.setTitle(Button22.titleLabel!.text!.lowercased(), for: .normal)
            }
            if isAlpha(text: Button23.titleLabel!.text!) {
                Button23.setTitle(Button23.titleLabel!.text!.lowercased(), for: .normal)
            }
            if isAlpha(text: Button24.titleLabel!.text!) {
                Button24.setTitle(Button24.titleLabel!.text!.lowercased(), for: .normal)
            }
            if isAlpha(text: Button31.titleLabel!.text!) {
                Button31.setTitle(Button31.titleLabel!.text!.lowercased(), for: .normal)
            }
            if isAlpha(text: Button32.titleLabel!.text!) {
                Button32.setTitle(Button32.titleLabel!.text!.lowercased(), for: .normal)
            }
            if isAlpha(text: Button33.titleLabel!.text!) {
                Button33.setTitle(Button33.titleLabel!.text!.lowercased(), for: .normal)
            }
            if isAlpha(text: Button34.titleLabel!.text!) {
                Button34.setTitle(Button34.titleLabel!.text!.lowercased(), for: .normal)
            }
        }
        //print(Button12.titleLabel!.text!)
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
}
