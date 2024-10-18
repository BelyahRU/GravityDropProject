
import Foundation
import UIKit

class LevelsSelectionViewController: UIViewController {
    
    let levelsSelectionView = LevelsSelectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(levelsSelectionView)
        
        levelsSelectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
