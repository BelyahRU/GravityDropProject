import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController!
    var mainViewController: UIViewController!
    
    
    func start() {
        showMain()
    }
    
    func showMain() {
        mainViewController = MainViewController()
        
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    
}
