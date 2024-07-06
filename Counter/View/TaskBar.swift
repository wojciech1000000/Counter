import SwiftUI

struct TaskBar: View {
    @ObservedObject var cigarettesCount: Cigarettes_Count
    @Binding var showAlert: Bool
    @Binding var newCount: String
    @Binding var showUpdateSheet: Bool
    @Binding var newTarget: String
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        HStack {
            GeometryReader { geometry in
                VStack {
                    Button(action: {
                        cigarettesCount.decrementCigarettesCount()
                    }) {
                        VStack(alignment: .center, spacing: 4) {
                            Image(systemName: "arrow.left.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                        .frame(width: geometry.size.width)
                    }
                    .disabled(cigarettesCount.countedCigarettes == 0)
                    .foregroundColor(cigarettesCount.countedCigarettes == 0 ? .gray : themeManager.selectedTheme.color)
                }
            }

            GeometryReader { geometry in
                Button(action: {
                    self.showUpdateSheet.toggle()
                }) {
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "arrow.up.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: geometry.size.width)
                }
                .foregroundColor(themeManager.selectedTheme.color)
            }

            GeometryReader { geometry in
                Button(action: {
                    cigarettesCount.resetCigarettesCount()
                }) {
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "arrow.counterclockwise.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: geometry.size.width)
                }
                .foregroundColor(themeManager.selectedTheme.color)
            }
        }
        .padding(.top, 20)
        .sheet(isPresented: $showUpdateSheet) {
            UpdateSheetView(showUpdateSheet: $showUpdateSheet, newCount: $newCount, newTarget: $newTarget, cigarettesCount: cigarettesCount)
                .environmentObject(themeManager)
        }
    }
}

struct TaskBar_Previews: PreviewProvider {
    static var previews: some View {
        TaskBar(cigarettesCount: Cigarettes_Count(), showAlert: .constant(false), newCount: .constant(""), showUpdateSheet: .constant(false), newTarget: .constant("10"))
            .environmentObject(ThemeManager())
    }
}
