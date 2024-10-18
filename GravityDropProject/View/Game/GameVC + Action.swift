
import Foundation
import UIKit

extension GameViewController {
    func setupButtons(){
        gravityButton.addTarget(self, action: #selector(gravityButtonTapped), for: .touchUpInside)
        boostButton.addTarget(self, action: #selector(boostButtonTapped), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pausePressed), for: .touchUpInside)
        
        
        pauseView.continueButton.addTarget(self, action: #selector(continuePressed), for: .touchUpInside)
        pauseView.tryAgainButton.addTarget(self, action: #selector(reloadPressed), for: .touchUpInside)
        pauseView.exitButton.addTarget(self, action: #selector(exitPressed), for: .touchUpInside)
        
        loseView.homeButton.addTarget(self, action: #selector(exitPressed), for: .touchUpInside)
        loseView.tryAgainButton.addTarget(self, action: #selector(reloadAfterLose), for: .touchUpInside)
        
        winView.homeButton.addTarget(self, action: #selector(exitPressed), for: .touchUpInside)
        winView.nextLevelButton.addTarget(self, action: #selector(nextLevelPressed), for: .touchUpInside)
    }
    
    //MARK: - GameScene
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
    
    //MARK: -  PauseView
    @objc
    func continuePressed() {
        dimView.isHidden = true
        scene.pause()
        UIView.animate(withDuration: 0.3) {
            self.pauseViewBottomConstraint?.update(offset: +self.view.bounds.height )  // Обновляем смещение, чтобы паузовая панель поднялась
            self.dimView.isHidden = true
            self.pauseButton.isHidden = false
            self.view.layoutIfNeeded()  // Применяем изменения
        }
    }
    
    @objc
    func reloadPressed() {
        scene.reloadLevel()
        scene.pause()
        loseShowed = false
        dimView.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.pauseViewBottomConstraint?.update(offset: +self.view.bounds.height )  // Обновляем смещение, чтобы паузовая панель поднялась
            self.dimView.isHidden = true
            self.pauseButton.isHidden = false
            self.view.layoutIfNeeded()  // Применяем изменения
        }
        
    }
    
    @objc
    func reloadAfterLose() {
        scene.reloadLevel()
        scene.pause()
        loseShowed = false
        dimView.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.loseViewBottomConstraint?.update(offset: +self.view.bounds.height )  // Обновляем смещение, чтобы паузовая панель поднялась
            self.dimView.isHidden = true
            self.pauseButton.isHidden = false
            self.view.layoutIfNeeded()  // Применяем изменения
        }
    }
    
    
    @objc
    func exitPressed() {
        
    }
    
    //MARK: - WinView
    @objc
    func nextLevelPressed() {
        
    }
}
