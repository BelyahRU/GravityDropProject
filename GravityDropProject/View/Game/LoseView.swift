
import Foundation
import UIKit

class LoseView: UIView {
    
    private let backView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.winLoseView)
        return im
    }()
    
    private let oppsLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        label.text = "Opps!"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let youLoseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 18)
        label.text = "You Lose"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public let starsView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: Resources.ResultStars.result0)
        return view
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
        addSubview(oppsLabel)
        addSubview(youLoseLabel)
        addSubview(tryAgainButton)
        addSubview(homeButton)
        addSubview(starsView)
    }
    
    private func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        oppsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(26)
        }
        
        youLoseLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oppsLabel.snp.bottom).offset(10)
        }
        
        starsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(youLoseLabel.snp.bottom).offset(10)
            make.height.equalTo(100)
            make.width.equalTo(228)
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
