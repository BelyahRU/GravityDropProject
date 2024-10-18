
import Foundation
import UIKit

class LevelsSelectionView: UIView {
    
    private let backview: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.mainBackgound)
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    private let levelsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        label.text = "Levels"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public let userScoresView = UserScoresView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(backview)
        addSubview(levelsLabel)
        addSubview(userScoresView)
    }
    
    private func setupConstraints() {
        backview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
        levelsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        userScoresView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(64)
            make.top.equalTo(levelsLabel.snp.bottom).offset(24)
        }
    }
}
