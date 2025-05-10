//
//  ViewController.swift
//  SingleApp
//
//  Created by Даниил Муратович on 05.05.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var switcher: UISwitch!
    
    let lightImage = UIImage(named: "light") // Замените "light_image" на имя вашего светлого изображения
    let darkImage = UIImage(named: "dark")   // Замените "dark_image" на имя вашего темного изображения

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // Загрузка сохраненных настроек при запуске
        let switchState = defaults.bool(forKey: "switchState")
        switcher.isOn = switchState

        updateUI(animated: false) // Обновляем UI на основе сохраненного состояния
    }

    @IBAction func switchToggled(_ sender: UISwitch) {
        // Сохранение состояния переключателя
        defaults.set(sender.isOn, forKey: "switchState")
        defaults.synchronize()

        updateUI()
    }

    func updateUI(animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0 // Анимация при переключении

        UIView.animate(withDuration: duration) {
            if self.switcher.isOn {
                self.view.backgroundColor = .darkGray
                self.imageView.image = self.darkImage
            } else {
                self.view.backgroundColor = .white
                self.imageView.image = self.lightImage
            }
        }
    }
}
