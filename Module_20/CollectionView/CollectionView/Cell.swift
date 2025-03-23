//
//  Cell.swift
//  CollectionView
//
//  Created by Даниил Муратович on 22.03.2025.
//

import UIKit

class Cell: UICollectionViewCell {
    
    @IBOutlet weak var smileImage: UIImageView!
    @IBOutlet weak var temperatureImage: UIImageView!
    
    func setSmileImage(smileName: String) {
        smileImage.image = UIImage(named: smileName)
      }
    func setTemperatureImage(tempName: String) {
        temperatureImage.image = UIImage(named: tempName)
    }
}
