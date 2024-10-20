
import Foundation
import UIKit
import SnapKit

class LevelsSelectionViewController: UIViewController {
    
    weak var coordinator: LevelCoordinator?
    
    let levelsSelectionView = LevelsSelectionView()
    let viewModel = LevelsSelectionViewModel()
    let inDevelopmnentView = InDevelopmentView()
    var currentBiomeIndex = 0
    
    let dimView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.52) // Начальная прозрачность
        view.isUserInteractionEnabled = false // Не перехватывает события
        return view
    }()
    
    var inDevelopmentViewBottomConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        setupButton()
        setupViewModel()
        setupUI()
        setupCollectionView()
    }
    
    private func setupViewModel() {
        levelsSelectionView.userScoresView.pointsLabel.text = String(viewModel.getCurrentUserScores())
    }
    
    private func setupUI() {
        view.addSubview(levelsSelectionView)
        view.addSubview(dimView)
        view.addSubview(inDevelopmnentView)
        
        levelsSelectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        inDevelopmnentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(124)
            make.width.equalTo(318)
            self.inDevelopmentViewBottomConstraint = make.bottom.equalTo(view.snp.bottom).offset(124).constraint
        }
        
        
        inDevelopmnentView.isHidden = true
        
        dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // Затемняющий фон на весь экран
        }
        dimView.isHidden = true
    }
}
