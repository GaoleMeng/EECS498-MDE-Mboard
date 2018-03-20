//
//  Tutorial.swift
//  buttonAddition
//
//  Created by jingyu on 3/6/18.
//  Copyright © 2018 jingyu. All rights reserved.
//

import UIKit
import Onboard
import SwiftyButton
extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}


class Tutorial: UIViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = .white
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            let keyView = LeftRightConfigure(nibName: nil, bundle: nil)
            keyView.modalTransitionStyle = .crossDissolve
            self.present(keyView, animated: true, completion: nil)
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            
            let docDir = Bundle.main.url(forResource: "first", withExtension:"png")
            //print(docDir!)
            var firstimage = UIImage(contentsOfFile: (docDir?.path)!)
            firstimage = firstimage?.resizeImage(targetSize: CGSize(width: 400, height: 700))
            
            let firstTutorialPage = OnboardingContentViewController(title: "", body: "tutorial page 1", image: firstimage, buttonText: "") {}
            // let firstTutorialPage = OnboardingContentViewController(title: "Welcome to M-Board", body: "tutorial page 1", image: UIImage(named: "tutor1"), buttonText: "") {}
            //            firstTutorialPage.titleLabel.font = UIFont(name: firstTutorialPage.bodyLabel.font.fontName, size: 100)
            firstTutorialPage.bodyLabel.font = UIFont(name: firstTutorialPage.bodyLabel.font.fontName, size: 27)
            firstTutorialPage.bodyLabel.text = "Welcome to M-board!\nBefore using the keyboard, you can customize your keyboard layout in the configuration view"
            firstTutorialPage.bodyLabel.textColor = UIColor.black
            //
            firstTutorialPage.topPadding = 100
            //            firstTutorialPage.underIconPadding = -400
            firstTutorialPage.underTitlePadding = 100
            //
            
            let seconddocDir = Bundle.main.url(forResource: "second", withExtension:"png")
            var secondimage = UIImage(contentsOfFile: (seconddocDir?.path)!)
            secondimage = secondimage?.resizeImage(targetSize: CGSize(width: 650, height: 1000))
            
            let secondTutorialPage = OnboardingContentViewController(title: "", body: "tutorial page 2", image: secondimage, buttonText: "") {}
            //            secondTutorialPage.titleLabel.font = UIFont(name: secondTutorialPage.bodyLabel.font.fontName, size: 100)
            secondTutorialPage.bodyLabel.font = UIFont(name: firstTutorialPage.bodyLabel.font.fontName, size: 27)
            secondTutorialPage.bodyLabel.text = "Scroll up and down to switch between different keyboard layout"
            secondTutorialPage.bodyLabel.textColor = UIColor.black
            secondTutorialPage.topPadding = 120
            //            secondTutorialPage.underIconPadding = -400
            
            secondTutorialPage.underTitlePadding = 160
            
            
            let thirdDocdir = Bundle.main.url(forResource: "third", withExtension:"png")
            var thirdimage = UIImage(contentsOfFile: (thirdDocdir?.path)!)
            thirdimage = thirdimage?.resizeImage(targetSize: CGSize(width: 650, height: 1000))
            let thirdTutorialPage = OnboardingContentViewController(title: "", body: "", image: thirdimage, buttonText: "") {}
            //            thirdTutorialPage.titleLabel.font = UIFont(name: thirdTutorialPage.bodyLabel.font.fontName, size: 0)
            
            thirdTutorialPage.bodyLabel.font = UIFont(name: thirdTutorialPage.bodyLabel.font.fontName, size: 27)
            thirdTutorialPage.bodyLabel.text = "Control the mouse with one or multiple fingers\nto tap, scroll or drag"
            thirdTutorialPage.bodyLabel.textColor = UIColor.black
            //            thirdTutorialPage.bodyLabel.text = "ddd"
            //            thirdTutorialPage.actionButton = PressableButton()
            thirdTutorialPage.actionButton.titleLabel!.font = UIFont(name: thirdTutorialPage.actionButton.titleLabel!.font.fontName, size: 27)
            thirdTutorialPage.actionButton.setTitle("Let's Start", for: .normal)
            thirdTutorialPage.actionButton.setTitleColor(UIColor(red: 11 / 255, green: 135 / 255, blue: 232 / 255, alpha: 1), for: .normal)
            //            thirdTutorialPage.actionButton.setTitl
            //            thirdTutorialPage.actionButton.titleLabel!.text = "Let's start!"
            thirdTutorialPage.actionButton.addTarget(self, action: #selector(start), for: .touchUpInside)
            thirdTutorialPage.actionButton.titleLabel!.textColor = UIColor.black
            thirdTutorialPage.topPadding = 120
            thirdTutorialPage.underTitlePadding = 140
            thirdTutorialPage.bottomPadding = 100
            
            let onboardingVC = OnboardingViewController(backgroundImage: nil, contents: [firstTutorialPage, secondTutorialPage, thirdTutorialPage])
            
            onboardingVC!.pageControl.pageIndicatorTintColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1)
            onboardingVC!.pageControl.currentPageIndicatorTintColor = UIColor(red: 229 / 255, green: 81 / 255, blue: 55 / 255, alpha: 1)
            onboardingVC!.shouldMaskBackground = false;
            //        onboardingVC!.navigationController.
            onboardingVC!.view.backgroundColor = UIColor(white:1, alpha: 1)
            onboardingVC?.modalTransitionStyle = .crossDissolve
            self.present(onboardingVC!, animated: true, completion: nil)
        }
    }
    
    @objc func start() {
        let keyView = LeftRightConfigure(nibName: nil, bundle: nil)
        keyView.modalTransitionStyle = .crossDissolve
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        topController.present(keyView, animated: true, completion: nil)
    }
    
}

