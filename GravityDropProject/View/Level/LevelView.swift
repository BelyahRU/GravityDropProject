
import Foundation
import UIKit

class LevelView: UIView {
    
    private let backView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.desertGameBackground)
        return im
    }()
    
    private let desertLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        label.text = "Desert"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let levelsCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 160)
        layout.minimumLineSpacing = 18
        layout.minimumInteritemSpacing = 18
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    public let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
         return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backView)
        addSubview(desertLabel)
        addSubview(levelsCollectionView)
        addSubview(backButton)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        desertLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        levelsCollectionView.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(520)
            make.center.equalToSuperview()
        }
        
        
        backButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(72)
            make.width.equalTo(260)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
}

