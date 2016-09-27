//
//  ViewController.swift
//  Calculator
//
//  Created by Mariano Montori on 2/29/16.
//  Copyright © 2016 Mariano Montori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var calculation: UILabel!
    
    var userTyping = false
    var number: Double = 0.0

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if(userTyping){
            display.text = display.text! + digit
        }
        else{
            display.text = digit
            userTyping = true
        }
        print("digit = \(digit)")
    }
    
    @IBAction func clearDisplay(sender: UIButton) {
        display.text = "0"
        number = 0
        userTyping = false
        operandStack = []
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if(userTyping){
            calculate()
        }
        switch operation {
        case "+":
            performOperation {$0 + $1}
            break
        case "-":
            performOperation {$0 - $1}
            break
        case "×":
            performOperation {$0 * $1}
            break
        case "÷":
            performOperation {$0 / $1}
            break
        case "√":
            squareRoot {sqrt($0)}
            break
        default:
            break
        }
    }
    
    func performOperation(perform: (Double, Double) -> Double){
        if(operandStack.count >= 2){
            displayValue = perform(operandStack.removeLast(), operandStack.removeLast())
            calculate()
        }
    }
    
    func squareRoot(root: (Double) -> Double){
        if(operandStack.count >= 1){
            displayValue = root(operandStack.removeLast())
            calculate()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func calculate() {
        userTyping = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userTyping = false
        }
    }
    
}

