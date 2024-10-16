
import Foundation
import UIKit

extension LeaderboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func setupCollectionView() {
        leaderboardView.leadersCollectionView.delegate = self
        leaderboardView.leadersCollectionView.dataSource = self
        
        leaderboardView.leadersCollectionView.register(LeaderCollectionViewCell.self, forCellWithReuseIdentifier: LeaderCollectionViewCell.reuseId)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCountScores()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeaderCollectionViewCell.reuseId, for: indexPath) as? LeaderCollectionViewCell else { return UICollectionViewCell() }
        
        let leader = viewModel.getLeader(by: indexPath.row)
        cell.setupCell(id: indexPath.row + 1, name: leader.name, points: leader.points)
        
        return cell
    }
    
    
}
