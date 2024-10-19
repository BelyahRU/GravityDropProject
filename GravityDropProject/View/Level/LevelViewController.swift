
import Foundation
import UIKit

class LevelViewController: UIViewController {
    
    let levelsView = LevelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        view.addSubview(levelsView)
        
        levelsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        levelsView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }
    
    @objc
    func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}
