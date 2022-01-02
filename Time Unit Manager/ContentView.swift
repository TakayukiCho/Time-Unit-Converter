//
//  ContentView.swift
//  Time Unit Manager
//
//  Created by TC on 1/2/22.
//

import SwiftUI

struct ContentView: View {
    
    enum TimeUnit: String, CaseIterable {
        case hour = "hour"
        case minute = "minute"
        case second = "second"
        
        var multiplerToSecond: Int {
            switch self {
            case .second: return 1
            case .minute: return 60
            case .hour: return 3600
            }
        }
    }
    
    @State private var durationInput: Int = 0
    @State private var numberOfPeople: Int = 2
    
    @State private var fromUnit: TimeUnit = .hour
    @State private var toUnit: TimeUnit = .minute
    
    @FocusState private var durationIsFocused: Bool
    
    var result: Int {
        return durationInput * fromUnit.multiplerToSecond / toUnit.multiplerToSecond
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("amount", value: $durationInput, format: .number)
                        .keyboardType(.numberPad)
                        .focused($durationIsFocused)
                } header : {
                    Text("Input")
                }
                Section {
                    Picker("from", selection: $fromUnit) {
                        ForEach(TimeUnit.allCases, id: \.rawValue) {
                            Text("\($0.rawValue)").tag($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("from")
                }

                Section {
                    Picker("to", selection: $toUnit) {
                        ForEach(TimeUnit.allCases, id: \.rawValue) {
                            Text("\($0.rawValue)").tag($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("to")
                }
                
                
                Section {
                    Text("\(result)")
                }
            }.navigationTitle("Time Unit Manager")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Done") {
                            durationIsFocused = false
                        }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
