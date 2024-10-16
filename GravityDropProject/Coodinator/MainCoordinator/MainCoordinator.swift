import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController!
    var mainViewController: MainViewController!
    var leaderboardViewController: LeaderboardViewController!
    
    
    func start() {
        showMain()
//        showLeaderboard()
    }
    
    func showMain() {
        mainViewController = MainViewController()
        mainViewController.coordinator = self
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func showLeaderboard() {
        leaderboardViewController = LeaderboardViewController()
        leaderboardViewController.coordinator = self
        navigationController.pushViewController(leaderboardViewController, animated: true)
    }
}
