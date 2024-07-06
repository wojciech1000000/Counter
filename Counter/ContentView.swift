import SwiftUI

struct ContentView: View {
    @StateObject private var cigarettesCount = Cigarettes_Count()
    @StateObject private var themeManager = ThemeManager()
    @State private var showAlert = false
    @State private var newCount = ""
    @State private var newTarget = "10"
    @State private var showUpdateSheet = false
    @State private var timer: Timer?

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 130) {
                        TargetView(cigarettesCount: cigarettesCount, themeColor: themeManager.selectedTheme.color)
                            .frame(width: geometry.size.width * 0.95)
                            .padding(.top, geometry.safeAreaInsets.top)
                        
                        CounterTile(cigarettesCount: cigarettesCount, themeColor: themeManager.selectedTheme.color)
                            .frame(height: geometry.size.height * 0.58)
                    }.padding(.top)
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.85)

                VStack {
                    TimeMessage(cigarettesCount: cigarettesCount)
                        .padding(.bottom, 10)
                        .padding(.top, 10)

                    Button(action: {
                        cigarettesCount.incrementCigarettesCount()
                    }) {
                        Text("Add")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(themeManager.selectedTheme.color)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)

                    TaskBar(cigarettesCount: cigarettesCount, showAlert: $showAlert, newCount: $newCount, showUpdateSheet: $showUpdateSheet, newTarget: $newTarget)
                        .frame(height: geometry.size.height * 0.07)
                        .padding(.bottom, geometry.safeAreaInsets.bottom) // Uwzględnia bezpieczne obszary
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                startTimer()
            }
            .onChange(of: cigarettesCount.countedCigarettes) { _ in
                cigarettesCount.objectWillChange.send()
            }
            .onChange(of: cigarettesCount.lastCigaretteTime) { _ in
                cigarettesCount.objectWillChange.send()
            }
            .onChange(of: cigarettesCount.targetCigarettes) { _ in
                cigarettesCount.objectWillChange.send()
            }
            .environmentObject(themeManager)
            .sheet(isPresented: $showUpdateSheet) {
                UpdateSheetView(showUpdateSheet: $showUpdateSheet, newCount: $newCount, newTarget: $newTarget, cigarettesCount: cigarettesCount)
                    .environmentObject(themeManager)
            }
            .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        }
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            cigarettesCount.objectWillChange.send()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ThemeManager())
    }
}
