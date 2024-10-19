
import Foundation
import UIKit

extension OtherLevelsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        levelsCollectionView.delegate = self
        levelsCollectionView.dataSource = self
        
        levelsCollectionView.register(LevelCollectionViewCell.self, forCellWithReuseIdentifier: LevelCollectionViewCell.reuseId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCollectionViewCell.reuseId, for: indexPath) as? LevelCollectionViewCell else {
            print("error collectionview")
            return UICollectionViewCell()
        }
        
        let level = defaultBiomes[currentBiome]![indexPath.row]
        cell.setupCell(levelModel: level)
        return cell
    }
}
