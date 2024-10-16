
import Foundation
import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    let settingsView = SettingsView()
    let clearProgressView = ClearProgressAgreeView()
    
    var clearProgressTopConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        setupUI()
        setupAction()
    }
    
    private func setupUI() {
        view.addSubview(settingsView)
        
        settingsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(clearProgressView)
                
        clearProgressView.snp.makeConstraints { make in
            make.width.equalTo(318)
            make.height.equalTo(184)
            make.centerX.equalToSuperview()
            clearProgressTopConstraint = make.top.equalTo(view.snp.bottom).constraint
        }
        
    }
    
}
