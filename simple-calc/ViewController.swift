//
//  ViewController.swift
//  simple-calc
//
//  Created by studentuser on 4/13/17.
//  Copyright © 2017 KitoPham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userInput : String = ""
    var currentValue = 0.0
    var currentOperation : Operator?
    var avgCount = 1.0
    var countCount = 1.0
    var RPNMode = false
    var averageTotal = 0.0
    var averageStarted = false;
    
    @IBOutlet weak var UserInputeTextField: UITextField!
    @IBOutlet weak var ResultTextField: UITextField!
    enum Operator : String{
        case plus = "+"
        case div = "/"
        case mult = "*"
        case sub = "-"
        case count = "count"
        case average = "average"
        case fact = "fact"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func ButtonPress(_ sender: UIButton) {
        let buttonText = sender.titleLabel!.text!
        switch buttonText {
            case "=":
                equalsCalculate(sender)
                currentOperation = nil
                avgCount = 1
                countCount = 1
                averageTotal = 0
                userInput = String(currentValue)
                enableButtons()     
            case ".":
                disableDecimal()
                userInput += buttonText
            case "C":
                currentOperation = nil
                avgCount = 1
                countCount = 1
                userInput = ""
                ResultTextField.text = ""
                enableDecimal();
            case  "fact":
                userInput = userInput + " " + buttonText + " "
            case "+", "-", "/", "*", "average", "count":
                userInput = userInput + " " + buttonText + " "
                enableDecimal();
                disableButtons()
            default:
                userInput += buttonText
                enableButtons()
        }
        UserInputeTextField.text = userInput
        
    }
    
    func equalsCalculate(_ sender: UIButton){
        let userInputArray = userInput.components(separatedBy: " ")
        
        for index in 0...userInputArray.count-1 {
            let currentComponent = userInputArray[index]
            let numCheck = Double(currentComponent)
            if numCheck == nil{
                switch currentComponent {
                    case "+":
                        currentOperation = Operator.plus
                    case "-":
                        currentOperation = Operator.sub
                    case "/":
                        currentOperation = Operator.div
                    case "*":
                        currentOperation = Operator.mult
                    case "average":
                        if !averageStarted{
                            averageTotal = currentValue
                            averageStarted = true
                        }
                        currentOperation = Operator.average
                    case "count":
                        currentOperation = Operator.count
                        currentValue = countCount
                    case "fact":
                        currentOperation = Operator.fact
                        factOperation()
                    case "":
                        if averageStarted {
                            averageStarted = false
                            currentValue = averageTotal / avgCount
                        }
                    default:
                        break
                }
            } else {
                if currentOperation == nil {
                    currentValue = Double(currentComponent)!
                } else {
                    if currentOperation != Operator.average{
                        if averageStarted {
                            averageStarted = false
                            currentValue = averageTotal / avgCount
                        }
                    }
                    switch currentOperation! {
                        case Operator.plus:
                            currentValue += Double(currentComponent)!
                        case Operator.sub:
                        
                            currentValue -= Double(currentComponent)!
                        case Operator.mult:
                            
                            currentValue *= Double(currentComponent)!
                        case Operator.div:
                            
                            currentValue /= Double(currentComponent)!
                        case Operator.count:
                            
                            countCount += 1.0
                            currentValue = countCount
                        case Operator.average:
                            averageStarted = true
                            averageTotal += Double(currentComponent)!
                            avgCount += 1.0
                        case Operator.fact:
                            break;
                    }
                    
                }
            }
            
        }
        if averageStarted {
            averageStarted = false
            currentValue = averageTotal / avgCount
        }
        
        ResultTextField.text = String(currentValue)
    }
    
    @IBOutlet weak var averagebutton: UIButton!
    @IBOutlet weak var countbutton: UIButton!
    @IBOutlet weak var factbutton: UIButton!
    @IBOutlet weak var plusbutton: UIButton!
    @IBOutlet weak var subbutton: UIButton!
    @IBOutlet weak var multbutton: UIButton!
    @IBOutlet weak var divbutton: UIButton!
    
    
    func disableButtons(){
        averagebutton.isEnabled=false
        countbutton.isEnabled=false
        factbutton.isEnabled=false
        plusbutton.isEnabled=false
        subbutton.isEnabled=false
        multbutton.isEnabled=false
        divbutton.isEnabled=false
    }
    func enableButtons(){
        averagebutton.isEnabled=true
        countbutton.isEnabled=true
        factbutton.isEnabled=true
        plusbutton.isEnabled=true
        subbutton.isEnabled=true
        multbutton.isEnabled=true
        divbutton.isEnabled=true
        
    }
    func factOperation(){
        var product = 1
        for index in 1...Int(currentValue) {
            product *= index
        }
        currentValue = Double(product);
    }
    @IBOutlet weak var decimalButton: UIButton!
    
    func enableDecimal(){
        decimalButton.isEnabled = true
    }
    func disableDecimal(){
        decimalButton.isEnabled = false
    }

}


