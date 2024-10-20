
import Foundation
import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    let viewModel = MainViewModel()
    let mainView = MainView()
    
    let loaderView = LoadingView()
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loaderView)
        loaderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loaderView.setupLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.loaderView.removeFromSuperview()
            self.configure()
        }
    }
    
    private func configure() {
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
