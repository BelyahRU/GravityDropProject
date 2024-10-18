
import Foundation
import UIKit

class LevelsSelectionCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "LevelsSelectionCollectionViewCell"
    
    private let backview: UIImageView = {
        let im = UIImageView()
         im.image = UIImage(named: "cellBackview")
         return im
     }()
    
    private let desertImage: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: "desertLogo")
        return im
    }()
    
    private let desertLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 20)
        label.text = "Desert"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let scores: UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Orbitron-ExtraBold", size: 20)
        label.text = "\(ScoresManager.shared.getCurrentUserScores())/18"
         label.backgroundColor = .clear
         label.textAlignment = .center
         label.textColor = .white
         return label
     }()
    
    private let starImage: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.starImage)
        return im
    }()
    
    private let otherImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDesert() {
        addSubview(backview)
        addSubview(desertImage)
        addSubview(desertLabel)
        addSubview(scores)
        addSubview(starImage)
        
        backview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        desertImage.snp.makeConstraints { make in
            make.size.equalTo(64)
            make.centerY.equalToSuperview().offset(-4)
            make.leading.equalToSuperview().offset(20)
        }
        
        desertLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-4)
            make.leading.equalTo(desertImage.snp.trailing).offset(16)
        }
        
        starImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-4)
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(28)
        }
        
        scores.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-4)
            make.trailing.equalTo(starImage.snp.leading).offset(-4)
        }
    }
    
    func setupAnother(with id: Int) {
        switch id {
        case 1:
            otherImageView.image = UIImage(named: "level2")
        case 2:
            otherImageView.image = UIImage(named: "level3")
        default:
            otherImageView.image = UIImage(named: "level4")
        }
        self.addSubview(otherImageView)
        otherImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
