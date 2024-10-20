
import Foundation
import UIKit

class DesertCoordinator: Coordinator {
    
    var navigationController: UINavigationController!
    weak var levelCoordinator: LevelCoordinator?
    var desertLevelViewController: LevelViewController!
    
    var gameViewController: GameViewController!
    
    func start() {
        desertLevelViewController = LevelViewController()
        desertLevelViewController.coordinator = self
        navigationController.pushViewController(desertLevelViewController, animated: true)
    }
    
    func showGame(index: Int) {
        gameViewController = GameViewController()
        gameViewController.currentLevel = index + 1
        gameViewController.coordinator = self
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    func showMain() {
        navigationController.popToRootViewController(animated: true)
    }
}
