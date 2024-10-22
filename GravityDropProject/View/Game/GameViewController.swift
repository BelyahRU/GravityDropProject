import UIKit
import SpriteKit
import SnapKit

protocol GameViewControllerDelegate: AnyObject {
    func updateStarsView(stars: Int)
    func showLose(with stars: Int)
    func showWin(with stars: Int, showNext: Bool)
}

class GameViewController: UIViewController, GameViewControllerDelegate {
    
    var scene: GameScene!
    
    weak var coordinator: DesertCoordinator?
    
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
        label.text = "Level 5"
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
    let loseView = LoseView()
    var winView = WinView()
    var pauseViewBottomConstraint: Constraint?  // Добавим нижнее ограничение для анимации
    var loseViewBottomConstraint: Constraint?  // Добавим нижнее ограничение для анимации
    var winViewBottomConstraint: Constraint?  // Добавим нижнее ограничение для анимации
    var loseShowed = false
    var winShowed = false
    var currentLevel = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        LevelFetcher.shared.saveLevel(currentLevel)
        setupUI()
        setupScene()
        setupButtons()
        view.bringSubviewToFront(gravityButton)
        view.bringSubviewToFront(boostButton)
    }
    
    func setupScene() {
        
        let skView = SKView(frame: .zero)
        view.addSubview(skView)

        skView.backgroundColor = .clear
        skView.ignoresSiblingOrder = true
        if self.view.frame.height < 800 {
            skView.snp.makeConstraints { make in
                make.top.equalTo(starsView.snp.bottom).offset(5)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.height.equalTo(500)
            }
        } else {
            skView.snp.makeConstraints { make in
                make.top.equalTo(starsView.snp.bottom).offset(16)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.height.equalTo(520)
            }
        }
        skView.layoutIfNeeded()
        let sceneSize = CGSize(width: skView.bounds.width, height: skView.bounds.height)
        scene = GameScene(size: sceneSize)
        scene.scaleMode = .resizeFill
        scene.gameViewControllerDelegate = self
        scene.setupLevel(num: currentLevel)
        skView.presentScene(scene)
        currentLevelLabel.text = "Level \(currentLevel)"
        
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
        view.addSubview(loseView)
        view.addSubview(winView)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if self.view.frame.height < 800 {
            
            starsView.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
                make.leading.equalToSuperview().offset(self.view.frame.width / 2 + 10)
                make.width.equalTo(140)
                make.height.equalTo(64)
            }
            
            currentLevelLabel.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-self.view.frame.width / 2 - 10)
                make.centerY.equalTo(starsView.snp.centerY)
            }
            
            pauseButton.snp.makeConstraints { make in
                make.size.equalTo(40)
                make.leading.equalToSuperview().offset(16)
                make.centerY.equalTo(starsView)
            }
        } else {
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
            
            pauseButton.snp.makeConstraints { make in
                make.size.equalTo(40)
                make.leading.equalToSuperview().offset(16)
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            }
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
        
        loseView.snp.makeConstraints { make in
            make.width.equalTo(318)
            make.height.equalTo(427)
            make.centerX.equalToSuperview()
            self.loseViewBottomConstraint = make.bottom.equalTo(view.snp.bottom).offset(427).constraint
        }
        
        winView.snp.makeConstraints { make in
            make.width.equalTo(318)
            make.height.equalTo(427)
            make.centerX.equalToSuperview()
            self.winViewBottomConstraint = make.bottom.equalTo(view.snp.bottom).offset(427).constraint
        }
        
        dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // Затемняющий фон на весь экран
        }
        dimView.isHidden = true
        
    }
    
    func updateStarsView(stars: Int) {
        switch stars {
        case 0 :
            self.starsView.image = UIImage(named: Resources.StarViews.starsView0)
        case 1 :
            self.starsView.image = UIImage(named: Resources.StarViews.starsView1)
        case 2 :
            self.starsView.image = UIImage(named: Resources.StarViews.starsView2)
        default:
            self.starsView.image = UIImage(named: Resources.StarViews.starsView3)
        }
    }
    
    func showLose(with stars: Int) {
        if !loseShowed && !winShowed{
            scene.pause()
            loseShowed = true
            loseView.changeStars(with: stars)
            self.view.bringSubviewToFront(dimView)
            self.view.bringSubviewToFront(loseView)
            UIView.animate(withDuration: 0.3) {
                self.loseViewBottomConstraint?.update(offset: -self.view.bounds.height / 2 + self.loseView.bounds.height / 2)  // Обновляем смещение, чтобы паузовая панель поднялась
                self.dimView.isHidden = false
                self.pauseButton.isHidden = true
                self.view.layoutIfNeeded()  // Применяем изменения
            }
        }
    }
    
    func showWin(with stars: Int, showNext: Bool) {
        if !loseShowed && !winShowed{
            scene.pause()
            winView.setupAction(showNext: showNext)
            winShowed = true
            winView.changeStars(with: stars)
            winView.layoutIfNeeded()
            
//            scene.pause()
            // Анимация плавного появления `PauseView`
            self.view.bringSubviewToFront(dimView)
            self.view.bringSubviewToFront(winView)
            UIView.animate(withDuration: 0.3) {
                self.winViewBottomConstraint?.update(offset: -self.view.bounds.height / 2 + self.winView.bounds.height / 2)  // Обновляем смещение, чтобы паузовая панель поднялась
                self.dimView.isHidden = false
                self.pauseButton.isHidden = true
                self.view.layoutIfNeeded()  // Применяем изменения
            }
        }
        
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
    
    func loadNewLevel() {
        // Создаем новую сцену с указанным уровнем
        // Удаляем старую сцену
        if let oldSkView = view.subviews.first(where: { $0 is SKView }) as? SKView {
            oldSkView.removeFromSuperview()
        }
        
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
        scene.gameViewControllerDelegate = self
        scene.setupLevel(num: currentLevel)
        skView.presentScene(scene)
        currentLevelLabel.text = "Level \(currentLevel)"
        LevelFetcher.shared.saveLevel(currentLevel)
    }

}
