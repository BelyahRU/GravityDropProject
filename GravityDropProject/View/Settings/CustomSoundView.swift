
import Foundation
import UIKit
import SnapKit

class CustomSoundView: UIView {
    
    // Слайдер для звука
    public let sliderView: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50 // Установим начальное значение 50%
        slider.isContinuous = true
        
        return slider
    }()
    
    // Изображение колонки (иконка)
    public let speakerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "speakerIcon") // Поменяйте на нужное изображение
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Процент звука
    public let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "50%" // Начальное значение
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(speakerImageView)
        addSubview(sliderView)
        addSubview(percentageLabel)
        
        self.bringSubviewToFront(sliderView)
        
        // Устанавливаем SnapKit-констрейнты
        
        // Колонка слева
        speakerImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(24) // Примерный размер для иконки
        }
        
        // Слайдер по центру
        sliderView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(speakerImageView.snp.trailing).offset(16)
            make.trailing.equalTo(percentageLabel.snp.leading).offset(-16)
        }
        
        // Процент звука справа
        percentageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(50) // Достаточно места для текста вроде "100%"
        }
    }
    
    private func configure() {
        sliderView.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    // Обновляем значение процента при изменении слайдера
    @objc private func sliderValueChanged() {
        let value = Int(sliderView.value)
        percentageLabel.text = "\(value)%"
    }
}

