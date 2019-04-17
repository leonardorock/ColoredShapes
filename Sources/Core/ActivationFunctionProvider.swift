//
//  ActivationFunctionProvider.swift
//  ColoredShapeClassifier
//
//  Created by Leonardo Oliveira on 16/04/19.
//  Copyright © 2019 Leonardo Oliveira. All rights reserved.
//

protocol ActivationFunctionProvider {
    
    func performActivation(in number: Double) -> Double
    
}
