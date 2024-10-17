import SpriteKit

class GameScene: SKScene {
    
    var ball: SKSpriteNode!
    var gravityZones: [SKShapeNode] = []
    var isInGravityZone = false // Флаг для отслеживания нахождения в гравитационной зоне

    override func didMove(to view: SKView) {
        setupScene()
        setupGravityZones()
        setupUI()
        
    }
    
    func setupScene() {
        // Настройка физического мира
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.3) // Слабая гравитация
        physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        // Добавление мячика
        ball = SKSpriteNode(color: .blue, size: CGSize(width: 30, height: 30))
        ball.position = CGPoint(x: frame.midX + 30, y: frame.height)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.restitution = 0.3
        ball.physicsBody?.linearDamping = 0.5

        ball.physicsBody?.angularDamping = 0.5 // Устанавливаем демпфирование для уменьшения вращения
        addChild(ball)
    }
    
    func setupGravityZones() {
        let gravityZone = SKShapeNode(circleOfRadius: 100)
        gravityZone.strokeColor = .green
        gravityZone.position = CGPoint(x: frame.width - 100, y: frame.height - 200)
        addChild(gravityZone)
        gravityZones.append(gravityZone)
        
        let gravityZone2 = SKShapeNode(circleOfRadius: 60)
        gravityZone2.strokeColor = .green
        gravityZone2.position = CGPoint(x: 100, y: 200)
        addChild(gravityZone2)
        gravityZones.append(gravityZone2)
    }
    
    func setupUI() {
        let gravityButton = createButton(title: "Gravity", position: CGPoint(x: 100, y: 50))
        gravityButton.name = "gravityButton"
        addChild(gravityButton)
        
        let boostButton = createButton(title: "Boost", position: CGPoint(x: frame.width - 100, y: 50))
        boostButton.name = "boostButton"
        addChild(boostButton)
    }
    
    func createButton(title: String, position: CGPoint) -> SKLabelNode {
        let button = SKLabelNode(text: title)
        button.fontSize = 24
        button.fontColor = .white
        button.position = position
        button.zPosition = 10
        return button
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "gravityButton" {
                applyGravity()
            } else if touchedNode.name == "boostButton" {
                applyBoost()
            }
        }
    }
    
    func applyGravity() {
//        if let closestZone = closestGravityZone(to: ball.position) {
//            let distance = distanceBetween(ball.position, closestZone.position)
//            if distance < 150 { // Если мяч в зоне гравитации
//                isInGravityZone = true
//            }
//        }
        ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -20))
    }
    
    func applyBoost() {
        if isInGravityZone {
            // Если в зоне гравитации, выходим из неё
            isInGravityZone = false
            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30)) // Применяем импульс вверх
        } else {
            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)

        // Логика для притяжения к гравитационным зонам
        for gravityZone in gravityZones {
            let distance = distanceBetween(ball.position, gravityZone.position)

            if distance < 150 { // В зоне влияния гравитации
                let direction = CGVector(dx: gravityZone.position.x - ball.position.x,
                                         dy: gravityZone.position.y - ball.position.y)
                let normalizedDirection = normalizeVector(direction)

                // Более плавная сила притяжения
                let gravityStrength = CGFloat(100) // Меньшая сила притяжения для более мягкого движения

                // Применяем гравитационную силу
                ball.physicsBody?.applyForce(CGVector(dx: normalizedDirection.dx * gravityStrength,
                                                      dy: normalizedDirection.dy * gravityStrength))

                // Более медленное вращение для "кругового" движения
                let angularVelocity = CGFloat(0.1) // Меньшая угловая скорость для более плавного закручивания

                // Центростремительная сила для закручивания
                let centripetalForce = CGVector(dx: -normalizedDirection.dy * angularVelocity,
                                                 dy: normalizedDirection.dx * angularVelocity)

                // Применяем центростремительную силу
                ball.physicsBody?.applyForce(centripetalForce)
            }
        }
    }


    func endGame() {
        print("Game Over") // Здесь можно добавить логику завершения игры (показать экран завершения и т.д.)
        // Например, можно остановить физику:
        self.isPaused = true
    }

    // Поиск ближайшей гравитационной зоны
    func closestGravityZone(to position: CGPoint) -> SKShapeNode? {
        return gravityZones.min { distanceBetween($0.position, position) < distanceBetween($1.position, position) }
    }

    // Вспомогательные методы для расчета расстояния и нормализации вектора
    func distanceBetween(_ point1: CGPoint, _ point2: CGPoint) -> CGFloat {
        return sqrt(pow(point1.x - point2.x, 2) + pow(point1.y - point2.y, 2))
    }
    
    func normalizeVector(_ vector: CGVector) -> CGVector {
        let length = sqrt(vector.dx * vector.dx + vector.dy * vector.dy)
        return CGVector(dx: vector.dx / length, dy: vector.dy / length)
    }
}
