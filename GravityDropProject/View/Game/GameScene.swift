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
    weak var gameViewControllerDelegate: GameViewController?

    override func didMove(to view: SKView) {
        setupBackground()
        setupScene()
        self.backgroundColor = .clear
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
        physicsBody?.categoryBitMask = PhysicsCategory.boundary  // Категория для границ
        physicsBody?.collisionBitMask = PhysicsCategory.ball     // Мяч может сталкиваться с границами

        ball = SKShapeNode(circleOfRadius: 12)
        ball.fillColor = .white
        ball.position = CGPoint(x: frame.midX + 30, y: frame.height)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.restitution = 0.3
        ball.physicsBody?.linearDamping = 0.5
        ball.physicsBody?.angularDamping = 0.5
        ball.physicsBody?.categoryBitMask = PhysicsCategory.ball
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.gravityZone // Регистрируем контакт с гравитационной зоной
        ball.physicsBody?.collisionBitMask = PhysicsCategory.boundary // Мяч сталкивается с границами
        
        addChild(ball)
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
                
                // Получаем координаты обоих объектов
                let ballPosition = firstBody.categoryBitMask == PhysicsCategory.ball ? firstBody.node!.position : secondBody.node!.position
                let boxPosition = firstBody.categoryBitMask == PhysicsCategory.box ? firstBody.node!.position : secondBody.node!.position
                
                let ballNode = firstBody.categoryBitMask == PhysicsCategory.ball ? firstBody.node! : secondBody.node!
                let boxNode = firstBody.categoryBitMask == PhysicsCategory.box ? firstBody.node! : secondBody.node!
                
                // Проверяем, касается ли мяч верхней границы коробки
                if ballPosition.y + ball.frame.size.height / 2 >= boxPosition.y - box.frame.size.height / 2 &&
                    (ballNode.frame.minX >= boxNode.frame.minX && ballNode.frame.maxX <= boxNode.frame.maxX) {
                    endLevel()  // Окончание уровня, если мяч касается верхней границы коробки
                } else {
                    // Проверяем, касается ли мяч левой, правой или нижней грани коробки
                    if ballPosition.x + ball.frame.size.width / 2 >= boxPosition.x + box.frame.size.width / 2 {
                        // Столкновение с правой гранью коробки
                        ball.physicsBody?.velocity.dx = -abs(ball.physicsBody!.velocity.dx)
                    } else if ballPosition.x - ball.frame.size.width / 2 <= boxPosition.x - box.frame.size.width / 2 {
                        // Столкновение с левой гранью коробки
                        ball.physicsBody?.velocity.dx = abs(ball.physicsBody!.velocity.dx)
                    } else if ballPosition.y - ball.frame.size.height / 2 <= boxPosition.y - box.frame.size.height / 2 {
                        // Столкновение с нижней гранью коробки
                        ball.physicsBody?.velocity.dy = abs(ball.physicsBody!.velocity.dy)
                    }
                }
            }

        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        // Проверяем столкновение мяча со звездой
        if collision == PhysicsCategory.ball | PhysicsCategory.star {
            let starNode = contact.bodyA.categoryBitMask == PhysicsCategory.star ? contact.bodyA.node : contact.bodyB.node
            
            // Увеличиваем счётчик звезд и удаляем звезду
            starNode?.removeFromParent()
            starsCollected += 1
            gameViewControllerDelegate?.updateStarsView(stars: starsCollected)
        }
        
        // Проверяем столкновение мяча с препятствием
        if collision == PhysicsCategory.ball | PhysicsCategory.obstacle {
            endGame()  // Окончание игры при контакте с препятствием
        }
    }

    func endGame() {
        // Останавливаем игру и показываем сообщение о конце игры
        self.isPaused = true
        
        let gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.fontSize = 40
        gameOverLabel.fontColor = .red
        gameOverLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        addChild(gameOverLabel)
    }


    
    func endLevel() {
        print("Уровень завершён! Мяч попал в коробку сверху.")
        self.isPaused = true
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
