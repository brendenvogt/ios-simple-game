//
//  ViewController.swift
//  PenguinoParty
//
//  Created by Brenden Vogt on 11/21/18.
//  Copyright © 2018 Brenden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var penguino: UIImageView!
    
    var velocity: CGFloat = 40.0
    var acceleration: CGFloat = -0.5
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }

    func start(){
        Timer.scheduledTimer(timeInterval: 0.0166666, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        
        var newX = penguino.frame.origin.x
        newX = newX + velocity
        
        if (abs(velocity) > 0) {
            velocity = velocity + acceleration
        }
        
        if newX > view.frame.size.width {
            newX = -50
        }
        
        penguino.frame.origin.x = newX
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ((touches.first?.location(in: self.view).x)! > self.view.frame.size.width/2) {
            velocity = velocity + 10
        }else{
            velocity = velocity - 10
        }
        
        
    }

}

