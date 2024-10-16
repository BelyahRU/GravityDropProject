
import Foundation

final class LeadersViewModel {
    
    let leadersFetcher = LeaderFetcher.shared
    let scoresManager = ScoresManager.shared
    var leadersArray:[Leader] = []
    
    init() {
        self.leadersArray = leadersFetcher.getAll()
        addSelf()
    }
    
    func getCountScores() -> Int {
        return leadersArray.count
    }
    
    func getLeader(by id: Int) -> Leader {
        return leadersArray[id]
    }
    
    private func addSelf() {
        let you = Leader(name: "you", points: scoresManager.getCurrentUserScores())
        leadersArray.append(you)
        
        leadersArray.sort(by: { $0.points > $1.points })
    }
    
}
