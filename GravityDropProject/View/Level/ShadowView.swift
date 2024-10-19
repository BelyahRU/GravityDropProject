
import Foundation
import UIKit

class ShadowView: UIView {
    
    private let backShadow: UIImageView = UIImageView(image: UIImage(named: "shadowLevelBack"))
    
    let countStarsToNeedLabel: UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Orbitron-ExtraBold", size: 18)
         label.text = ""
         label.backgroundColor = .clear
         label.textAlignment = .center
         label.textColor = .white
         return label
    }()
    
    private let starImage: UIImageView = UIImageView(image: UIImage(named: Resources.Images.starImage))
    
    let toUnlockLabel: UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Orbitron-ExtraBold", size: 18)
         label.text = "to unlock"
         label.backgroundColor = .clear
         label.textAlignment = .center
         label.textColor = .white
         return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backShadow)
        addSubview(countStarsToNeedLabel)
        addSubview(starImage)
        addSubview(toUnlockLabel)
        
        backShadow.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        countStarsToNeedLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(39)
        }
        
        starImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(28)
        }
        
        toUnlockLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-39)
            make.centerX.equalToSuperview()
        }
    }
    
    
}
