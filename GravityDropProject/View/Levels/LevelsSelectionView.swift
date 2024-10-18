
import Foundation
import UIKit

class LevelsSelectionView: UIView {
    
    private let backview: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.mainBackgound)
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    private let levelsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        label.text = "Levels"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public let userScoresView = UserScoresView()
    
    public let homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.Buttons.homeButton), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let levelsCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 318, height: 92)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
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
        addSubview(levelsLabel)
        addSubview(userScoresView)
        addSubview(levelsCollectionView)
        addSubview(homeButton)
    }
    
    private func setupConstraints() {
        backview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
        levelsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        userScoresView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(64)
            make.top.equalTo(levelsLabel.snp.bottom).offset(24)
        }
        
        homeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(72)
            make.width.equalTo(260)
            make.bottom.equalToSuperview().offset(-24)
        }
        
        levelsCollectionView.snp.makeConstraints { make in
            make.width.equalTo(318)
            make.height.equalTo(420)
            make.centerX.equalToSuperview()
            make.top.equalTo(userScoresView.snp.bottom).offset(40)
        }
    }
}
