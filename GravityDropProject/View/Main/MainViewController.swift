
import Foundation
import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    let viewModel = MainViewModel()
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButtons()
        setupViewModel()
    }
    
    private func setupUI() {
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupViewModel() {
        mainView.userScoresView.pointsLabel.text = String(viewModel.getCurrentUserScores())
    }
}
