//
//  CircleView.swift
//  GameCust2
//
//  Created by Даниил Муратович on 03.04.2025.
//

import UIKit

@IBDesignable
class CircleView: UIView {
    
    @IBInspectable var roundView: Bool = false {
        didSet {
            if roundView {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundView {
            layer.cornerRadius = frame.height / 2
        }
    }
        @IBInspectable var backgroundColorCustom: UIColor? {
            set { backgroundColor = newValue }
            get { backgroundColor }
        }
}
