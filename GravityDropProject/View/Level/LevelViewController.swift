
import Foundation
import UIKit
import SnapKit

class LevelViewController: UIViewController {
    
    weak var coordinator: DesertCoordinator?
    let levelsView = LevelView()
    
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
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        view.addSubview(levelsView)
        
        levelsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        levelsView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        
        view.addSubview(dimView)
        view.addSubview(inDevelopmnentView)
        
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
        
        inDevelopmnentView.okButton.addTarget(self, action: #selector(okPressed), for: .touchUpInside)
    }
    
    @objc
    func backPressed() {
        AudioManager.shared.buttonClickEffect()
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func okPressed() {
        AudioManager.shared.buttonClickEffect()
        UIView.animate(withDuration: 0.3) {
            self.inDevelopmentViewBottomConstraint?.update(offset: +self.view.bounds.height)
            self.dimView.isHidden = true
            self.view.layoutIfNeeded()  // Применяем изменения
        }
    }
}
