
import Foundation
import UIKit

extension LeaderboardViewController {
    
    func setupButton() {
        leaderboardView.homeButton.addTarget(self, action: #selector(homePressed), for: .touchUpInside)
    }
    
    @objc
    func homePressed() {
        navigationController?.popViewController(animated: true)
    }
}
