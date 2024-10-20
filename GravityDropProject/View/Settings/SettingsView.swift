
import Foundation
import UIKit

final class SettingsView: UIView {
    
    private let backview: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.mainBackgound)
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    public let settingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        label.text = "Settings"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let soundBackview: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.Images.leaderCell)
        return im
    }()
    
    private let musicBackview: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.Images.leaderCell)
        return im
    }()
    
    private let vibrationBackview: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.Images.leaderCell)
        return im
    }()
    
    public let soundSliderView: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        slider.isContinuous = true
        slider.setThumbImage(UIImage(), for: .normal)
        slider.transform = CGAffineTransform(scaleX: 1, y: 2)
        slider.layer.cornerRadius = 4
        slider.clipsToBounds = true
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = .white.withAlphaComponent(0.52)
        return slider
    }()
    
    public let musicSliderView: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        slider.isContinuous = true
        slider.setThumbImage(UIImage(), for: .normal)
        slider.transform = CGAffineTransform(scaleX: 1, y: 2)
        slider.layer.cornerRadius = 4
        slider.clipsToBounds = true
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = .white.withAlphaComponent(0.52)
        return slider
    }()
    
    let homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.Buttons.homeButton), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let soundPercentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 13)
        label.text = "50%"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let musicPercentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 13)
        label.text = "50%"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let soundImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: Resources.Images.soundImage)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let musicImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: Resources.Images.musicImage)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let vibrationImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: Resources.Images.vibrationImage)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let onButton: UIButton = {
       let button = UIButton()
        button.setTitle("ON", for: .normal)
        button.titleLabel?.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let applyButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "applyButton"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let offButton: UIButton = {
       let button = UIButton()
        button.setTitle("OFF", for: .normal)
        button.titleLabel?.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        button.backgroundColor = .clear
        button.setTitleColor(.white.withAlphaComponent(0.52), for: .normal)
        return button
    }()
    
    let clearProgressButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: Resources.Buttons.clearProgressButton), for: .normal)
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
        addSubview(settingsLabel)
        addSubview(homeButton)
        addSubview(soundBackview)
        addSubview(soundSliderView)
        addSubview(soundImage)
        addSubview(soundPercentLabel)
        addSubview(musicBackview)
        addSubview(musicSliderView)
        addSubview(musicImage)
        addSubview(musicPercentLabel)
        addSubview(vibrationBackview)
        addSubview(vibrationImage)
        addSubview(onButton)
        addSubview(offButton)
        addSubview(clearProgressButton)
        addSubview(applyButton)
    }
    
    private func setupConstraints() {
        backview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        settingsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        
        homeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(72)
            make.width.equalTo(260)
            make.bottom.equalToSuperview().offset(-24)
        }
        
        soundBackview.snp.makeConstraints { make in
            make.top.equalTo(settingsLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(72)
            make.width.equalTo(318)
        }
        
        soundSliderView.snp.makeConstraints { make in
            make.height.equalTo(8)
            make.width.equalTo(190)
            make.centerX.equalTo(soundBackview.snp.centerX)
            make.centerY.equalTo(soundBackview.snp.centerY).offset(-4)
        }
        
        soundImage.snp.makeConstraints { make in
            make.centerY.equalTo(soundSliderView.snp.centerY)
            make.trailing.equalTo(soundSliderView.snp.leading).offset(-8)
            make.size.equalTo(40)
        }
        
        soundPercentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(soundSliderView.snp.centerY)
            make.leading.equalTo(soundSliderView.snp.trailing).offset(8)
        }
        
        
        musicBackview.snp.makeConstraints { make in
            make.top.equalTo(soundBackview.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(72)
            make.width.equalTo(318)
        }
        
        musicSliderView.snp.makeConstraints { make in
            make.height.equalTo(8)
            make.width.equalTo(190)
            make.centerX.equalTo(musicBackview.snp.centerX)
            make.centerY.equalTo(musicBackview.snp.centerY).offset(-4)
        }
        
        musicImage.snp.makeConstraints { make in
            make.centerY.equalTo(musicSliderView.snp.centerY)
            make.trailing.equalTo(musicSliderView.snp.leading).offset(-8)
            make.size.equalTo(40)
        }
        
        musicPercentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(musicSliderView.snp.centerY)
            make.leading.equalTo(musicSliderView.snp.trailing).offset(8)
        }
        
        vibrationBackview.snp.makeConstraints { make in
            make.top.equalTo(musicBackview.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(72)
            make.width.equalTo(318)
        }
        
        vibrationImage.snp.makeConstraints { make in
            make.centerY.equalTo(vibrationBackview.snp.centerY).offset(-4)
            make.leading.equalTo(vibrationBackview.snp.leading).offset(20)
            make.size.equalTo(40)
        }
        
        offButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(60)
            make.centerY.equalTo(vibrationImage.snp.centerY)
            make.trailing.equalTo(vibrationBackview.snp.trailing).offset(-20)
        }
        
        onButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(60)
            make.centerY.equalTo(vibrationImage.snp.centerY)
            make.trailing.equalTo(offButton.snp.leading).offset(-11)
        }
        
        applyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(158)
            make.height.equalTo(57)
            make.top.equalTo(vibrationBackview.snp.bottom).offset(15)
        }
        
        clearProgressButton.snp.makeConstraints { make in
            make.width.equalTo(260)
            make.height.equalTo(72)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(homeButton.snp.top).offset(-140)
        }
    }
}
