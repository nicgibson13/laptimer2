//
//  ViewController.swift
//  lapTimer
//
//  Created by Nic Gibson on 9/12/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    weak var shapeLayer: CAShapeLayer?
    var buttonTapped: Int = 0
    var segmentedControllerBool: Bool = false

    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var tensSecondLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var bigTrackView: UIView!
    @IBOutlet weak var littleTrackView: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        minuteLabel.layer.borderWidth = 1
        tensSecondLabel.layer.borderWidth = 1
        secondLabel.layer.borderWidth = 1
        calculateButton.layer.borderWidth = 1
        startButton.layer.borderWidth = 1
        segmentedController.layer.borderWidth = 1
        segmentedController.layer.borderColor = UIColor.white.cgColor
        segmentedController.layer.masksToBounds = true
        segmentedController.layer.cornerRadius = segmentedController.frame.height / 15
        calculateButton.layer.cornerRadius = calculateButton.frame.height / 2
        bigTrackView.layer.cornerRadius = bigTrackView.frame.height / 4.8
        littleTrackView.layer.cornerRadius = littleTrackView.frame.height / 4.8
        startButton.layer.cornerRadius = startButton.frame.height / 2
        
        // Do any additional setup after loading the view.
    }

    @IBAction func indoorSegmentedController(_ sender: Any) {
        segmentedControllerBool = !segmentedControllerBool
        if segmentedControllerBool {
            bigTrackView.backgroundColor = UIColor.brown
            littleTrackView.backgroundColor = UIColor.green
        } else {
            bigTrackView.backgroundColor = UIColor.blue
            littleTrackView.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func minuteUpButton(_ sender: Any) {
        buttonTapped = 1
        updateNumber(isIncreasing: true)
    }
    
    @IBAction func tensSecondsUp(_ sender: Any) {
        buttonTapped = 2
        updateNumber(isIncreasing: true)
    }
    
    @IBAction func secondUp(_ sender: Any) {
        buttonTapped = 3
        updateNumber(isIncreasing: true)
    }
    
    @IBAction func minuteDown(_ sender: Any) {
        buttonTapped = 4
        updateNumber(isIncreasing: false)
    }
    
    @IBAction func tenSecondsDown(_ sender: Any) {
        buttonTapped = 5
        updateNumber(isIncreasing: false)
    }
    
    @IBAction func secondDown(_ sender: Any) {
        buttonTapped = 6
        updateNumber(isIncreasing: false)
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {

    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        // remove old shape layer if any
        
        self.shapeLayer?.removeFromSuperlayer()
        
        // create whatever path you want
        
        let point = littleTrackView.center
        
        let slightlyBiggerRect = CGRect(x: point.x + 17.5, y: point.y + 77.5, width: littleTrackView.frame.width + 15, height: littleTrackView.frame.height + 17.5)
        
        let path = UIBezierPath(roundedRect: slightlyBiggerRect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: slightlyBiggerRect.width, height: slightlyBiggerRect.height))
        
        // create shape layer for that path
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 0.02732768096, green: 0.03131985664, blue: 0.03549222648, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
        // animate it
        
        view.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 20
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        // save shape layer
        
        self.shapeLayer = shapeLayer
    }
    
    func updateNumber(isIncreasing: Bool){
        guard let minuteNumber = minuteLabel.text,
              var minuteInteger = Int(minuteNumber),
              let tenSecondsNumber = tensSecondLabel.text,
              var tenSecondsInteger = Int(tenSecondsNumber),
              let secondsNumber = secondLabel.text,
              var secondsInteger = Int(secondsNumber) else {return}
        switch buttonTapped {
        case 1:
            minuteInteger += 1
            minuteLabel.text = String(minuteInteger)
        case 2:
            tenSecondsInteger += 1
            tensSecondLabel.text = String(tenSecondsInteger)
        case 3:
            secondsInteger += 1
            secondLabel.text = String(secondsInteger)
        case 4:
            if minuteInteger > 0 {
                minuteInteger -= 1
                minuteLabel.text = String(minuteInteger)
            }
        case 5:
            if tenSecondsInteger > 0 {
                tenSecondsInteger -= 1
                tensSecondLabel.text = String(tenSecondsInteger)
            }
        case 6:
            if secondsInteger > 0 {
                secondsInteger -= 1
                secondLabel.text = String(secondsInteger)
            }
        default:
            print("Default")
        }
        
//        guard var number = Int(numberLabel.text!) else {return}
//        if isIncreasing{
//            number += 1
//        } else {
//            number -= 1
//        }
//        if number >= 0 {
//            numberLabel.text = "\(number)"
//        }
        
    }
    
    @IBAction func upButtonTapped(_ sender: Any) {
        updateNumber(isIncreasing: true)
    }
    @IBAction func downButtonTapped(_ sender: Any) {
        updateNumber(isIncreasing: false)
    }
}

