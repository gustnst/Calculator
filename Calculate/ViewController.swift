//
//  ViewController.swift
//  Calculate
//
//  Created by Admin on 22.11.2017.
//  Copyright © 2017 myApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

 //   @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet var display: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
     var userIsInTheMiddleOfTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
/*    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for button in buttons{
            button.layer.cornerRadius = 50
            button.layer.borderColor=UIColor.darkGray.cgColor
            button.layer.borderWidth=1
        
        }
    }*/
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        //  print(digit)
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display!.text = textCurrentlyInDisplay + digit
        } else {
            display!.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    @IBAction func touchDecimal(_ sender: UIButton) {
        if !userIsInTheMiddleOfTyping {
            display.text! = "0."
            userIsInTheMiddleOfTyping = true
        }else if !display.text!.contains(".") {
            display.text! += "."
        }
    }
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func perfomOperation(_ sender: UIButton) {
        // user typed a digit and then clicked on operation
        if userIsInTheMiddleOfTyping {
            // set the left side of the equation (what will be added/multiplied)
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        
        if let mathematicalSymbol = sender.currentTitle {
            // MVC does not allow calculations here
            brain.performOperation(mathematicalSymbol)
            
            if brain.resultIsPending {
                descriptionLabel.text! = brain.description + " ... "
            } else {
                descriptionLabel.text! = brain.description + " = "
            }
            
        }
        
        if let result = brain.result  {
            displayValue = result
        }
    }
    @IBAction func touchClear(_ sender: UIButton) {
        brain.reset()
        descriptionLabel.text! = " "
        display.text! = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

