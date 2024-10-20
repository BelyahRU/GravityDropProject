import Foundation
import AVFoundation

class AudioManager {
    static let shared = AudioManager()

    private var backgroundMusicPlayer: AVAudioPlayer?
    private var effectPlayers: [String: AVAudioPlayer] = [:]
    private let overallVolumeKey = "overallVolume" // Общая громкость звуковых эффектов
    private let backgroundMusicVolumeKey = "backgroundMusicVolume" // Громкость фоновой музыки

    private(set) var overallVolume: Float = 0.5 {
        didSet {
            UserDefaults.standard.set(overallVolume, forKey: overallVolumeKey)
            updateAllVolumes()
        }
    }

    private(set) var backgroundMusicVolume: Float = 0.5 {
        didSet {
            UserDefaults.standard.set(backgroundMusicVolume, forKey: backgroundMusicVolumeKey)
            updateBackgroundMusicVolume()
        }
    }

    private init() {
        if let savedOverallVolume = UserDefaults.standard.value(forKey: overallVolumeKey) as? Float {
            overallVolume = savedOverallVolume
        }
        if let savedBackgroundMusicVolume = UserDefaults.standard.value(forKey: backgroundMusicVolumeKey) as? Float {
            backgroundMusicVolume = savedBackgroundMusicVolume
        }
    }

    // MARK: - Background Music
    private func playBackgroundMusic(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
            print("Could not find file: \(filename)")
            return
        }

        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1 // Зацикливание
            
            backgroundMusicPlayer?.volume = UserDefaults.standard.value(forKey: backgroundMusicVolumeKey) as? Float ?? 0.5
        // Применение громкости фоновой музыки
            backgroundMusicPlayer?.prepareToPlay()
            backgroundMusicPlayer?.play()
        } catch let error {
            print("Could not create audio player: \(error)")
        }
    }

    func startBackgroundMusic() {
        playBackgroundMusic(filename: "fon.mp3")
        updateBackgroundMusicVolume() // Обновление громкости фоновой музыки при запуске
        updateAllVolumes() // Применение сохранённой громкости для звуковых эффектов сразу после запуска
    }

    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }

    // Метод для изменения громкости фоновой музыки
    func setBackgroundMusicVolume(_ volume: Float) {
        backgroundMusicVolume = volume // Обновляет значение и сохраняет в UserDefaults
    }

    // MARK: - Sound Effects
    private func playEffect(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else { return }

        do {
            let effectPlayer = try AVAudioPlayer(contentsOf: url)
            effectPlayer.volume = overallVolume
            effectPlayers[filename] = effectPlayer
            effectPlayer.prepareToPlay()
            effectPlayer.play()
        } catch {
            print("Audio player error: \(error)")
        }
    }

    func setOverallVolume(_ volume: Float) {
        overallVolume = volume // Обновляет значение и сохраняет в UserDefaults
    }

    // Update volumes for all sounds
    private func updateAllVolumes() {
        effectPlayers.values.forEach { $0.volume = overallVolume } // Применяем общую громкость для звуковых эффектов
    }

    // Обновление громкости фоновой музыки
    private func updateBackgroundMusicVolume() {
        backgroundMusicPlayer?.volume = backgroundMusicVolume
    }

    // Звуковые эффекты
    func buttonClickEffect() {
        playEffect(filename: "buttonPress.mp3")
    }
    
    func ballMissedEffect() {
        playEffect(filename: "fon.mp3")
    }
    
    func ballBasketEffect() {
        playEffect(filename: "win.mp3")
    }
    
    func gameOverEffect() {
        playEffect(filename: "endGame.wav")
    }
}
