
import Foundation

final class ScoresManager {
    
    static let shared = ScoresManager()
    var currentScores = 0
    
    private init() { }
    
    func getCurrentUserScores() -> Int {
        return currentScores
    }
}
