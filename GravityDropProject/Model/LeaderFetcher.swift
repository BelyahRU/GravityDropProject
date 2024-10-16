
import Foundation

final class LeaderFetcher {
    
    private var leadersArray: [Leader] = [
        Leader(name: "Noah", points: 14),
        Leader(name: "William", points: 14),
        Leader(name: "Felix", points: 13),
        Leader(name: "Lida", points: 11),
        Leader(name: "Alex", points: 11),
        Leader(name: "Benjamin", points: 8),
        Leader(name: "Amina", points: 7),
    ]
    
    static let shared = LeaderFetcher()
    
    private init() { }
    
    public func getAll() -> [Leader] {
        return leadersArray
    }
}
