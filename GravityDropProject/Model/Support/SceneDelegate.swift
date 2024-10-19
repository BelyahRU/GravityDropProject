import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator!
    var navigationController: UINavigationController!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        start()
    }
    
    func start() {
        navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        coordinator = MainCoordinator()
        coordinator.navigationController = navigationController
        coordinator.start()
        
//        window?.rootViewController = navigationController
//        window?.rootViewController = LevelViewController()
        let nav = UINavigationController()
        nav.navigationBar.isHidden = true
        nav.pushViewController(LevelsSelectionViewController(), animated: true)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }

    
}



