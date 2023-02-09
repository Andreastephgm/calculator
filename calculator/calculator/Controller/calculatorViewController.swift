//
//  calculatorViewController.swift
//  calculator
//
//  Created by Andrea Stefanny Garcia Mejia on 7/02/23.
//

import UIKit

class calculatorViewController: UIViewController {
    
    //Constants

        private let kDecimalSeparator = Locale.current.decimalSeparator!
        private let kMaxLenght = 9
        private let kTotal = "Total"
    
    //Variables
        private var total:Double = 0
        private var temp: Double = 0
        private var operating = false
        private var result : Double = 0
        private var decimal = false
        private var operation : operationType = .none
        
        
        private enum operationType {
            case none, addition, substraction, multiplication, division, percent
            }
        
        private let auxFormatter: NumberFormatter = {
              let formatter = NumberFormatter()
              let locale = Locale.current
              formatter.groupingSeparator = ""
              formatter.decimalSeparator = locale.decimalSeparator
              formatter.numberStyle = .decimal
              formatter.maximumIntegerDigits = 100
              formatter.minimumFractionDigits = 0
              formatter.maximumFractionDigits = 100
              return formatter
          }()
        
        private let auxTotalFormatter: NumberFormatter = {
                let formatter = NumberFormatter()
                formatter.groupingSeparator = ""
                formatter.decimalSeparator = ""
                formatter.numberStyle = .decimal
                formatter.maximumIntegerDigits = 100
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 100
                return formatter
            }()
        
        private let printFormatter: NumberFormatter = {
             let formatter = NumberFormatter()
             let locale = Locale.current
             formatter.groupingSeparator = locale.groupingSeparator
             formatter.decimalSeparator = locale.decimalSeparator
             formatter.numberStyle = .decimal
             formatter.maximumIntegerDigits = 9
             formatter.minimumFractionDigits = 0
             formatter.maximumFractionDigits = 8
             return formatter
         }()
       
        private let printScientificFormatter: NumberFormatter = {
                var formatter = NumberFormatter()
            formatter.numberStyle = .scientific
                formatter.maximumFractionDigits = 3
                formatter.exponentSymbol = "e"
                return formatter
            }()
       
