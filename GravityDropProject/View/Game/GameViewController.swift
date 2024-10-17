import UIKit
import SpriteKit
import SnapKit

class GameViewController: UIViewController {
    
    var scene: GameScene!
    
    let gravityButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: Resources.Buttons.gravityButton), for: .normal)
        return button
    }()
    
    let boostButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: Resources.Buttons.boostButton), for: .normal)
        return button
    }()
    
    let pauseButton: UIButton = {
        let button = UIButton()
         button.setImage(UIImage(named: Resources.Buttons.pauseButton), for: .normal)
         return button
    }()
    
    let starsView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.StarViews.starsView0)
        return im
    }()
    
    let currentLevelLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        label.text = "Level 1"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let backView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.desertGameBackground)
        return im
    }()
    
    let dimView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.52) // Начальная прозрачность
        view.isUserInteractionEnabled = false // Не перехватывает события
        return view
    }()
    
    let pauseView = PauseView()
    var pauseViewBottomConstraint: Constraint?  // Добавим нижнее ограничение для анимации


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupScene()
        setupButtons()
    }
    
    func setupScene() {
        
        let skView = SKView(frame: .zero)
        view.addSubview(skView)

        skView.backgroundColor = .clear
        skView.ignoresSiblingOrder = true

        skView.snp.makeConstraints { make in
            make.top.equalTo(starsView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(520)
        }
        skView.layoutIfNeeded()
        let sceneSize = CGSize(width: skView.bounds.width, height: skView.bounds.height)
        scene = GameScene(size: sceneSize)
        scene.scaleMode = .resizeFill

        skView.presentScene(scene)
        
    }
    
    func setupUI() {
        view.addSubview(backView)
        view.addSubview(gravityButton)
        view.addSubview(boostButton)
        view.addSubview(currentLevelLabel)
        view.addSubview(starsView)
        view.addSubview(pauseButton)
        view.addSubview(pauseView)
        view.addSubview(dimView)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pauseButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        currentLevelLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.centerX.equalToSuperview()
        }
        
        starsView.snp.makeConstraints { make in
            make.top.equalTo(currentLevelLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(140)
            make.height.equalTo(64)
        }
        
        gravityButton.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalTo(self.view.snp.centerX).offset(5)
        }
        
        boostButton.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalTo(self.view.snp.centerX).offset(-5)
        }
        
        pauseView.snp.makeConstraints { make in
           make.width.equalTo(318)
           make.height.equalTo(336)
           make.centerX.equalToSuperview()
           self.pauseViewBottomConstraint = make.bottom.equalTo(view.snp.bottom).offset(336).constraint  // Появляется снизу
       }
        
        dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // Затемняющий фон на весь экран
        }
        dimView.isHidden = true
        
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
