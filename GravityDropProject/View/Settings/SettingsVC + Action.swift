
import Foundation
import UIKit

extension SettingsViewController {
    
    func setupAction() {
        settingsView.soundSliderView.addTarget(self, action: #selector(soundSliderValueChanged(_:)), for: .valueChanged)
        settingsView.musicSliderView.addTarget(self, action: #selector(musicSliderValueChanged(_:)), for: .valueChanged)
        
        settingsView.homeButton.addTarget(self, action: #selector(homePressed), for: .touchUpInside)
        
        settingsView.onButton.addTarget(self, action: #selector(vibrationOnPressed), for: .touchUpInside)
        settingsView.offButton.addTarget(self, action: #selector(vibrationOffPressed), for: .touchUpInside)
        settingsView.clearProgressButton.addTarget(self, action: #selector(clearProgressPressed), for: .touchUpInside)
        
        clearProgressView.cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        clearProgressView.noButton.addTarget(self, action: #selector(noPressed), for: .touchUpInside)
        clearProgressView.yesButton.addTarget(self, action: #selector(yesPressed), for: .touchUpInside)
    }
    
    @objc
    func cancelPressed() {
        UIView.animate(withDuration: 0.5) {
            self.clearProgressTopConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
            self.settingsView.alpha = 1
            self.settingsView.isUserInteractionEnabled = true
        }
    }
    
    @objc
    func noPressed() {
        UIView.animate(withDuration: 0.5) {
            self.clearProgressTopConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
            self.settingsView.alpha = 1
            self.settingsView.isUserInteractionEnabled = true
        }
        
        //ADD: no action
    }
    
    @objc
    func yesPressed() {
        UIView.animate(withDuration: 0.5) {
            self.clearProgressTopConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
            self.settingsView.alpha = 1
            self.settingsView.isUserInteractionEnabled = true
        }
        
        //ADD: yes action
    }
    
    @objc
    func soundSliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        settingsView.soundPercentLabel.text = "\(value)%"
        //ADD: sound change
    }
    
    @objc
    func musicSliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        settingsView.musicPercentLabel.text = "\(value)%"
        
        //ADD: music change
    }
    
    @objc
    func homePressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func vibrationOffPressed() {
        settingsView.offButton.setTitleColor(.white, for: .normal)
        settingsView.onButton.setTitleColor(.white.withAlphaComponent(0.52), for: .normal)
        
        //ADD: vibration on
    }
    
    @objc
    func vibrationOnPressed() {
        settingsView.onButton.setTitleColor(.white, for: .normal)
        settingsView.offButton.setTitleColor(.white.withAlphaComponent(0.52), for: .normal)
        
        //ADD: vibration off
    }
    
    @objc
   func clearProgressPressed() {
       UIView.animate(withDuration: 0.5) {
           self.clearProgressTopConstraint?.update(offset: -550)
           self.view.layoutIfNeeded()
           self.settingsView.alpha = 0.52
           self.settingsView.isUserInteractionEnabled = false
       }
   }
}
