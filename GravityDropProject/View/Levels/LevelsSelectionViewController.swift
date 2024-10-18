
import Foundation
import UIKit

class LevelsSelectionViewController: UIViewController {
    
    let levelsSelectionView = LevelsSelectionView()
    let viewModel = LevelsSelectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        setupViewModel()
        setupUI()
        setupCollectionView()
    }
    
    private func setupViewModel() {
        levelsSelectionView.userScoresView.pointsLabel.text = String(viewModel.getCurrentUserScores())
    }
    
    private func setupUI() {
        view.addSubview(levelsSelectionView)
        
        levelsSelectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
