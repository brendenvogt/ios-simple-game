//
//  ViewController.swift
//  PenguinoParty
//
//  Created by Brenden Vogt on 11/21/18.
//  Copyright © 2018 Brenden. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var penguino: UIImageView!
    @IBOutlet var penguinoBaseY: NSLayoutConstraint!
    @IBOutlet var penguinoBaseX: NSLayoutConstraint!

    var velocityX: CGFloat = 6.0
    var velocityY: CGFloat = 0.0
    
    var gravity: CGFloat = 1
    var deceleration: CGFloat = 0.98
    
    var minY: CGFloat = 25.0
    
    @IBOutlet var aButton: UIImageView!
    @IBOutlet var bButton: UIImageView!
    @IBOutlet var dPad: UIImageView!
    
    var dPadLocation: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        start()
    }

    func start(){
        
        let aTap = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.aTapped(_:)))
        aTap.delegate = self
        aTap.minimumPressDuration = 0
        aButton.isUserInteractionEnabled = true
        aButton.addGestureRecognizer(aTap)
        
        let bTap = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.bTapped(_:)))
        bTap.delegate = self
        bTap.minimumPressDuration = 0
        bButton.isUserInteractionEnabled = true
        bButton.addGestureRecognizer(bTap)
        
        let dPadTap = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.dPadTouched(_:)))
        dPadTap.delegate = self
        dPadTap.minimumPressDuration = 0
        dPad.isUserInteractionEnabled = true
        dPad.addGestureRecognizer(dPadTap)

        Timer.scheduledTimer(timeInterval: 0.0166666, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        
        if let dPadLocation = dPadLocation {
            calcMove(dPadLocation)
        }
        
        //Y
        var newY = penguinoBaseY.constant
        
        velocityY = velocityY - gravity
        
        newY = max(newY + velocityY, minY)

        if (newY <= minY) {
            velocityY = 0
        }
        
        penguinoBaseY.constant = newY

        //X
        var newX = penguinoBaseX.constant

        if newX > view.frame.size.width {
            newX = -50
        }else if newX < -50 {
            newX = view.frame.size.width
        }
        
        newX = newX + velocityX
        
        if (abs(velocityX) > 0) {
            velocityX = velocityX * deceleration
        }
        
        penguinoBaseX.constant = newX

    }
    
    func jump(){
        velocityY = 20
    }
    
    func moveLeft(){
        velocityX = max(velocityX - 1, -15)
    }
    
    func moveRight(){
        velocityX = min(velocityX + 1, 15)
    }
    
    func calcMove(_ location : CGPoint){
        if (location.x < self.dPad.frame.size.width/2){
            moveLeft()
        }else{
            moveRight()
        }
    }
    
    @objc func bTapped(_ rec:UITapGestureRecognizer) {
        if (rec.state == .began){
            print("btapped")
        }
    }
    
    @objc func aTapped(_ rec:UITapGestureRecognizer) {
        if (rec.state == .began){
            print("atapped")
            jump()
        }
    }

    @objc func dPadTouched(_ rec:UITapGestureRecognizer) {
        dPadLocation = rec.location(in: dPad)
        if (rec.state == .ended) {
            dPadLocation = nil
        }
    }
    
}

