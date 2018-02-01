//
//  KeyboardViewController.swift
//  SimpleKeyBoard
//
//  Created by 孟高乐 on 1/28/18.
//  Copyright © 2018 GaoleMeng. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    var helloButton: UIButton!
    var deleteButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNextButton()
        addHelloButton()
        addDeleteButton()
    
    }
    
    func addHelloButton() {
        helloButton = UIButton(type: .system)
        helloButton.setTitle("Hello", for: .normal)
        helloButton.sizeToFit()
        helloButton.translatesAutoresizingMaskIntoConstraints = false
        
        helloButton.addTarget(self, action: #selector(helloButtonPressed), for: .touchDown)
        self.view.addSubview(helloButton)
        let helloButtonY = NSLayoutConstraint(item: helloButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        let helloButtonX = NSLayoutConstraint(item: helloButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        
        self.view.addConstraint(helloButtonX)
        self.view.addConstraint(helloButtonY)
    }
    
    func addDeleteButton() {
        deleteButton = UIButton(type: .system)
        deleteButton.setTitle("delete", for: .normal)
        deleteButton.sizeToFit()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.addTarget(self, action: #selector(deleteText), for: .touchUpInside)
        self.view.addSubview(deleteButton)
        let deleteButtonY = NSLayoutConstraint(item: deleteButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10)
        let deleteButtonX = NSLayoutConstraint(item: deleteButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -10)
        
        self.view.addConstraint(deleteButtonX)
        self.view.addConstraint(deleteButtonY)
    }
    

    @objc func deleteText() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.deleteBackward()
    }
    
    
    @objc func helloButtonPressed(){
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("Hello")
    }
    
    func addNextButton() {
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
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
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
