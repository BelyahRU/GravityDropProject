
import Foundation
import UIKit

class UserScoresView: UIView {
    
    private let backview: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.Images.starsView)
        return im
    }()
    
    public let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let starImage: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.Images.starImage)
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pointsLabel, starImage])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backview)
        addSubview(horizontalStackView)
        
        backview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(2)
            make.centerY.equalToSuperview().offset(-3)
        }
        
        starImage.snp.makeConstraints { make in
            make.width.height.equalTo(36)
        }
    }
}
