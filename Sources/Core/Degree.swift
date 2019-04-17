//
//  Degree.swift
//  ColoredShapeClassifier
//
//  Created by Leonardo Oliveira on 16/04/19.
//  Copyright © 2019 Leonardo Oliveira. All rights reserved.
//

import Foundation

class Degree: ActivationFunctionProvider {
    
    func performActivation(in number: Double) -> Double {
        return number > 0 ? 1 : 0
    }
    
}
