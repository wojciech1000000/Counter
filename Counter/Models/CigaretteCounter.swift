import Foundation

class CigaretteCounter {
    private let userDefaultsKey = "cigaretteCount"
    
    var count: Int {
        get {
            return UserDefaults.standard.integer(forKey: userDefaultsKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
        }
    }
    
    func addCigarette() {
        count += 1
    }
    
    func subtractCigarette() {
        if count > 0 {
            count -= 1
        }
    }
    
    func resetCount() {
        count = 0
    }
    
    func updateCount(to newCount: Int) {
        count = newCount
    }
}
