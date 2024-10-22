import Foundation

class LevelFetcher {
    
    static let shared = LevelFetcher()
    
    private let userDefaults = UserDefaults.standard
    private let levelKey = "lastOpenedLevel"
    
    private init() {}
    
    func saveLevel(_ level: Int) {
        userDefaults.set(level, forKey: levelKey)
    }
    
    func getLastSavedLevel() -> Int {
        let level: Int? = userDefaults.integer(forKey: levelKey)
        if level != nil {
            if level! > 0 && level! < 6 {
                return level!
            }
        }
        return 1
    }
}
