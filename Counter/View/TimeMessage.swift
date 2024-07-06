import SwiftUI

struct TimeMessage: View {
    @ObservedObject var cigarettesCount: Cigarettes_Count

    var formattedTime: String {
        let hours = cigarettesCount.hours
        let minutes = cigarettesCount.minutes
        let seconds = cigarettesCount.seconds
        
        var timeComponents = [String]()
        
        if hours > 0 {
            timeComponents.append("\(hours) hour\(hours > 1 ? "s" : "")")
        }
        
        if minutes > 0 || hours > 0 {
            timeComponents.append("\(minutes) minute\(minutes != 1 ? "s" : "")")
        }
        
        timeComponents.append("\(seconds) second\(seconds != 1 ? "s" : "")")
        
        return timeComponents.joined(separator: " ") + " since last cigarette."
    }

    var body: some View {
        Group {
            if cigarettesCount.countedCigarettes == 0 {
                Text("To start the counter press the 'Add' button.")
            } else {
                Text(formattedTime)
                    .onAppear(perform: startTimer)
            }
        }
    }

    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            cigarettesCount.objectWillChange.send()
        }
    }
}

struct TimeMessage_Previews: PreviewProvider {
    static var previews: some View {
        TimeMessage(cigarettesCount: Cigarettes_Count())
            .preferredColorScheme(.dark)
    }
}
