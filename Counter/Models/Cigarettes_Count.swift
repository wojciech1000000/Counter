import SwiftUI
import Combine

class Cigarettes_Count: ObservableObject {
    @Published var countedCigarettes: Int {
        didSet {
            UserDefaults.standard.set(countedCigarettes, forKey: "countedCigarettes")
        }
    }

    @Published var lastCigaretteTime: Date? {
        didSet {
            UserDefaults.standard.set(lastCigaretteTime, forKey: "lastCigaretteTime")
        }
    }
    @Published var targetCigarettes: Int {
        didSet {
            UserDefaults.standard.set(targetCigarettes, forKey: "targetCigarettes")
        }
    }

    init(countedCigarettes: Int = 0, lastCigaretteTime: Date? = nil, targetCigarettes: Int = 10) {
        self.countedCigarettes = UserDefaults.standard.integer(forKey: "countedCigarettes")
        self.lastCigaretteTime = UserDefaults.standard.object(forKey: "lastCigaretteTime") as? Date ?? lastCigaretteTime
        self.targetCigarettes = UserDefaults.standard.integer(forKey: "targetCigarettes")
    }

    var timeInterval: TimeInterval {
        guard let lastTime = lastCigaretteTime else { return 0 }
        return Date().timeIntervalSince(lastTime)
    }
    
    var hours: Int {
        return Int(timeInterval) / 3600
    }
    
    var minutes: Int {
        return (Int(timeInterval) % 3600) / 60
    }
    
    var seconds: Int {
        return Int(timeInterval) % 60
    }

    func incrementCigarettesCount() {
        countedCigarettes += 1
        lastCigaretteTime = Date()
    }

    func decrementCigarettesCount() {
        if countedCigarettes > 0 {
            countedCigarettes -= 1
        }
        lastCigaretteTime = nil
    }

    func resetCigarettesCount() {
        countedCigarettes = 0
        lastCigaretteTime = nil
    }
}
