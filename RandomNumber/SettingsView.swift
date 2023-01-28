//
//  SettingsView.swift
//  RandomNumber
//
//  Created by Nick Pavlov on 1/26/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsData: NumberModel
    @Binding var fromNumber: Int
    @Binding var toNumber: Int
    @State var showAlert = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
    
        VStack {
            Image("logoOne")
                .resizable()
                .cornerRadius(10)

                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: 100)
                .padding()
                .cornerRadius(100)
            
            NavigationStack {
                List {
                    Section("Enter Number FROM:") {
                        HStack {
                            Spacer()
                            TextField("", value: $fromNumber, formatter: NumberFormatter())
                                .frame(maxWidth: .infinity)
                                .bold()
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }
                    
                    Section("Enter Number TO:") {
                        HStack {
                            Spacer()
                            TextField("", value: $toNumber, formatter: NumberFormatter())
                                .frame(maxWidth: .infinity)
                                .bold()
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }
                    .navigationTitle("Settings")
                    
                    Section {
                        HStack {
                            Spacer()
                            Button(action: {
                                if toNumber > fromNumber {
                                    dismiss()
                                } else {
                                    self.showAlert = true
                                }
                            }, label: {
                                Text("Accept")
                                    .foregroundColor(.red)
                            })
                            .alert("First number must be lower than second!", isPresented: $showAlert) {
                                Button("OK", role: .cancel) {}
                            }
                            Spacer()
                        }
                    }
                }
                .cornerRadius(10)
            }
        }
    }
}
