//
//  ViewController.swift
//  Calculator
//
//  Created by Даниил Муратович on 27.02.2025.
//

import UIKit

class ViewController: UIViewController {
   
    var numberFromScreen: Double = 0;
    var firstNum: Double = 0;
    var operation: Int = 0;
    var mathSign: Bool = false;
    
    @IBOutlet weak var result: UILabel!
    
    @IBAction func digits(_ sender: UIButton) {
        if mathSign == true {
            result.text = String(sender.tag)
            mathSign = false
        } else {
            result.text = result.text! + String(sender.tag)
        }
        numberFromScreen = Double(result.text!)!
    }
    
    
    @IBAction func Buttons(_ sender: UIButton) {
        if result.text != "" && sender.tag != 10 && sender.tag != 15 {
            
            firstNum = Double(result.text!)!
            
            if sender.tag == 11 { // Деление
                result.text = "/";
            }
            if sender.tag == 12 { // Умножение
                result.text = "x";
            }
            if sender.tag == 13 { // Вычитание
                result.text = "-";
            }
            if sender.tag == 14 { // Сложение
                result.text = "+";
            }
            if sender.tag == 16 { // Процент
                result.text = "%";
            }
            if sender.tag == 17 { // Корень
                result.text = "√";
            }
            operation = sender.tag;
            mathSign = true;
        } else if sender.tag == 15 { // Посчитать всё
            if operation == 11 {
                result.text = String(firstNum / numberFromScreen)
            } else if operation == 12 {
                result.text = String(firstNum * numberFromScreen)
            } else if operation == 13 {
                result.text = String(firstNum - numberFromScreen)
            } else if operation == 14 {
                result.text = String(firstNum + numberFromScreen)
            } else if operation == 17 {
                result.text = String(pow(firstNum, 0.5))
            } else if operation == 16 {
                result.text = String((firstNum / 100) * numberFromScreen)
            }
        } else if sender.tag == 10 {
            result.text = ""
            mathSign = false
            firstNum = 0
            operation = 0
            numberFromScreen = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

