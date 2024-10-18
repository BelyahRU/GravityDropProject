

import Foundation
import UIKit

extension LevelsSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        levelsSelectionView.levelsCollectionView.delegate = self
        levelsSelectionView.levelsCollectionView.dataSource = self
        
        levelsSelectionView.levelsCollectionView.register(LevelsSelectionCollectionViewCell.self, forCellWithReuseIdentifier: LevelsSelectionCollectionViewCell.reuseId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelsSelectionCollectionViewCell.reuseId, for: indexPath) as? LevelsSelectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == 0 {
            cell.setupDesert()
        } else {
            cell.setupAnother(with: indexPath.row)
        }
        
        return cell
    }
    
    
}
