//
//  ContentView.swift
//  RandomNumber
//
//  Created by Nick Pavlov on 1/26/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var isOnSettings = false
    @ObservedObject var numberData = NumberModel()
    @State var resultValue: String = "?"
    @State var counter = 0
    @State var timer: AnyCancellable?
    @State var showAlert = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.isOnSettings.toggle()
                }, label: {
                    Text("Setings")
                        .foregroundColor(.blue)
                })
            }
            Divider()
            
            HStack {
                Text("Random Number")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            
            HStack(spacing: 30) {
                Text("from")
                    .font(.title)
                    .baselineOffset(-15)
                Text("\(numberData.numberFrom)")
                    .font(.system(size: 50))
                    .scaledToFit()
                    .minimumScaleFactor(0.01)
                Text("to")
                    .font(.title)
                    .baselineOffset(-15)
                Text("\(numberData.numberTo)")
                    .font(.system(size: 50))
                    .scaledToFit()
                    .minimumScaleFactor(0.01)
            }
            .padding(.top, 30)
            Spacer()
            
            Text("\(resultValue)")
                .font(.system(size: 130, weight: .bold))
                .scaledToFit()
                .minimumScaleFactor(0.01)
            Spacer()
            Spacer()
            
            Button(action: {
                if numberData.numberTo > numberData.numberFrom {
                    generateNumber()
                } else {
                    self.showAlert = true
                }
            }, label: {
                Text("Get Result")
            })
            .alert("First number must be lower than second!", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
            .frame(width: 250, height: 50)
            .background(Color.green)
            .foregroundColor(.white)
            .font(.largeTitle)
            .cornerRadius(10)
            .padding(.bottom)
            .sheet(isPresented: $isOnSettings, content: {
                SettingsView(fromNumber: $numberData.numberFrom, toNumber: $numberData.numberTo)
            })
        }
        .padding()
        .background(Image("imageRandom"))
        .foregroundColor(.black)
    }
    
    func generateNumber() {
        timer = Timer.publish(every: 0.07, on: .main, in: .common).autoconnect()
            .sink {_ in
                if counter == 15 {
                    self.timer?.cancel()
                    counter = 0
                } else {
                    let randomNumber = Int.random(in: numberData.numberFrom...numberData.numberTo)
                    let randomNumberString = String(randomNumber)
                    resultValue = randomNumberString
                }
                counter += 1
            }
    }
}
