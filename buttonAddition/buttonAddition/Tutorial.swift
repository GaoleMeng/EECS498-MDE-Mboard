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

class Tutorial: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let docDir = Bundle.main.url(forResource: "blue", withExtension:"png")
        //print(docDir!)
        
        let firstTutorialPage = OnboardingContentViewController(title: "Welcome to M-Board", body: "tutorial page 1", image: UIImage(contentsOfFile: (docDir?.path)!), buttonText: "") {}
        // let firstTutorialPage = OnboardingContentViewController(title: "Welcome to M-Board", body: "tutorial page 1", image: UIImage(named: "tutor1"), buttonText: "") {}
        firstTutorialPage.titleLabel.font = UIFont(name: firstTutorialPage.bodyLabel.font.fontName, size: 100)
        firstTutorialPage.bodyLabel.font = UIFont(name: firstTutorialPage.bodyLabel.font.fontName, size: 50)
        firstTutorialPage.topPadding = 400
        firstTutorialPage.underIconPadding = -400
        firstTutorialPage.underTitlePadding = 400
        
        
        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "play", withExtension: "gif")!)
        let advTimeGif = UIImage.gifImageWithData(imageData!)
        
        let secondTutorialPage = OnboardingContentViewController(title: "Welcome to M-Board", body: "tutorial page 2", image: advTimeGif, buttonText: "") {}
        secondTutorialPage.titleLabel.font = UIFont(name: secondTutorialPage.bodyLabel.font.fontName, size: 100)
        secondTutorialPage.bodyLabel.font = UIFont(name: secondTutorialPage.bodyLabel.font.fontName, size: 50)
        secondTutorialPage.topPadding = 400
        secondTutorialPage.underIconPadding = -400
        secondTutorialPage.underTitlePadding = 400
        
        let thirdTutorialPage = OnboardingContentViewController(title: "Welcome to M-Board", body: "tutorial page 3", image: UIImage(named: "tutor3"), buttonText: "Let's start!") {
            self.start()
        }
        thirdTutorialPage.titleLabel.font = UIFont(name: thirdTutorialPage.bodyLabel.font.fontName, size: 100)
        thirdTutorialPage.bodyLabel.font = UIFont(name: thirdTutorialPage.bodyLabel.font.fontName, size: 50)
        thirdTutorialPage.actionButton.titleLabel!.font = UIFont(name: thirdTutorialPage.actionButton.titleLabel!.font.fontName, size: 50)
        thirdTutorialPage.bottomPadding = 400
        
        let onboardingVC = OnboardingViewController(backgroundImage: nil, contents: [firstTutorialPage, secondTutorialPage, thirdTutorialPage])
        onboardingVC!.view.backgroundColor = UIColor.yellow
        self.present(onboardingVC!, animated: true, completion: nil)
    }
    
    func start() {
        let keyView = WelcomeViewController(nibName: nil, bundle: nil)
        keyView.modalTransitionStyle = .crossDissolve
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        topController.present(keyView, animated: true, completion: nil)
    }
    
}
