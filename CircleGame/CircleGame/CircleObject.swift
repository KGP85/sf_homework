import UIKit

class CircleObject: UIView {
    private var originalCenter: CGPoint!
    private(set) var isDragging = false
    private(set) var scale: CGFloat = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCircle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCircle()
    }
    
    private func setupCircle() {
        backgroundColor = .blue
        layer.cornerRadius = bounds.width / 2
        clipsToBounds = true
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGestureRecognizer)
        
        originalCenter = center
    }
    
    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let view = recognizer.view else { return }
        
        switch recognizer.state {
        case .began:
            isDragging = true
            originalCenter = center
            
        case .changed:
            let translation = recognizer.translation(in: superview)
            center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)
        case .ended:
            isDragging = false
            checkCollisions()
        default:
            break
        }
    }
    
    private func checkCollisions() {
        guard let superview = superview else { return }
        
        for subview in superview.subviews {
            if let otherCircle = subview as? CircleObject {
                guard otherCircle !== self && !otherCircle.isDragging else { continue }
                
                let distance = hypot(center.x - otherCircle.center.x,
                                   center.y - otherCircle.center.y)
                if distance < frame.width / 2 + otherCircle.frame.width / 2 {
                    handleCollision(with: otherCircle)
                }
            }
        }
    }
    
    private func handleCollision(with otherCircle: CircleObject) {
        // Сохраняем текущий масштаб обоих кругов
        let currentScale = otherCircle.scale
        
        // Анимация изменения цвета
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            otherCircle.backgroundColor = .systemIndigo
        }, completion: nil)
        
        // Анимация увеличения обоих кругов
        UIView.animate(withDuration: 1.0, delay: 0.5, options: [.curveEaseOut], animations: {
            // Увеличиваем оба круга
            otherCircle.transform = CGAffineTransform(scaleX: currentScale + 0.2, y: currentScale + 0.2)
        }, completion: { _ in
            // Удаление текущего объекта с анимацией
            UIView.animate(withDuration: 0.5, animations:
                            {
                self.alpha = 0
            },  completion:
                            { _ in self.removeFromSuperview()
            })
        })
    }
}
