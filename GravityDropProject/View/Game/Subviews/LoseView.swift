import Foundation
import UIKit

class LoseView: UIView {
    
    private let backView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.winLoseView)
        return im
    }()
    
    private let wowLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        label.text = "Opps!"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let youWinLabel: UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
         label.text = "You Lose"
         label.backgroundColor = .clear
         label.textAlignment = .center
         label.textColor = .white
         return label
     }()
    
    public let starsView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.StarViews.starsView0)
        return im
    }()
    
    public let tryAgainButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.Buttons.tryAgainButton), for: .normal)
         return button
    }()
    
    public let homeButton: UIButton = {
        let button = UIButton()
         button.setImage(UIImage(named: Resources.Buttons.homeButton), for: .normal)
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
        addSubview(backView)
        addSubview(wowLabel)
        addSubview(youWinLabel)
        addSubview(starsView)
        addSubview(tryAgainButton)
        addSubview(homeButton)
    }
    
    private func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        wowLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(26)
        }
        
        youWinLabel.snp.makeConstraints { make in
            make.top.equalTo(wowLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        starsView.snp.makeConstraints { make in
            make.top.equalTo(youWinLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(228)
            make.height.equalTo(100)
        }
        
        homeButton.snp.makeConstraints { make in
            make.width.equalTo(278)
            make.height.equalTo(72)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        tryAgainButton.snp.makeConstraints { make in
            make.width.equalTo(278)
            make.height.equalTo(72)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(homeButton.snp.top).offset(-12)
        }
    }
}
