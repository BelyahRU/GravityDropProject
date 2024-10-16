
import Foundation
import UIKit

final class LeaderboardViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    let leaderboardView = LeaderboardView()
    let viewModel = LeadersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupButton()
    }
    
    func setupUI() {
        view.addSubview(leaderboardView)
        
        leaderboardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
