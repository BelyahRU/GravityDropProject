import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var scene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = SKView(frame: .zero)
        skView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skView)

        skView.backgroundColor = nil
        skView.ignoresSiblingOrder = true

        skView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        skView.layoutIfNeeded()
        let sceneSize = CGSize(width: skView.bounds.width, height: skView.bounds.height)
        scene = GameScene(size: sceneSize)
        scene.scaleMode = .resizeFill

        skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
