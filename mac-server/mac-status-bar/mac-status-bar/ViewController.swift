//
//  ViewController.swift
//  mac-status-bar
//
//  Created by 孟高乐 on 1/31/18.
//  Copyright © 2018 GaoleMeng. All rights reserved.
//

import Cocoa
//import UIColor
//import SwiftyButton

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let button = PressableButton()
//        self.view.wantsLayer = true
        
//        let result = run("pwd")
//        self.view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
//        let image = NSImage(named:)
//        self.view.layer!.contents = image
    }

    @IBAction func send(_ sender: Any) {
        let task = Process()
        //        task.launchPath = "/usr/bin/env"
        //        task.
        task.launchPath = "/Users/menggaole/Desktop/opensource/EECS498-MDE-Mboard/mac-server/server-on-mac/app-macos"
        task.arguments = []
        task.launch()
        print(task.isRunning)
        task.terminate()
        print(task.isRunning)
        print("any")
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }



}

