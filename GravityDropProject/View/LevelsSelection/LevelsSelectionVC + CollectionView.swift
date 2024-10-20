

import Foundation
import UIKit

extension LevelsSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        levelsSelectionView.levelsCollectionView.delegate = self
        levelsSelectionView.levelsCollectionView.dataSource = self
        levelsSelectionView.levelsCollectionView.isUserInteractionEnabled = true
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentBiomeIndex = indexPath.row
        if currentBiomeIndex == 0 {
            AudioManager.shared.buttonClickEffect()
            coordinator?.setupBiome(index: 0)
        } else {
            self.inDevelopmnentView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.dimView.isHidden = false
                self.inDevelopmentViewBottomConstraint?.update(offset: -self.view.bounds.height / 2 + self.inDevelopmnentView.bounds.height / 2)
                self.view.layoutIfNeeded()  // Применяем изменения
            }
        }
//        coordinator?.setupBiome(index: indexPath.row)
    }
    
    
}
