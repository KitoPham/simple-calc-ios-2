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
    var currentValue = 0
    var currentOperation : Operator?
    var avgCount = 1
    var countCount = 1
    var RPNMode = false
    var previsNum = false;
    var averageTotal = 0;
    var finalAverage = false;
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
                finalAverage = true;
                equalsCalculate(sender)
                currentOperation = nil
                avgCount = 1
                countCount = 1
                averageTotal = 0
                userInput = String(currentValue)
            case "C":
                currentOperation = nil
                avgCount = 1
                countCount = 1
                userInput = ""
            case "+", "-", "/", "*", "average", "count", "fact":
                userInput = userInput + " " + buttonText + " "
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
            let numCheck = Int(currentComponent)
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
                        currentOperation = Operator.average
                    case "count":
                        currentOperation = Operator.count
                    case "fact":
                        currentOperation = Operator.fact
                    default :
                        break
                }
            } else {
                if currentOperation == nil {
                    currentValue = Int(currentComponent)!
                } else {
                    if currentOperation != Operator.average && averageStarted{
                        if (finalAverage){
                            currentValue += averageTotal / avgCount
                            finalAverage = false
                            averageStarted = false
                        }
                    }
                    switch currentOperation! {
                        case Operator.plus:
                            finalAverage = true
                            currentValue += Int(currentComponent)!
                        case Operator.sub:
                            finalAverage = true
                            currentValue -= Int(currentComponent)!
                        case Operator.mult:
                            finalAverage = true
                            currentValue *= Int(currentComponent)!
                        case Operator.div:
                            finalAverage = true
                            currentValue /= Int(currentComponent)!
                        case Operator.count:
                            finalAverage = true
                            countCount += 1
                            currentValue = countCount
                        case Operator.average:
                            averageStarted = true
                            finalAverage = false
                            averageTotal += Int(currentComponent)!
                            avgCount += 1
                        case Operator.fact:
                            finalAverage = true
                            factOperation()
                    }
                    
                }
            }
            
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
        for index in 1...currentValue {
            product *= index
        }
        currentValue = product;
    }

}


