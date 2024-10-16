
import Foundation
import UIKit

extension MainViewController {
    
    func setupButtons() {
        mainView.leaderboardButton.addTarget(self, action: #selector(leadersPressed), for: .touchUpInside)
        mainView.settingsButton.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
    }
    
    @objc
    func leadersPressed() {
        coordinator?.showLeaderboard()
    }
    
    @objc
    func settingsPressed() {
        coordinator?.showSettings()
    }
}
