import SwiftUI
import Playgrounds

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var localCurrency = Locale.current.currency?.identifier ?? "USD"
    var tipSelection: Double {
        Double(tipPercentage)
    }
    var tipValue: Double {
        checkAmount / 100 * tipSelection
    }
    var totalAmount: Double {
        checkAmount + tipValue
    }
    var totalPerPerson: Double {
        // Prepare input data
        let peopleCount = Double(numberOfPeople + 2)
        
        // Mathematics
        return totalAmount / peopleCount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    /*
                     "Amount" is the placeholder text for the text field
                     $checkAmount is the two way binding to the checkAmount property
                     Then we pass the format of the text which is currency
                     .keyboardType(.decimalPad) - modifier on the keyboard to show a number pad with a decimal
                     */
                    TextField("Amount", value: $checkAmount, format: .currency(code: localCurrency))
                        .keyboardType(.decimalPad)
                        // Bind the focused state to the text field. When we tap into it, its value becomes true.
                        .focused($amountIsFocused)
                    
                    /*
                     "Number of people" - the placeholder text for the picker
                     selection - a two way binding to the numberOfPeople property
                     .pickerStyle(.navigationLink) - modifier to set the picker style to move to another screen when selected
                     */
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total amount") {
                    Text(totalAmount, format: .currency(code: localCurrency))
                        .foregroundStyle(tipPercentage == 0 ? .red : .primary)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: localCurrency))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                // Here we check the value of our focus state property wrapper
                if amountIsFocused {
                    Button("Done") {
                        // Here we set the value of our focus state property wrapper to false. But we aren't binding it to this button, just changing its value
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
