 
import Foundation

final class LevelsSelectionViewModel {
    
    let scoresManager = ScoresManager.shared
    
    func getCurrentUserScores() -> Int {
        return scoresManager.getCurrentUserScores()
    }
}

