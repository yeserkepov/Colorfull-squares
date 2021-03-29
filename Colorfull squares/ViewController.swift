//
//  ViewController.swift
//  Colorfull squares
//
//  Created by Даурен on 21.03.2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //let square = UIView()
    //var side: CGFloat = 0
    let buttonWidth: CGFloat = 100
    var sqaresAdded = true
    var button = UIButton()
    var textField = UITextField()
    var colorArray:[(Int, Int, Int)] = []
    var hexValue: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addItems()
        textField.delegate = self
    }
    
    func addItems() {
        self.button.frame = CGRect(x: view.frame.maxX / 2 - buttonWidth / 2, y: view.frame.maxY - buttonWidth , width: buttonWidth , height: buttonWidth / 2)
        self.button.layer.cornerRadius = 10
        //print(view.frame.maxY, view.frame.maxX)
        self.button.backgroundColor = .green
        self.button.addTarget(self, action: #selector(squares), for: .touchUpInside)
        view.addSubview(button)
        textField.frame = CGRect(x: view.frame.minX + buttonWidth, y: view.frame.maxY - buttonWidth, width: buttonWidth / 2, height: buttonWidth / 2)
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.red.cgColor
        view.addSubview(textField)
    }
    
    @objc func squares() {
        let side: CGFloat? = (Double(textField.text!).map{ CGFloat($0) } ?? 50)
        let horizontalMaxCount = Int(view.frame.maxX / CGFloat(truncating: side! as NSNumber))
        let verticalMaxCount = Int((view.frame.maxY - buttonWidth) / CGFloat(truncating: side! as NSNumber))
        print(horizontalMaxCount, verticalMaxCount)
        for a in 0..<horizontalMaxCount {
            for b in 0..<verticalMaxCount {
                let square = UIView()
                let colorLabel = UILabel()
                square.layer.borderWidth = 1
                square.layer.borderColor = randomColor().cgColor
                square.backgroundColor = randomColor()
//                colorLabel.text = "\(String(describing: colorArray.last!))"
                colorLabel.text = "\(hexValue)"
                colorLabel.textColor = .black
                colorLabel.frame = CGRect(x: square.bounds.maxX, y: square.bounds.maxY, width: side! , height: side! )
                colorLabel.numberOfLines = 0
                colorLabel.textAlignment = .center
                //colorLabel.lineBreakMode = .byWordWrapping
                colorLabel.adjustsFontSizeToFitWidth = true
                //colorLabel.center = square.center
                square.frame = CGRect(x: CGFloat(a) * side!, y: CGFloat(b) * side!, width: side!, height: side!)
                self.view.addSubview(square)
                square.addSubview(colorLabel)
            }
        }
        //print(colorArray)
    }
    
    //подсмотрел у индуса на ютубе
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowed = "1234567890"
        let allowedSet = CharacterSet(charactersIn: allowed)
        let typedSet = CharacterSet(charactersIn: string)
        return allowedSet.isSuperset(of: typedSet)
    }
        
    func randomColor() -> UIColor {
        let red = CGFloat(Double.random(in: 0...1))
        let blue = CGFloat(Double.random(in: 0...1))
        let green = CGFloat(Double.random(in: 0...1))
        let intRed = Int(red * 255)
        let intGreen = Int(green * 255)
        let intBlue = Int(blue * 255)
        hexValue = "#\(String(format:"%02X", intRed) + String(format:"%02X", intGreen) + String(format:"%02X", intBlue))"
        print(hexValue)
        colorArray.append((intRed, intGreen, intBlue))
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}

