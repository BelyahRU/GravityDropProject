
import Foundation

final class MainViewModel {
    
    let scoresManager = ScoresManager.shared
    
    func getCurrentUserScores() -> Int {
        return scoresManager.getCurrentUserScores()
    }
}
