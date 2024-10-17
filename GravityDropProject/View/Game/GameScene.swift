import SpriteKit

struct PhysicsCategory {
    static let none: UInt32 = 0       // Категория для объектов, которые не имеют физических взаимодействий
    static let ball: UInt32 = 0x1 << 0  // Битовая маска для мяча
    static let gravityZone: UInt32 = 0x1 << 1  // Битовая маска для гравитационных зон
    static let boundary: UInt32 = 0x1 << 2  // Битовая маска для границ
}



class GameScene: SKScene {
    
    var ball: SKShapeNode!
    var gravityZones: [SKSpriteNode] = []
    var isInGravityZone = false
    let background = SKSpriteNode(imageNamed: Resources.Images.gameBackView)

    override func didMove(to view: SKView) {
        setupBackground()
        setupScene()
        setupGravityZones()
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


    func setupGravityZones() {
        // Создаём первое гравитационное поле с изображением
        let gravityZone = SKSpriteNode(imageNamed: "gravityZone") // Замените на ваше изображение
        gravityZone.position = CGPoint(x: frame.width - 120, y: frame.height - 200)
        gravityZone.zPosition = 1
        gravityZone.size = CGSize(width: 200, height: 200) // Размер изображения
        
        // Устанавливаем физическое тело для гравитационной зоны
        gravityZone.physicsBody = SKPhysicsBody(circleOfRadius: gravityZone.size.width / 2) // Устанавливаем радиус по размеру изображения
        gravityZone.physicsBody?.isDynamic = false // Зона не должна двигаться
        gravityZone.physicsBody?.categoryBitMask = PhysicsCategory.gravityZone // Устанавливаем битовую маску для зоны
        gravityZone.physicsBody?.contactTestBitMask = PhysicsCategory.ball // С чем зона может взаимодействовать
        gravityZone.physicsBody?.collisionBitMask = 0 // Зона не должна сталкиваться, только влиять

        addChild(gravityZone)
        gravityZones.append(gravityZone)
        
        // Создаём второе гравитационное поле с другим изображением
        let gravityZone2 = SKSpriteNode(imageNamed: "gravityZone")
        gravityZone2.position = CGPoint(x: 100, y: 100)
        gravityZone2.zPosition = 1
        gravityZone2.size = CGSize(width: 120, height: 120)
        
        // Устанавливаем физическое тело для второго поля
        gravityZone2.physicsBody = SKPhysicsBody(circleOfRadius: gravityZone2.size.width / 2)
        gravityZone2.physicsBody?.isDynamic = false
        gravityZone2.physicsBody?.categoryBitMask = PhysicsCategory.gravityZone
        gravityZone2.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        gravityZone2.physicsBody?.collisionBitMask = 0

        addChild(gravityZone2)
        gravityZones.append(gravityZone2)
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
