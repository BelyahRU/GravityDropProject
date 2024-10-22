
import Foundation
import UIKit

extension MainViewController {
    
    func setupButtons() {
        mainView.levelsButton.addTarget(self, action: #selector(levelsPressed), for: .touchUpInside)
        mainView.leaderboardButton.addTarget(self, action: #selector(leadersPressed), for: .touchUpInside)
        mainView.settingsButton.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        mainView.playButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        
    }
    
    @objc
    func levelsPressed() {
        AudioManager.shared.buttonClickEffect()
        coordinator?.showLevels()
    }
    
    @objc
    func leadersPressed() {
        AudioManager.shared.buttonClickEffect()
        coordinator?.showLeaderboard()
    }
    
    @objc
    func settingsPressed() {
        AudioManager.shared.buttonClickEffect()
        coordinator?.showSettings()
    }
    
    @objc
    func playPressed() {
        AudioManager.shared.buttonClickEffect()
        coordinator?.showGame()
    }
}
