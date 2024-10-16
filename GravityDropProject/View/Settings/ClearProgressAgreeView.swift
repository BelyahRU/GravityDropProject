
import Foundation
import UIKit

final class ClearProgressAgreeView: UIView {
    
    private let backview: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.clearProgressView)
        return im
    }()
    
    let cancelButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: Resources.Buttons.cancelButton), for: .normal)
        return button
    }()
    
    private let textTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Orbitron-ExtraBold", size: 16)
        label.text = "Do you really want to clear your progress?"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let yesButton: UIButton = {
       let button = UIButton()
        button.setTitle("YES", for: .normal)
        button.titleLabel?.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let noButton: UIButton = {
       let button = UIButton()
        button.setTitle("NO", for: .normal)
        button.titleLabel?.font = UIFont(name: "Orbitron-ExtraBold", size: 24)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
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
        addSubview(cancelButton)
        addSubview(textTitleLabel)
        addSubview(yesButton)
        addSubview(noButton)
        
        backview.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalTo(318)
            make.height.equalTo(144)
            make.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(32)
        }
        
        textTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backview.snp.top).offset(26)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        noButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(35)
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(20)
        }
        
        yesButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(35)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
