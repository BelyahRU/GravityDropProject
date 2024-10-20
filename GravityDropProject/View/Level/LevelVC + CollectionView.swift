
import Foundation
import UIKit

extension LevelViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func setupCollectionView() {
        levelsView.levelsCollectionView.delegate = self
        levelsView.levelsCollectionView.dataSource = self
        
        levelsView.levelsCollectionView.register(LevelCollectionViewCell.self, forCellWithReuseIdentifier: LevelCollectionViewCell.reuseId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCollectionViewCell.reuseId, for: indexPath) as? LevelCollectionViewCell else {
            print("error collectionview")
            return UICollectionViewCell()
        }
        
        guard let level = UserDataManager.shared.getLevel(num: indexPath.row + 1) else {
            print("error viewmodel")
            return UICollectionViewCell()
        }
        
        cell.setupCell(levelModel: level)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 5 {
            guard let level = UserDataManager.shared.getLevel(num: indexPath.row + 1) else {
                print("error viewmodel")
                return
            }
            if level.isOpened {
                coordinator?.showGame(index: indexPath.row)
            }
        } else {
            self.inDevelopmnentView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.dimView.isHidden = false
                self.inDevelopmentViewBottomConstraint?.update(offset: -self.view.bounds.height / 2 + self.inDevelopmnentView.bounds.height / 2)
                self.view.layoutIfNeeded()  // Применяем изменения
            }
        }
    }
}
