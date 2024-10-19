
import Foundation
import UIKit

class LevelCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "LevelCollectionViewCell"
    
    private let backView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: "levelback")
        return im
    }()
    
    public let levelLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        label.text = "Level"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public let countStarsView: UIImageView = {
       let im = UIImageView()
        
        return im
    }()
    
    let shadow = ShadowView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backView)
        addSubview(levelLabel)
        addSubview(countStarsView)
        addSubview(shadow)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        levelLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        countStarsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(levelLabel.snp.bottom).offset(38)
            make.height.equalTo(52)
            make.width.equalTo(124)
        }
        
        shadow.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        shadow.isHidden = true
    }
    
    public func setupCell(levelModel: LevelModel) {
        levelLabel.text = "Level \(levelModel.num)"
        if !levelModel.isOpened {
            countStarsView.image = UIImage(named: "stars0")
            
            shadow.countStarsToNeedLabel.text = "\(levelModel.countStarsNeedToOpen)"
            shadow.isHidden = false
            
        } else {
            shadow.isHidden = true
            switch levelModel.countStars {
            case 0:
                countStarsView.image = UIImage(named: "stars0")
            case 1:
                countStarsView.image = UIImage(named: "stars1")
            case 2:
                countStarsView.image = UIImage(named: "stars2")
            default:
                countStarsView.image = UIImage(named: "stars3")
            }
        }
    }
}
