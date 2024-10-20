
import Foundation
import UIKit

extension MainViewController {
    
    func setupButtons() {
        mainView.leaderboardButton.addTarget(self, action: #selector(leadersPressed), for: .touchUpInside)
        mainView.settingsButton.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        mainView.playButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
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
        coordinator?.showLevels()
    }
}
