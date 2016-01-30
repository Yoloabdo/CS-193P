//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by abdelrahman mohamed on 1/18/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import Foundation


/// #### Calcaulator class
/// - simply doing all the work
/// - class uses recursive method to get operands from a stack
class CalculatorBrain {
    
    /// custom type of enum to save the operation.
    /// this type is decribable.
    private enum Op: CustomStringConvertible{
        case operand(Double)
        case variable(String)
        case constantValue(String, Double)
        case unaryOperation(String, (Double) ->Double)
        case binaryOperation(String, (Double, Double) ->Double)
        
        var description: String {
            get{
                switch self {
                case .operand(let operand):
                    return "\(operand)"
                case .variable(let symbol):
                    return "\(symbol)"
                case .constantValue(let symbol, _):
                    return "\(symbol)"
                case .unaryOperation(let symbol, _):
                    return "\(symbol)"
                case .binaryOperation(let symbol, _):
                    return "\(symbol)"
                
                }
            }
        }
    }
    
    // contains all the operation entered through the user to calcluator.
    private var opStack = [Op]()
    
    // knownOps contains all known operations to the calculator.
    private var knownOps = Dictionary<String, Op>()
    
    // saving variables into the stack
    var variableValues = [String: Double]()
    
    /// A properity gets the program to public.
    /// caller won't have any idea what's it.
    /// this's good if we want to save the information as cookie or something alike.
    /// it's a ProperityList.
    var program: AnyObject {
        set{
            if let opSymbols = newValue as? Array<String> {
                var newOpStack = [Op]()
                for opSymbol in opSymbols {
                    if let op = knownOps[opSymbol]{
                        newOpStack.append(op)
                    }else if let operand = Double(opSymbol){
                        newOpStack.append(.operand(operand))
                    }
                }
                opStack = newOpStack

            }
            
        }
        get{
            return opStack.map { $0.description }
        }
    }
    
    init(){
        /// this function is just there to not type the string of the function twice.
        /// - Parameter op: takes the operation type declarition in order to iniate the ops Stack.
        func learnOps(op: Op){
            knownOps[op.description] = op
        }
        
        learnOps(Op.constantValue("π", M_1_PI))
        learnOps(Op.binaryOperation("+", +))
        learnOps(Op.binaryOperation("−") { $1 - $0})
        learnOps(Op.binaryOperation("×", *))
        learnOps(Op.binaryOperation("%") { $1 % $0})
        learnOps(Op.binaryOperation("÷") { $1 / $0})
        learnOps(Op.unaryOperation("√", sqrt))
        learnOps(Op.unaryOperation("sin", sin))
        learnOps(Op.unaryOperation("cos", cos))
        learnOps(Op.unaryOperation("tan", tan))
        learnOps(Op.unaryOperation("+/-") { -$0 })
        learnOps(Op.unaryOperation("x²") { $0 * $0 })
        
    }
    
    /// Evaluation function. It works recursivly through the array.
    /// - Parameter ops: Array of Op enum special type defined earlier.
    /// - Returns: a list contains result and the rest of the input array.
    ///
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]){

        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case .operand(let operand):
                return (operand, remainingOps)
            case .variable(let symbol):
                if let value = variableValues[symbol]{
                    return (value, remainingOps)
                }
            case .constantValue(_, let operand):
                return (operand, remainingOps)
            case .unaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .binaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        
        return (nil, ops)
        
    }
    /// Evalute second function, calls insider function with same name in order to get the results.
    /// - Returns: nil or Double, depends if there's error in calculating what's inside the Op stack.
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        print("\(opStack)  = \(result) with \(remainder) leftover")
        
        return result
    }
    
    
    /// Pushing operand inside the OpStack and then calls evaluate function.
    /// - Parameter operand: takes an operand into the stack.
    /// - Returns: The result from the evaluation.
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.operand(operand))
        return evaluate()
    }
    
    /// Pushing operation into the OpStack
    /// - Parameter symbol: takes variable such as X, Y, check if it's known to our variableValues Dic.
    /// - Returns: evaluate, as usual optional!
    func pushOperand(symbol: String) -> Double? {
        opStack.append(Op.variable(symbol))
        
        
        return evaluate()
    }
    
    /// Pushing operation into the OpStack
    /// - Parameter symbol: takes any operation that to be applied, check if it's known to our knownOps Stack.
    /// - Returns: evaluate, as usual optional!
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}