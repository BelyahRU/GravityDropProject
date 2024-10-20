import SpriteKit

struct PhysicsCategory {
    static let none: UInt32 = 0       // Категория для объектов, которые не имеют физических взаимодействий
    static let ball: UInt32 = 0x1 << 0  // Битовая маска для мяча
    static let gravityZone: UInt32 = 0x1 << 1  // Битовая маска для гравитационных зон
    static let boundary: UInt32 = 0x1 << 2  // Битовая маска для границ
    static let box: UInt32 = 0x1 << 3  // Битовая маска для коробки
    static let star: UInt32 = 0x1 << 4
    static let obstacle: UInt32 = 0x1 << 5
}




class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball: SKShapeNode!
    var gravityZones: [SKSpriteNode] = []
    var isInGravityZone = false
    let background = SKSpriteNode(imageNamed: Resources.Images.gameBackView)
    var box: SKSpriteNode!
    var starsCollected: Int = 0  // Количество собранных звезд
    var currentLevel = 1
    weak var gameViewControllerDelegate: GameViewController?

    override func didMove(to view: SKView) {
        setupBackground()
        setupScene()
        self.backgroundColor = .clear
    }

    func reloadLevel() {
        // Очищаем текущие узлы сцены (мяч, зоны гравитации, коробку и т.д.)
        removeAllChildren()
        gravityZones.removeAll()

        // Заново создаем фон и границы
        setupBackground()
        setupScene()
        starsCollected = 0
        gameViewControllerDelegate?.updateStarsView(stars: starsCollected)
        // Перезапускаем уровень с тем же номером
        setupLevel(num: currentLevel)
    }
    
    func setupBackground() {
            // Создайте SKSpriteNode с фоновым изображением
        // Замените на ваше изображение
            background.position = CGPoint(x: frame.midX, y: frame.midY)
            background.zPosition = -1 // Установите zPosition, чтобы фон был позади других узлов
            background.size = self.size // Установите размер фона на размер сцены
            addChild(background)
        }
    
    
    func setupScene() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.3)

        // Создаем физическое тело для границ фона
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: background.frame)
    }


    
    func applyGravity() {
        ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -20))
    }
    
    func applyBoost() {
        if isInGravityZone {
            isInGravityZone = false
            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
        } else {
            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        for gravityZone in gravityZones {
            let distance = distanceBetween(ball.position, gravityZone.position)
            if distance < 150 {
                let direction = CGVector(dx: gravityZone.position.x - ball.position.x,
                                         dy: gravityZone.position.y - ball.position.y)
                let normalizedDirection = normalizeVector(direction)
                let gravityStrength = CGFloat(100)
                ball.physicsBody?.applyForce(CGVector(dx: normalizedDirection.dx * gravityStrength,
                                                      dy: normalizedDirection.dy * gravityStrength))
                let angularVelocity = CGFloat(0.1)
                let centripetalForce = CGVector(dx: -normalizedDirection.dy * angularVelocity,
                                                 dy: normalizedDirection.dx * angularVelocity)
                ball.physicsBody?.applyForce(centripetalForce)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB

        // Убедитесь, что мяч попадает в коробку только сверху
        if (firstBody.categoryBitMask == PhysicsCategory.ball && secondBody.categoryBitMask == PhysicsCategory.box) ||
            (firstBody.categoryBitMask == PhysicsCategory.box && secondBody.categoryBitMask == PhysicsCategory.ball) {
            endLevel()
        }
    

        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        // Проверяем столкновение мяча со звездой
        if collision == PhysicsCategory.ball | PhysicsCategory.star {
            let starNode = contact.bodyA.categoryBitMask == PhysicsCategory.star ? contact.bodyA.node : contact.bodyB.node
            
            // Увеличиваем счётчик звезд и удаляем звезду
            starNode?.removeFromParent()
            starsCollected += 1
            AudioManager.shared.ballBasketEffect()
            gameViewControllerDelegate?.updateStarsView(stars: starsCollected)
        }
        
        // Проверяем столкновение мяча с препятствием
        if collision == PhysicsCategory.ball | PhysicsCategory.obstacle {
//            AudioManager.shared.ballMissedEffect()
            endGame()  // Окончание игры при контакте с препятствием
        }
    }

    func endGame() {
        // Останавливаем игру и показываем сообщение о конце игры
        AudioManager.shared.gameOverEffect()
        gameViewControllerDelegate?.showLose(with: 0)
    }


    
    func endLevel() {
        print("Уровень завершён! Мяч попал в коробку сверху.")
        AudioManager.shared.gameOverEffect()
        if starsCollected == 0 {
            gameViewControllerDelegate?.showLose(with: 0)
        } else if starsCollected == 1 {
            gameViewControllerDelegate?.showLose(with: 1)
            UserDataManager.shared.updateLevel(levelNum: currentLevel, isOpened: true, countStars: 1)
        } else {
            //checking that we use only com
            if currentLevel < 5{
                UserDataManager.shared.updateLevel(levelNum: currentLevel, isOpened: true, countStars: starsCollected)
                //level opened?
                if UserDataManager.shared.getLevel(num: currentLevel + 1)!.isOpened {
                    gameViewControllerDelegate?.showWin(with: starsCollected, showNext: true)
                }
                //can open?
                else if UserDataManager.shared.canOpenLevel(currentLevel + 1) {
                    UserDataManager.shared.tryToOpenLevel(currentLevel + 1)
                    gameViewControllerDelegate?.showWin(with: starsCollected, showNext: true)
                //can't open
                } else {
                    gameViewControllerDelegate?.showWin(with: starsCollected, showNext: false)
                }
            } else {
                gameViewControllerDelegate?.showWin(with: starsCollected, showNext: false)
            }
        }
    }
    
    func distanceBetween(_ point1: CGPoint, _ point2: CGPoint) -> CGFloat {
        return sqrt(pow(point1.x - point2.x, 2) + pow(point1.y - point2.y, 2))
    }
    
    func normalizeVector(_ vector: CGVector) -> CGVector {
        let length = sqrt(vector.dx * vector.dx + vector.dy * vector.dy)
        return CGVector(dx: vector.dx / length, dy: vector.dy / length)
    }
    
    func pause() {
        isPaused.toggle()
    }
}
