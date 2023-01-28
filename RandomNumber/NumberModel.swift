//
//  NumberModel.swift
//  RandomNumber
//
//  Created by Nick Pavlov on 1/26/23.
//

import Foundation

class NumberModel: ObservableObject {
    @Published var numberFrom: Int = 0
    @Published var numberTo: Int = 100
}
