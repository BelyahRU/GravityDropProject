
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
        winView.tryAgainButton.addTarget(self, action: #selector(reloadPressed), for: .touchUpInside)
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
        AudioManager.shared.buttonClickEffect()
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
        AudioManager.shared.buttonClickEffect()
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
        AudioManager.shared.buttonClickEffect()
        scene.reloadLevel()
        scene.pause()
        loseShowed = false
        winShowed = false
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
        AudioManager.shared.buttonClickEffect()
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
        AudioManager.shared.buttonClickEffect()
        guard let coordinator = coordinator else {
            navigationController?.popViewController(animated: true)
            return
        }
        coordinator.showMain()
    }
    
    //MARK: - WinView
    @objc
    func nextLevelPressed() {
        AudioManager.shared.buttonClickEffect()
        scene.currentLevel = currentLevel + 1
//        scene.reloadLevel()
        scene.pause()
        self.currentLevel = currentLevel + 1
        dimView.isHidden = true
        winShowed = false
        UIView.animate(withDuration: 0.3) {
            self.winViewBottomConstraint?.update(offset: +self.view.bounds.height )  // Обновляем смещение, чтобы паузовая панель поднялась
            self.dimView.isHidden = true
            self.pauseButton.isHidden = false
            self.view.layoutIfNeeded()  // Применяем изменения
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.loadNewLevel()
        }
    }
}
