
import Foundation
import UIKit

extension LevelsSelectionViewController {
    
    func setupButton() {
        levelsSelectionView.homeButton.addTarget(self, action: #selector(homePressed), for: .touchUpInside)
        
        inDevelopmnentView.okButton.addTarget(self, action: #selector(showBiome), for: .touchUpInside)
    }
    
    @objc
    func homePressed() {
        AudioManager.shared.buttonClickEffect()
        coordinator?.showHome()
    }
    
    @objc
    func showBiome() {
        AudioManager.shared.buttonClickEffect()
        UIView.animate(withDuration: 0.3) {
            self.inDevelopmentViewBottomConstraint?.update(offset: +self.view.bounds.height)
            self.dimView.isHidden = true
            self.view.layoutIfNeeded()  // Применяем изменения
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.coordinator?.setupBiome(index: self.currentBiomeIndex)
        }
    }
}
