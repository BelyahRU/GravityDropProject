
import Foundation
import UIKit

extension MainViewController {
    
    func setupButtons() {
        mainView.leaderboardButton.addTarget(self, action: #selector(leadersPressed), for: .touchUpInside)
    }
    
    @objc
    func leadersPressed() {
        coordinator?.showLeaderboard()
    }
}
