//
//  HomeViewController.swift
//  Georgie2
//
//  Created by Travis Allen on 4/12/19.
//  Copyright © 2019 Travis Allen. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Georgie_Home_Final_V1")!)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Georgie_Home_Final_v5")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    @IBAction func startChat(_ sender: UIButton) {
        performSegue(withIdentifier: "startChatSegue", sender: sender)
    }
    @IBAction func startGChat(_ sender: UIButton) {
        performSegue(withIdentifier: "startChatSegue", sender: sender)
    }
    
}
