
import Foundation
import UIKit

class InDevelopmentView: UIView {
    
    private let backview: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: "inDevelopment")
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    private let inDevelopmentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 16)
        label.text = "In development"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public let okButton: UIButton = {
       let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        button.backgroundColor = .clear
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
        addSubview(backview)
        addSubview(inDevelopmentLabel)
        addSubview(okButton)
        
        backview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        inDevelopmentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(26)
        }
        
        okButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
    }
}
