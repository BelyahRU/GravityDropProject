
import Foundation
import UIKit

class LeaderCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "LeaderCollectionViewCell"
    
    private let backview: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.leaderCell)
        return im
    }()
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 16)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 16)
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
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 18)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = .white
        return label
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
        addSubview(positionLabel)
        addSubview(nameLabel)
        addSubview(starImage)
        addSubview(pointsLabel)
    }
    
    private func setupConstraints() {
        backview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        positionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview().offset(-3)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-3)
            make.leading.equalTo(positionLabel.snp.trailing).offset(4)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview().offset(-3)
        }
        
        starImage.snp.makeConstraints { make in
            make.trailing.equalTo(pointsLabel.snp.leading).offset(-4)
            make.centerY.equalToSuperview().offset(-3)
        }
    }
    
    public func setupCell(id: Int, name: String, points: Int) {
        positionLabel.text = "#\(id)"
        nameLabel.text = name
        pointsLabel.text = "\(points)"
    }
}
