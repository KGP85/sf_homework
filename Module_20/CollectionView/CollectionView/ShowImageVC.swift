//
//  ShowImageVC.swift
//  CollectionView
//
//  Created by Даниил Муратович on 22.03.2025.
//

import UIKit

class ShowImageVC: UIViewController {

    @IBOutlet weak var currentImage: UIImageView!
    
    var imageName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentImage.image = UIImage(named: imageName)
    }
    
   func setImageName(name: String){
        imageName = name
    }

}
