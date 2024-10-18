

import Foundation
import UIKit
import SpriteKit

extension GameScene {
    public func setupLevel(num: Int) {
        switch num {
        case 2:
            setupSecondLevel()
        case 3:
            setupThirdLevel()
        case 4:
            setupFourthLevel()
        case 5:
            setupFifthLevel()
        default:
            setupFirstLevel()
        }
    }
    
    
    
    //MARK: - First Level
    private func setupFirstLevel() {
        setupFirstGravityZones()
        setupFirstBox()
        spawnFirstStars()
        box.size = CGSize(width: 80, height: 40)
        addChild(box)
    }
    
    func setupFirstBox() {
        // Добавляем коробку в сцену
        box = SKSpriteNode(imageNamed: "winBox") // Замените на ваше изображение коробки
        box.position = CGPoint(x: self.background.frame.width - 58, y: 36)  // Текущие отступы от trailing и bottom
        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.isDynamic = false  // Коробка неподвижная
        box.physicsBody?.categoryBitMask = PhysicsCategory.box  // Категория коробки
        box.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизий с мячом
        box.physicsBody?.collisionBitMask = PhysicsCategory.ball  // Мяч должен столкнуться с коробкой
        box.physicsBody?.restitution = 0  // Без отскока
    }
    
    func setupFirstGravityZones() {
        let gravityZone = SKSpriteNode(imageNamed: "gravityZone")
        gravityZone.position = CGPoint(x: frame.width - 120, y: frame.height - 200)
        gravityZone.zPosition = 1
        gravityZone.size = CGSize(width: 200, height: 200)
        
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
    
    
    //MARK: - Second Level
    func spawnFirstStars() {
        for _ in 1...3 {  // Добавляем 3 звездочки
            let star = SKSpriteNode(imageNamed: "starImage")  // Замените на ваше изображение звезды
            star.size = CGSize(width: 28, height: 28)  // Размер звезды
            star.position = CGPoint(x: CGFloat.random(in: 50...self.size.width - 140),
                                    y: CGFloat.random(in: self.size.height / 2...self.size.height - 50))
            
            star.physicsBody = SKPhysicsBody(circleOfRadius: star.size.width / 2)
            star.physicsBody?.isDynamic = false  // Звезды не должны двигаться
            star.physicsBody?.categoryBitMask = PhysicsCategory.star  // Категория звезд
            star.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
            star.physicsBody?.collisionBitMask = PhysicsCategory.none  // Звезды не должны сталкиваться с другими объектами
            
            addChild(star)
        }
    }
    
    
    private func setupSecondLevel() {
        setupSecondGravityZones()
        setupFirstBox()
        spawnSecondStars()
        spawnSecondObstacles()
        box.size = CGSize(width: 80, height: 40)
        addChild(box)
    }
    
    func setupSecondGravityZones() {
        let gravityZone = SKSpriteNode(imageNamed: "gravityZone")
        gravityZone.position = CGPoint(x: frame.width / 2 - 50, y: frame.height - 200)
        gravityZone.zPosition = 1
        gravityZone.size = CGSize(width: 100, height: 100)
        
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
        gravityZone2.size = CGSize(width: 100, height: 100)
        
        // Устанавливаем физическое тело для второго поля
        gravityZone2.physicsBody = SKPhysicsBody(circleOfRadius: gravityZone2.size.width / 2)
        gravityZone2.physicsBody?.isDynamic = false
        gravityZone2.physicsBody?.categoryBitMask = PhysicsCategory.gravityZone
        gravityZone2.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        gravityZone2.physicsBody?.collisionBitMask = 0

        addChild(gravityZone2)
        gravityZones.append(gravityZone2)
    }
    
    func spawnSecondStars() {
        for _ in 1...2 {  // Добавляем 3 звездочки
            let star = SKSpriteNode(imageNamed: "starImage")  // Замените на ваше изображение звезды
            star.size = CGSize(width: 28, height: 28)  // Размер звезды
            star.position = CGPoint(x: CGFloat.random(in: 50...200),
                                    y: CGFloat.random(in: self.size.height / 4...self.size.height - 50))
            
            star.physicsBody = SKPhysicsBody(circleOfRadius: star.size.width / 2)
            star.physicsBody?.isDynamic = false  // Звезды не должны двигаться
            star.physicsBody?.categoryBitMask = PhysicsCategory.star  // Категория звезд
            star.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
            star.physicsBody?.collisionBitMask = PhysicsCategory.none  // Звезды не должны сталкиваться с другими объектами
            
            addChild(star)
        }
        
        let star = SKSpriteNode(imageNamed: "starImage")  // Замените на ваше изображение звезды
        star.size = CGSize(width: 28, height: 28)  // Размер звезды
        star.position = CGPoint(x: CGFloat(self.size.width - 130),
                                       y: CGFloat(100))
        
        star.physicsBody = SKPhysicsBody(circleOfRadius: star.size.width / 2)
        star.physicsBody?.isDynamic = false  // Звезды не должны двигаться
        star.physicsBody?.categoryBitMask = PhysicsCategory.star  // Категория звезд
        star.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        star.physicsBody?.collisionBitMask = PhysicsCategory.none  // Звезды не должны сталкиваться с другими объектами
        
        addChild(star)
    }
    
    func spawnSecondObstacles() {
        // Создание красной палочки
        let stickTexture = SKTexture(imageNamed: Resources.Obstacles.verticalRectangleObstacle)  // Имя файла изображения палочки
        let stick = SKSpriteNode(texture: stickTexture)
        stick.size = CGSize(width: 20, height: 176)  // Пример размера палочки
        stick.position = CGPoint(x: CGFloat(self.size.width - 80),
                                 y: CGFloat(self.size.height / 4 * 3))
        
        stick.physicsBody = SKPhysicsBody(texture: stickTexture, size: stick.size)
        stick.physicsBody?.isDynamic = false  // Препятствие не двигается
        stick.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        stick.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        stick.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(stick)
        
        
        let stickTexture2 = SKTexture(imageNamed: Resources.Obstacles.rectangleObstacle60x8)  // Имя файла изображения палочки
        let stick2 = SKSpriteNode(texture: stickTexture2)
        stick2.size = CGSize(width: 80, height: 20)  // Пример размера палочки
        stick2.position = CGPoint(x: CGFloat(self.size.width - 60),
                                 y: CGFloat(self.size.height / 2))
        
        stick2.physicsBody = SKPhysicsBody(texture: stickTexture2, size: stick2.size)
        stick2.physicsBody?.isDynamic = false  // Препятствие не двигается
        stick2.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        stick2.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        stick2.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(stick2)
        
        // Создание препятствия с текстурой красного шарика
        let ballTexture = SKTexture(imageNamed: Resources.Obstacles.circleObstacle)  // Имя файла изображения шарика
        let ball = SKSpriteNode(texture: ballTexture)
        ball.size = CGSize(width: 30, height: 30)  // Пример размера шарика
        ball.position = CGPoint(x: CGFloat.random(in: 50...self.size.width / 2 - 50),
                                y: CGFloat.random(in: self.size.height / 4 * 3...self.size.height - 50))
        
        ball.physicsBody = SKPhysicsBody(texture: ballTexture, size: ball.size)
        ball.physicsBody?.isDynamic = false  // Препятствие не двигается
        ball.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        ball.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(ball)

    }
    
    
    private func setupThirdLevel() {
        setupFirstBox()
        setupThirdGravityZones()
        spawnSecondStars()
        spawnThirdObstacles()
        box.size = CGSize(width: 80, height: 40)
        addChild(box)
    }
    
    private func setupThirdGravityZones() {
        let gravityZone = SKSpriteNode(imageNamed: "gravityZone")
        gravityZone.position = CGPoint(x: 150, y: 100)
        gravityZone.zPosition = 1
        gravityZone.size = CGSize(width: 150, height: 150)
        
        gravityZone.physicsBody = SKPhysicsBody(circleOfRadius: gravityZone.size.width / 2) // Устанавливаем радиус по размеру изображения
        gravityZone.physicsBody?.isDynamic = false // Зона не должна двигаться
        gravityZone.physicsBody?.categoryBitMask = PhysicsCategory.gravityZone // Устанавливаем битовую маску для зоны
        gravityZone.physicsBody?.contactTestBitMask = PhysicsCategory.ball // С чем зона может взаимодействовать
        gravityZone.physicsBody?.collisionBitMask = 0 // Зона не должна сталкиваться, только влиять

        addChild(gravityZone)
        gravityZones.append(gravityZone)
        
        // Создаём второе гравитационное поле с другим изображением
        let gravityZone2 = SKSpriteNode(imageNamed: "gravityZone")
        gravityZone2.position = CGPoint(x: 150, y: 400)
        gravityZone2.zPosition = 1
        gravityZone2.size = CGSize(width: 100, height: 100)
        
        // Устанавливаем физическое тело для второго поля
        gravityZone2.physicsBody = SKPhysicsBody(circleOfRadius: gravityZone2.size.width / 2)
        gravityZone2.physicsBody?.isDynamic = false
        gravityZone2.physicsBody?.categoryBitMask = PhysicsCategory.gravityZone
        gravityZone2.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        gravityZone2.physicsBody?.collisionBitMask = 0

        addChild(gravityZone2)
        gravityZones.append(gravityZone2)
        
        // Создаём второе гравитационное поле с другим изображением
        let gravityZone3 = SKSpriteNode(imageNamed: "gravityZone")
        gravityZone3.position = CGPoint(x: self.frame.width - 80, y: self.size.height-150)
        gravityZone3.zPosition = 1
        gravityZone3.size = CGSize(width: 60, height: 60)
        
        // Устанавливаем физическое тело для второго поля
        gravityZone3.physicsBody = SKPhysicsBody(circleOfRadius: gravityZone3.size.width / 2)
        gravityZone3.physicsBody?.isDynamic = false
        gravityZone3.physicsBody?.categoryBitMask = PhysicsCategory.gravityZone
        gravityZone3.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        gravityZone3.physicsBody?.collisionBitMask = 0

        addChild(gravityZone3)
        gravityZones.append(gravityZone3)
    }
    
    func spawnThirdObstacles() {
        // Создание препятствия с текстурой красного шарика
        let ballTexture = SKTexture(imageNamed: Resources.Obstacles.circleObstacle)  // Имя файла изображения шарика
        let ball = SKSpriteNode(texture: ballTexture)
        ball.size = CGSize(width: 30, height: 30)  // Пример размера шарика
        ball.position = CGPoint(x: CGFloat(self.size.width / 4 - 20),
                                 y: CGFloat(self.size.height / 2 - 80))
        
        ball.physicsBody = SKPhysicsBody(texture: ballTexture, size: ball.size)
        ball.physicsBody?.isDynamic = false  // Препятствие не двигается
        ball.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        ball.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(ball)
        
        let ball2 = SKSpriteNode(texture: ballTexture)
        ball2.size = CGSize(width: 30, height: 30)  // Пример размера шарика
        ball2.position = CGPoint(x: CGFloat(self.size.width / 4 * 2 + 60),
                                 y: CGFloat(self.size.height / 2 - 70))
        
        ball2.physicsBody = SKPhysicsBody(texture: ballTexture, size: ball2.size)
        ball2.physicsBody?.isDynamic = false  // Препятствие не двигается
        ball2.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        ball2.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        ball2.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(ball2)

        let stickTexture = SKTexture(imageNamed: Resources.Obstacles.verticalRectangleObstacle)  // Имя файла изображения палочки
        let stick = SKSpriteNode(texture: stickTexture)
        stick.size = CGSize(width: 20, height: 120)  // Пример размера палочки
        stick.position = CGPoint(x: box.frame.minX - 5,
                                 y: 60)
        
        stick.physicsBody = SKPhysicsBody(texture: stickTexture, size: stick.size)
        stick.physicsBody?.isDynamic = false  // Препятствие не двигается
        stick.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        stick.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        stick.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(stick)
        
        let stickTexture2 = SKTexture(imageNamed: Resources.Obstacles.rectangleObstacle60x8)  // Имя файла изображения палочки
        let stick2 = SKSpriteNode(texture: stickTexture2)
        stick2.size = CGSize(width: 80, height: 20)  // Пример размера палочки
        stick2.position = CGPoint(x: CGFloat(self.size.width - 40),
                                 y: CGFloat(self.size.height - 40))
        
        stick2.physicsBody = SKPhysicsBody(texture: stickTexture2, size: stick2.size)
        stick2.physicsBody?.isDynamic = false  // Препятствие не двигается
        stick2.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        stick2.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        stick2.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(stick2)
    }
    
    private func setupFourthLevel() {
        setupFirstBox()
        setupFourthGravityZones()
        spawnFourthStars()
        spawnFourthObstacles()
        box.size = CGSize(width: 60, height: 30)
        addChild(box)
    }
    
    
    private func setupFourthGravityZones() {
        let gravityZone = SKSpriteNode(imageNamed: "gravityZone")
        gravityZone.position = CGPoint(x: self.size.width / 2 , y: self.frame.height / 2)
        gravityZone.zPosition = 1
        gravityZone.size = CGSize(width: 200, height: 200)
        
        gravityZone.physicsBody = SKPhysicsBody(circleOfRadius: gravityZone.size.width / 2) // Устанавливаем радиус по размеру изображения
        gravityZone.physicsBody?.isDynamic = false // Зона не должна двигаться
        gravityZone.physicsBody?.categoryBitMask = PhysicsCategory.gravityZone // Устанавливаем битовую маску для зоны
        gravityZone.physicsBody?.contactTestBitMask = PhysicsCategory.ball // С чем зона может взаимодействовать
        gravityZone.physicsBody?.collisionBitMask = 0 // Зона не должна сталкиваться, только влиять

        addChild(gravityZone)
        gravityZones.append(gravityZone)
        
        // Создаём второе гравитационное поле с другим изображением
        let gravityZone2 = SKSpriteNode(imageNamed: "gravityZone")
        gravityZone2.position = CGPoint(x: 150, y: 400)
        gravityZone2.zPosition = 1
        gravityZone2.size = CGSize(width: 60, height: 60)
        
        // Устанавливаем физическое тело для второго поля
        gravityZone2.physicsBody = SKPhysicsBody(circleOfRadius: gravityZone2.size.width / 2)
        gravityZone2.physicsBody?.isDynamic = false
        gravityZone2.physicsBody?.categoryBitMask = PhysicsCategory.gravityZone
        gravityZone2.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        gravityZone2.physicsBody?.collisionBitMask = 0

        addChild(gravityZone2)
        gravityZones.append(gravityZone2)
        
        // Создаём второе гравитационное поле с другим изображением
        let gravityZone3 = SKSpriteNode(imageNamed: "gravityZone")
        gravityZone3.position = CGPoint(x: self.frame.width - 80, y: self.size.height-150)
        gravityZone3.zPosition = 1
        gravityZone3.size = CGSize(width: 90, height: 90)
        
        // Устанавливаем физическое тело для второго поля
        gravityZone3.physicsBody = SKPhysicsBody(circleOfRadius: gravityZone3.size.width / 2)
        gravityZone3.physicsBody?.isDynamic = false
        gravityZone3.physicsBody?.categoryBitMask = PhysicsCategory.gravityZone
        gravityZone3.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        gravityZone3.physicsBody?.collisionBitMask = 0

        addChild(gravityZone3)
        gravityZones.append(gravityZone3)
    }
    
    
    func spawnFourthObstacles() {
        // Создание препятствия с текстурой красного шарика
        let ballTexture = SKTexture(imageNamed: Resources.Obstacles.circleObstacle)  // Имя файла изображения шарика
        let ball = SKSpriteNode(texture: ballTexture)
        ball.size = CGSize(width: 30, height: 30)  // Пример размера шарика
        ball.position = CGPoint(x: CGFloat(30),
                                 y: CGFloat(self.size.height - 40))
        
        ball.physicsBody = SKPhysicsBody(texture: ballTexture, size: ball.size)
        ball.physicsBody?.isDynamic = false  // Препятствие не двигается
        ball.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        ball.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(ball)
        
        let ball2 = SKSpriteNode(texture: ballTexture)
        ball2.size = CGSize(width: 30, height: 30)  // Пример размера шарика
        ball2.position = CGPoint(x: CGFloat(10),
                                 y: CGFloat(self.size.height / 2))
        
        ball2.physicsBody = SKPhysicsBody(texture: ballTexture, size: ball2.size)
        ball2.physicsBody?.isDynamic = false  // Препятствие не двигается
        ball2.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        ball2.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        ball2.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(ball2)

        
        let stickTexture2 = SKTexture(imageNamed: Resources.Obstacles.rectangleObstacle132x8)  // Имя файла изображения палочки
        let stick2 = SKSpriteNode(texture: stickTexture2)
        stick2.size = CGSize(width: 200, height: 20)  // Пример размера палочки
        stick2.position = CGPoint(x: CGFloat(160),
                                 y: CGFloat(40))
        
        stick2.physicsBody = SKPhysicsBody(texture: stickTexture2, size: stick2.size)
        stick2.physicsBody?.isDynamic = false  // Препятствие не двигается
        stick2.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        stick2.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        stick2.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(stick2)
        
        let stickTexture3 = SKTexture(imageNamed: Resources.Obstacles.verticalRectangleObstacle)  // Имя файла изображения палочки
        let stick3 = SKSpriteNode(texture: stickTexture3)
        stick3.size = CGSize(width: 20, height: 200)  // Пример размера палочки
        stick3.position = CGPoint(x: 20,
                                 y: 100)
        
        stick3.physicsBody = SKPhysicsBody(texture: stickTexture3, size: stick3.size)
        stick3.physicsBody?.isDynamic = false  // Препятствие не двигается
        stick3.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        stick3.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        stick3.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(stick3)
    }
    
    func spawnFourthStars() {
        for _ in 1...3 {  // Добавляем 3 звездочки
            let star = SKSpriteNode(imageNamed: "starImage")  // Замените на ваше изображение звезды
            star.size = CGSize(width: 28, height: 28)  // Размер звезды
            star.position = CGPoint(x: CGFloat.random(in: 50...self.size.width-50),
                                    y: CGFloat.random(in: self.size.height / 3...self.size.height - 50))
            
            star.physicsBody = SKPhysicsBody(circleOfRadius: star.size.width / 2)
            star.physicsBody?.isDynamic = false  // Звезды не должны двигаться
            star.physicsBody?.categoryBitMask = PhysicsCategory.star  // Категория звезд
            star.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
            star.physicsBody?.collisionBitMask = PhysicsCategory.none  // Звезды не должны сталкиваться с другими объектами
            
            addChild(star)
        }
    }
    
    private func setupFifthLevel() {
        setupFirstBox()
        setupFifthGravityZones()
        spawnFourthStars()
//        spawnFourthObstacles()
        box.size = CGSize(width: 100, height: 50)
        box.position = CGPoint(x: size.width / 2, y: 40)
        addChild(box)
        spawnFifthObstacles()
    }
    
    private func setupFifthGravityZones() {
        let gravityZone = SKSpriteNode(imageNamed: "gravityZone")
        gravityZone.position = CGPoint(x: self.size.width / 2 , y: self.frame.height / 2)
        gravityZone.zPosition = 1
        gravityZone.size = CGSize(width: 200, height: 200)
        
        gravityZone.physicsBody = SKPhysicsBody(circleOfRadius: gravityZone.size.width / 2) // Устанавливаем радиус по размеру изображения
        gravityZone.physicsBody?.isDynamic = false // Зона не должна двигаться
        gravityZone.physicsBody?.categoryBitMask = PhysicsCategory.gravityZone // Устанавливаем битовую маску для зоны
        gravityZone.physicsBody?.contactTestBitMask = PhysicsCategory.ball // С чем зона может взаимодействовать
        gravityZone.physicsBody?.collisionBitMask = 0 // Зона не должна сталкиваться, только влиять

        addChild(gravityZone)
        gravityZones.append(gravityZone)
        
        
    }
    
    func spawnFifthObstacles() {

        
        let stickTexture2 = SKTexture(imageNamed: Resources.Obstacles.rectangleObstacle132x8)  // Имя файла изображения палочки
        let stick2 = SKSpriteNode(texture: stickTexture2)
        stick2.size = CGSize(width: 120, height: 20)  // Пример размера палочки
        stick2.position = CGPoint(x: box.frame.minX - 60,
                                 y: CGFloat(40))
        
        stick2.physicsBody = SKPhysicsBody(texture: stickTexture2, size: stick2.size)
        stick2.physicsBody?.isDynamic = false  // Препятствие не двигается
        stick2.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        stick2.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        stick2.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(stick2)
        
        let stickTexture3 = SKTexture(imageNamed: Resources.Obstacles.verticalRectangleObstacle)  // Имя файла изображения палочки
        let stick3 = SKSpriteNode(texture: stickTexture3)
        stick3.size = CGSize(width: 20, height: 200)  // Пример размера палочки
        stick3.position = CGPoint(x: 20,
                                 y: 100)
        
        stick3.physicsBody = SKPhysicsBody(texture: stickTexture3, size: stick3.size)
        stick3.physicsBody?.isDynamic = false  // Препятствие не двигается
        stick3.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        stick3.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        stick3.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(stick3)
        
        let stick4 = SKSpriteNode(texture: stickTexture2)
        stick4.size = CGSize(width: 120, height: 20)  // Пример размера палочки
        stick4.position = CGPoint(x: box.frame.maxX + 60,
                                 y: CGFloat(40))
        
        stick4.physicsBody = SKPhysicsBody(texture: stickTexture2, size: stick4.size)
        stick4.physicsBody?.isDynamic = false  // Препятствие не двигается
        stick4.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        stick4.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        stick4.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(stick4)
        
        let stick5 = SKSpriteNode(texture: stickTexture3)
        stick5.size = CGSize(width: 20, height: 200)  // Пример размера палочки
        stick5.position = CGPoint(x: size.width - 20,
                                 y: 100)
        
        stick5.physicsBody = SKPhysicsBody(texture: stickTexture3, size: stick5.size)
        stick5.physicsBody?.isDynamic = false  // Препятствие не двигается
        stick5.physicsBody?.categoryBitMask = PhysicsCategory.obstacle  // Категория препятствия
        stick5.physicsBody?.contactTestBitMask = PhysicsCategory.ball  // Проверка коллизии с мячом
        stick5.physicsBody?.collisionBitMask = PhysicsCategory.none  // Без столкновений
        
        addChild(stick5)
    }
    
}
