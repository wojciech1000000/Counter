import SwiftUI

struct UpdateSheetView: View {
    @Binding var showUpdateSheet: Bool
    @Binding var newCount: String
    @Binding var newTarget: String
    @ObservedObject var cigarettesCount: Cigarettes_Count
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Theme")) {
                    Picker("Theme", selection: $themeManager.selectedTheme) {
                        ForEach(Theme.allCases) { theme in
                            Text(theme.rawValue.capitalized).tag(theme)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Toggle(isOn: $themeManager.isDarkMode) {
                        Text("Enable Dark Mode")
                    }
                }
                
                Section(header: Text("Time")) {
                    Toggle(isOn: .constant(true)) {
                        Text("Show Time")
                    }
                }
                
                Section(header: Text("Target")) {
                    Toggle(isOn: .constant(true)) {
                        Text("Show Target")
                    }
                    
                    HStack {
                        Text("Set Target")
                        Spacer()
                        TextField("Target count", text: $newTarget)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                }
                
                Section(header: Text("Statistics")) {
                    HStack {
                        Text("Statistics")
                        Spacer()
                        Text("Detail")
                            .foregroundColor(.gray)
                    }
                }
                
                Section(header: Text("Update Count")) {
                    TextField("New count", text: $newCount)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Update", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Back") {
                    showUpdateSheet = false
                },
                trailing: Button("Done") {
                    if let newCountInt = Int(newCount) {
                        cigarettesCount.countedCigarettes = newCountInt
                    }
                    if let newTargetInt = Int(newTarget) {
                        cigarettesCount.targetCigarettes = newTargetInt
                    }
                    showUpdateSheet = false
                }
            )
        }
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
    }
}

struct UpdateSheetView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateSheetView(showUpdateSheet: .constant(false), newCount: .constant(""), newTarget: .constant("10"), cigarettesCount: Cigarettes_Count())
            .environmentObject(ThemeManager())
    }
}
