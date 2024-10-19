

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
        
        if indexPath.row == 0 {
            let vc = LevelViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = OtherLevelsViewController()
            vc.setupView(levelName: "Mountain", imageName: "mountainBack")
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = OtherLevelsViewController()
            vc.setupView(levelName: "Ocean", imageName: "oceanBack")
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = OtherLevelsViewController()
            vc.setupView(levelName: "Island", imageName: "islandBack")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
