import Foundation

struct GenericError: LocalizedError {
    
    var errorDescription: String?
    
}

public final class ColoredShapes {
    
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) { 
        self.arguments = arguments
    }
    
    public func run() throws {
        
        guard arguments.count == 3 else {
            throw GenericError(errorDescription: "Invalid number of arguments")
        }
        
        let decoder = JSONDecoder()
        let inputData = try Data(contentsOf: URL(fileURLWithPath: arguments[1]))
        let targetData = try Data(contentsOf: URL(fileURLWithPath: arguments[2]))
        
        let matrix = try decoder.decode([[Double]].self, from: inputData)
        
        let target = try decoder.decode([[Double]].self, from: targetData)
        
        let perceptron = Perceptron(input: matrix, target: target, activationFunctionProvider: Degree())
        perceptron.train()
        let tuple = perceptron.testAgainst(testCase: target)
        let accuracy = tuple.accuracy
        let testResult = tuple.result
        
        prettyPrint(matrix: perceptron.weights, with: "Weights")
        prettyPrint(matrix: testResult, with: "Test")
        prettyPrint(matrix: perceptron.target, with: "Target")
        print("Accuracy: \(accuracy)")
        print("Iteration: \(perceptron.iteration)")
        
    }
    
    func prettyPrint(matrix: [[Double]], with name: String) {
        print("---- \(name) ----")
        print(matrix.map { line in line.compactMap { number in String(format: "% 2.1lf", number) }.joined(separator: " ") }.joined(separator: "\n"))
    }

    
}
