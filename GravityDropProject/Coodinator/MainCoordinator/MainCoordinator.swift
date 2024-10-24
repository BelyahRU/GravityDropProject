import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController!
    var mainViewController: MainViewController!
    var leaderboardViewController: LeaderboardViewController!
    var settingsViewController: SettingsViewController!
    var gameViewController: GameViewController!
    
    var levelCoordinator: LevelCoordinator!
    
    
    func start() {
        showMain()
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
    
    func showSettings() {
        settingsViewController = SettingsViewController()
        settingsViewController.coordinator = self
        navigationController.pushViewController(settingsViewController, animated: true)
    }
    
    func showLevels() {
        levelCoordinator = LevelCoordinator()
        levelCoordinator.mainCoordinator = self
        levelCoordinator.navigationController = self.navigationController
        levelCoordinator.start()
    }
    
    func showGame() {
        gameViewController = GameViewController()
        let currentLevel = LevelFetcher.shared.getLastSavedLevel()
        gameViewController.currentLevel = currentLevel
        navigationController.pushViewController(gameViewController, animated: true)
    }
}
