
import UIKit
import Foundation

final class LevelCoordinator: Coordinator {
    
    var navigationController: UINavigationController!
    weak var mainCoordinator: MainCoordinator?
    
    var levelSelectionViewController: LevelsSelectionViewController!
    
    var desertCoordinator: DesertCoordinator!
    var otherViewController: OtherLevelsViewController!
    
    
    func start() {
        levelSelectionViewController = LevelsSelectionViewController()
        levelSelectionViewController.coordinator = self
        navigationController.pushViewController(levelSelectionViewController, animated: true)
    }
    
    func showHome() {
        navigationController.popViewController(animated: true)
    }
    
    func setupBiome(index: Int) {
        if index == 0 {
            showDesert()
        } else if index == 1 {
            showMountain()
        } else if index == 2 {
            showOcean()
        } else if index == 3 {
            showIsland()
        }
    }
    
    //FIX
    func showDesert() {
        desertCoordinator = DesertCoordinator()
        desertCoordinator.levelCoordinator = self
        desertCoordinator.navigationController = self.navigationController
        desertCoordinator.start()
    }
    
    func showMountain() {
        otherViewController = OtherLevelsViewController()
        otherViewController.setupView(levelName: "Mountain", imageName: "mountainBack")
        navigationController?.pushViewController(otherViewController, animated: true)
    }
    
    func showOcean() {
        otherViewController = OtherLevelsViewController()
        otherViewController.setupView(levelName: "Ocean", imageName: "oceanBack")
        navigationController?.pushViewController(otherViewController, animated: true)
    }
    
    func showIsland() {
        otherViewController = OtherLevelsViewController()
        otherViewController.setupView(levelName: "Island", imageName: "islandBack")
        navigationController?.pushViewController(otherViewController, animated: true)
    }
}
