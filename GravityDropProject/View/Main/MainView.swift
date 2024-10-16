
import Foundation
import UIKit
import SnapKit

final class MainView: UIView {
    
    private let backview: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.mainBackgound)
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    private let gravityDropLabel: UIImageView = {
        let im = UIImageView()
         im.image = UIImage(named: Resources.Images.gravityDropLabel)
         im.contentMode = .scaleAspectFit
         return im
    }()
    
    public let userScoresView = UserScoresView()
    
    public let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.Buttons.playButton), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    public let leaderboardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.Buttons.leaderboardButton), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    public let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.Buttons.settingsButton), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
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
        addSubview(gravityDropLabel)
        addSubview(userScoresView)
        addSubview(playButton)
        addSubview(leaderboardButton)
        addSubview(settingsButton)
    }
    
    private func setupConstraints() {
        backview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gravityDropLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(150)
        }
        
        userScoresView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(64)
            make.top.equalTo(gravityDropLabel.snp.bottom).offset(24)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(318)
            make.height.equalTo(80)
            make.top.equalTo(gravityDropLabel.snp.bottom).offset(265)
        }
        
        leaderboardButton.snp.makeConstraints { make in
            make.width.equalTo(260)
            make.height.equalTo(72)
            make.centerX.equalToSuperview()
            make.top.equalTo(playButton.snp.bottom).offset(72)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.width.equalTo(260)
            make.height.equalTo(72)
            make.centerX.equalToSuperview()
            make.top.equalTo(leaderboardButton.snp.bottom).offset(16)
        }
    }
}
