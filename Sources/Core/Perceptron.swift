//
//  Perceptron.swift
//  ColoredShapeClassifier
//
//  Created by Leonardo Oliveira on 16/04/19.
//  Copyright © 2019 Leonardo Oliveira. All rights reserved.
//

import Foundation

class Perceptron {
    
    let input: [[Double]]
    let target: [[Double]]
    
    let learningCurve: Double
    
    let activationFunctionProvider: ActivationFunctionProvider
    
    lazy var iteration: Int = 0
    
    lazy var weights: [[Double]] = {
        guard input.count > 0 else { return [[]] }
        return [[Double]](repeating: [Double](repeating: 0.0, count: input[0].count), count: input.count)
    }()
    
    init(input: [[Double]], target: [[Double]], learningCurve: Double = 0.5, activationFunctionProvider: ActivationFunctionProvider) {
        self.input = input
        self.target = target
        self.learningCurve = learningCurve
        self.activationFunctionProvider = activationFunctionProvider
    }
    
    func train() {
        var error = false
        repeat {
            iteration += 1
            for i in 0..<target.count {
                for j in 0..<target[i].count {
                    let w = weights[i]
                    let inp = input[j]
                    let sum = activationFunctionProvider.performActivation(in: zip(w, inp).map { $0 * $1 }.reduce(0.0, { $0 + $1 }))
                    error = sum != target[i][j]
                    if error {
                        for wi in 0..<w.count {
                            weights[i][wi] = w[wi] + learningCurve * (target[i][j] - sum) * inp[wi]
                        }
                    }
                }
            }
        } while error
    }
    
    func testAgainst(testCase: [[Double]]) -> (result: [[Double]], accuracy: Double) {
        let totalItems = testCase[0].count * testCase.count
        var errorsCount = totalItems
        var result = testCase
        for i in 0..<testCase.count {
            for j in 0..<testCase[i].count {
                let w = weights[i]
                let inp = input[j]
                let sum = activationFunctionProvider.performActivation(in: zip(w, inp).map { $0 * $1 }.reduce(0.0, { $0 + $1 }))
                result[i][j] = sum
                errorsCount -= sum == testCase[i][j] ? 0 : 1
            }
        }
        let accuracy = Double(errorsCount) / Double(totalItems)
        return (result, accuracy)
    }
    
}
