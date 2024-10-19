
import Foundation

struct LevelModel: Codable {
    let num: Int
    var isOpened: Bool
    var countStars: Int
    let countStarsNeedToOpen: Int
}


class UserDataManager {
    
    static let shared = UserDataManager()
    
    private let levelsKey = "gameLevels" // Ключ для хранения в UserDefaults
    
    // Стартовые данные по умолчанию
    private var defaultLevels: [LevelModel] {
        return [
            LevelModel(num: 1, isOpened: true, countStars: 0, countStarsNeedToOpen: 0),
            LevelModel(num: 2, isOpened: false, countStars: 0, countStarsNeedToOpen: 2),
            LevelModel(num: 3, isOpened: false, countStars: 0, countStarsNeedToOpen: 4),
            LevelModel(num: 4, isOpened: false, countStars: 0, countStarsNeedToOpen: 7),
            LevelModel(num: 5, isOpened: false, countStars: 0, countStarsNeedToOpen: 10),
            LevelModel(num: 6, isOpened: false, countStars: 0, countStarsNeedToOpen: 15)
        ]
    }
    
    // Получение массива уровней из UserDefaults или использование значений по умолчанию
    var levels: [LevelModel] {
        get {
            if let data = UserDefaults.standard.data(forKey: levelsKey),
               let decodedLevels = try? JSONDecoder().decode([LevelModel].self, from: data) {
                return decodedLevels
            } else {
                return defaultLevels
            }
        }
        set {
            if let encodedLevels = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encodedLevels, forKey: levelsKey)
            }
        }
    }
    
    // Обновление уровня по номеру
    func updateLevel(levelNum: Int, isOpened: Bool? = nil, countStars: Int? = nil) {
        var currentLevels = levels
        
        if let index = currentLevels.firstIndex(where: { $0.num == levelNum }) {
            if let isOpened = isOpened {
                currentLevels[index].isOpened = isOpened
            }
            if let countStars = countStars {
                currentLevels[index].countStars = countStars
            }
            
            // Обновляем уровни
            levels = currentLevels
        }
    }
    
    // Подсчет общего количества собранных звездочек
    func getTotalStars() -> Int {
        return levels.reduce(0) { $0 + $1.countStars }
    }
    
    // Получение информации об уровне по номеру
    func getLevel(num: Int) -> LevelModel? {
        return levels.first { $0.num == num }
    }
    
    // Проверка, можно ли открыть уровень (по количеству звездочек на предыдущих уровнях)
    func canOpenLevel(_ num: Int) -> Bool {
        guard let level = getLevel(num: num) else { return false }
        let totalStars = getTotalStars()
        return totalStars >= level.countStarsNeedToOpen
    }
    
    // Открытие уровня, если выполнены условия
    func tryToOpenLevel(_ num: Int) {
        if canOpenLevel(num) {
            updateLevel(levelNum: num, isOpened: true)
        }
    }
}