        var imageView: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
            imageView.image = UIImage(named: "logo")
            return imageView
        }()
    
    //ANSWER
    @IBOutlet weak var answerLabel: UILabel!
    
    //NUMBERS
    
    @IBOutlet weak var zeroLabel: UIButton!
    
    @IBOutlet weak var oneLabel: UIButton!
    
    @IBOutlet weak var twoLabel: UIButton!
    
    @IBOutlet weak var threeLabel: UIButton!
    
    @IBOutlet weak var fourLabel: UIButton!
    
    @IBOutlet weak var fiveLabel: UIButton!
    
    @IBOutlet weak var sixLabel: UIButton!
    
    @IBOutlet weak var sevenLabel: UIButton!
    
    @IBOutlet weak var eightLabel: UIButton!
    
    @IBOutlet weak var nineLabel: UIButton!
    
    @IBOutlet weak var decimalLabel: UIButton!
    
    //OPERATORS
    
    @IBOutlet weak var acLabel: UIButton!
    
    @IBOutlet weak var minusPlusLabel: UIButton!
    
    @IBOutlet weak var percentLabel: UIButton!
    
    @IBOutlet weak var additionLabel: UIButton!
    
    @IBOutlet weak var substractionLabel: UIButton!
    
    @IBOutlet weak var multiplicationLabel: UIButton!
    
    @IBOutlet weak var divisionLabel: UIButton!
    
    @IBOutlet weak var equalLabel: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.decimalLabel.setTitle(kDecimalSeparator, for: .normal)
         
        total = UserDefaults.standard.double(forKey: kTotal)
        answer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        zeroLabel.round()
        oneLabel.round()
        twoLabel.round()
        threeLabel.round()
        fourLabel.round()
        fiveLabel.round()
        sixLabel.round()
        sevenLabel.round()
        eightLabel.round()
        nineLabel.round()
        decimalLabel.round()
        multiplicationLabel.round()
        additionLabel.round()
        substractionLabel.round()
        divisionLabel.round()
    }
    
  //ACTION
    @IBAction func acButton(_ sender: UIButton) {
        clear()
        sender.shine()
    }
    
    @IBAction func plusMinusButton(_ sender: UIButton) {
        temp = temp * (-1)
        answerLabel.text = printFormatter.string(from: NSNumber(value: temp))
        sender.shine()
    }
    
    @IBAction func percentButton(_ sender: UIButton) {
        if operation != .percent {
            answer()
            operating = true
            operation = .percent
            answer()
            sender.shine()
        }
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        answer()
        sender.shine()
    }
    
    @IBAction func additionButton(_ sender: UIButton) {
        if operation != .none{
            answer()
        }
        operating = true
        operation = .addition
        
        sender.pressed(true)
    }
    
    @IBAction func substractionButton(_ sender: UIButton) {
        if operation != .none{
            answer()
        }
        
        operating = true
        operation = .substraction
        
        sender.pressed(true)
    }
    
    @IBAction func multiplicationButton(_ sender: UIButton) {
        if operation != .none{
            answer()
        }
        operating = true
        operation = .multiplication
        
        sender.pressed(true)
        sender.shine()
    }
    
    @IBAction func divisionButton(_ sender: UIButton) {
        if operation != .none{
            answer()
        }
        operating = true
        operation = .division
        
        sender.pressed(true)
        sender.shine()
    }
    
    
    @IBAction func decimalButton(_ sender: UIButton) {
        let currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
               if answerLabel.text?.contains(kDecimalSeparator) ?? false || (!operating && currentTemp.count >= kMaxLenght) {
                   return
               }
               
               answerLabel.text = answerLabel.text! + kDecimalSeparator
               decimal = true
        
               chooseOperation()
               sender.shine()
    }
    
    
    @IBAction func numberAction(_ sender: UIButton) {
        acLabel.setTitle("C", for: .normal)
        
        var currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        if !operating && currentTemp.count >= kMaxLenght {
            return
        }
        
        currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        
        if operating {
            total = total == 0 ? temp : total
            answerLabel.text = ""
            currentTemp = ""
            operating = false
        }
        
      
        if decimal {
            currentTemp = "\(currentTemp)\(kDecimalSeparator)"
            decimal = false
        }
        
        let number = sender.tag
        temp = Double(currentTemp + String(number))!
        answerLabel.text = printFormatter.string(from: NSNumber(value: temp))
        
        chooseOperation()
        sender.shine()
    }
    private func clear(){
        if operation == .none {
                    total = 0
                }
                operation = .none
                acLabel.setTitle("AC", for: .normal)
                if temp != 0 {
                    temp = 0
                    answerLabel.text = "0"
                } else {
                    total = 0
                   answer()
                }
    }
    private func answer(){
        switch operation{
            
        case .none:
            break
        case .addition:
            total = total + temp
            break
        case .substraction:
            total = total - temp
            break
        case .multiplication:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
            
        case.percent:
            temp = temp / 100
            total = temp
            break
        }
        if let currentValueTotal = auxTotalFormatter.string(from: NSNumber(value: total)), currentValueTotal.count > kMaxLenght {
                 answerLabel.text = printScientificFormatter.string(from: NSNumber(value: total))
             } else {
                 answerLabel.text = printFormatter.string(from: NSNumber(value: total))
             }
        
        operation = .none
        chooseOperation()
        UserDefaults.standard.setValue(total, forKey: kTotal)
        print("Total = \(total)")
    }
    
    private func chooseOperation() {
        if !operating {
            additionLabel.pressed(false)
            substractionLabel.pressed(false)
            multiplicationLabel.pressed(true)
            divisionLabel.pressed(true)
        }else{
            switch operation{
                
            case .none , .percent:
                additionLabel.pressed(false)
                substractionLabel.pressed(false)
                multiplicationLabel.pressed(false)
                divisionLabel.pressed(false)
                break
            case .addition:
                additionLabel.pressed(true)
                substractionLabel.pressed(false)
                multiplicationLabel.pressed(false)
                divisionLabel.pressed(false)
                break
            case .substraction:
                additionLabel.pressed(false)
                substractionLabel.pressed(true)
                multiplicationLabel.pressed(false)
                divisionLabel.pressed(false)
                break
            case .multiplication:
                additionLabel.pressed(false)
                substractionLabel.pressed(false)
                multiplicationLabel.pressed(true)
                divisionLabel.pressed(false)
                break
            case .division:
                additionLabel.pressed(false)
                substractionLabel.pressed(false)
                multiplicationLabel.pressed(false)
                divisionLabel.pressed(true)
                break
            }
        }
               
           }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
