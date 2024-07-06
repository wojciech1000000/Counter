import Foundation
import Combine

class CigaretteCounterViewModel: ObservableObject {
    @Published var count: Int = 0
    private var counter = CigaretteCounter()
    
    init() {
        self.count = counter.count
    }
    
    func addCigarette() {
        counter.addCigarette()
        self.count = counter.count
    }
    
    func subtractCigarette() {
        counter.subtractCigarette()
        self.count = counter.count
    }
    
    func resetCount() {
        counter.resetCount()
        self.count = counter.count
    }
    
    func updateCount(to newCount: Int) {
        counter.updateCount(to: newCount)
        self.count = counter.count
    }
}
