
import Foundation
import UIKit

extension GameViewController {
    func setupButtons(){
        gravityButton.addTarget(self, action: #selector(gravityButtonTapped), for: .touchUpInside)
        boostButton.addTarget(self, action: #selector(boostButtonTapped), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pausePressed), for: .touchUpInside)
    }
    
    @objc
    func gravityButtonTapped() {
        scene.applyGravity()
    }
    
    @objc
    func boostButtonTapped() {
        scene.applyBoost()
    }
    
    @objc
    func pausePressed() {
        scene.pause()
        // Анимация плавного появления `PauseView`
        self.view.bringSubviewToFront(dimView)
        self.view.bringSubviewToFront(pauseView)
        UIView.animate(withDuration: 0.3) {
            self.pauseViewBottomConstraint?.update(offset: -self.view.bounds.height / 2 + self.pauseView.bounds.height / 2)  // Обновляем смещение, чтобы паузовая панель поднялась
            self.dimView.isHidden = false
            self.pauseButton.isHidden = true
            self.view.layoutIfNeeded()  // Применяем изменения
        }
    }
    
    
}
