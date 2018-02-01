//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by 孟高乐 on 1/28/18.
//  Copyright © 2018 GaoleMeng. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {


    var keyboardView: UIView!
    @IBOutlet weak var calculatorLable: UILabel!
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadKeyboardFunction()
        
    }
   
    @IBAction func numberPressed(sender: UIButton!) {
        let letterPressed = sender.titleLabel?.text
//
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText((letterPressed)!)
    }
    
    
    
    func loadKeyboardFunction(){
        let keyboardNib = UINib(nibName: "View", bundle: nil)
        keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.backgroundColor = keyboardView.backgroundColor
        view.addSubview(keyboardView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
       
    }

}
