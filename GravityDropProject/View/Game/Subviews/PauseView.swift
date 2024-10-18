
import Foundation
import UIKit

class PauseView: UIView {
    
    private let backView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.pauseBackview)
        return im
    }()
    
    private let pauseLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        label.text = "Pause"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public let continueButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.Buttons.continueButton), for: .normal)
         return button
    }()
    
    public let tryAgainButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.Buttons.tryAgainButton), for: .normal)
         return button
    }()
    
    public let exitButton: UIButton = {
        let button = UIButton()
         button.setImage(UIImage(named: Resources.Buttons.exitButton), for: .normal)
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
        addSubview(pauseLabel)
        addSubview(continueButton)
        addSubview(tryAgainButton)
        addSubview(exitButton)
    }
    
    private func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pauseLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(26)
        }
        
        exitButton.snp.makeConstraints { make in
            make.width.equalTo(278)
            make.height.equalTo(72)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        tryAgainButton.snp.makeConstraints { make in
            make.width.equalTo(278)
            make.height.equalTo(72)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(exitButton.snp.top).offset(-12)
        }
        
        continueButton.snp.makeConstraints { make in
            make.width.equalTo(278)
            make.height.equalTo(72)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(tryAgainButton.snp.top).offset(-12)
        }
    }
}
