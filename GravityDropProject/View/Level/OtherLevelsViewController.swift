
import Foundation
import UIKit

class OtherLevelsViewController: UIViewController {
    
    private let backView: UIImageView = {
       let im = UIImageView()
        return im
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        label.text = ""
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
    
    var currentBiome = ""
    
    let defaultBiomes:[String: [LevelModel]]  =
    
        ["Mountain": [
            LevelModel(num: 7, isOpened: false, countStars: 0, countStarsNeedToOpen: 20),
            LevelModel(num: 8, isOpened: false, countStars: 0, countStarsNeedToOpen: 25),
            LevelModel(num: 9, isOpened: false, countStars: 0, countStarsNeedToOpen: 30),
            LevelModel(num: 10, isOpened: false, countStars: 0, countStarsNeedToOpen: 35),
            LevelModel(num: 11, isOpened: false, countStars: 0, countStarsNeedToOpen: 40),
            LevelModel(num: 12, isOpened: false, countStars: 0, countStarsNeedToOpen: 45)
        ],
        "Ocean": [
            LevelModel(num: 13, isOpened: false, countStars: 0, countStarsNeedToOpen: 50),
            LevelModel(num: 14, isOpened: false, countStars: 0, countStarsNeedToOpen: 55),
            LevelModel(num: 15, isOpened: false, countStars: 0, countStarsNeedToOpen: 60),
            LevelModel(num: 16, isOpened: false, countStars: 0, countStarsNeedToOpen: 65),
            LevelModel(num: 17, isOpened: false, countStars: 0, countStarsNeedToOpen: 70),
            LevelModel(num: 18, isOpened: false, countStars: 0, countStarsNeedToOpen: 75)
        ],
        "Island": [
            LevelModel(num: 19, isOpened: false, countStars: 0, countStarsNeedToOpen: 80),
            LevelModel(num: 20, isOpened: false, countStars: 0, countStarsNeedToOpen: 85),
            LevelModel(num: 21, isOpened: false, countStars: 0, countStarsNeedToOpen: 90),
            LevelModel(num: 22, isOpened: false, countStars: 0, countStarsNeedToOpen: 95),
            LevelModel(num: 23, isOpened: false, countStars: 0, countStarsNeedToOpen: 100),
            LevelModel(num: 24, isOpened: false, countStars: 0, countStarsNeedToOpen: 105)
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        view.addSubview(backView)
        view.addSubview(nameLabel)
        view.addSubview(levelsCollectionView)
        view.addSubview(backButton)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
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
        
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }
    
    public func setupView(levelName: String, imageName: String) {
        currentBiome = levelName
        nameLabel.text = levelName
        backView.image = UIImage(named: imageName)
    }
    
    @objc
    func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}
