//
//  ViewController.swift
//  CircleGame
//
//  Created by Даниил Муратович on 12.04.2025.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем случайное количество кругов от 3 до 7
        let circleCount = 7
        
        // Располагаем круги на экране
        let padding: CGFloat = 40
        let diameter: CGFloat = 60
        
        for i in 0..<circleCount {
            let row = i / 3
            let col = i % 3
            
            let x = 30 + padding + CGFloat(col) * (diameter + padding)
            let y = 60 + padding + CGFloat(row) * (diameter + padding)
            
            let circle = CircleObject(frame: CGRect(x: x, y: y, width: diameter, height: diameter))
            view.addSubview(circle)
        }
    }
}

