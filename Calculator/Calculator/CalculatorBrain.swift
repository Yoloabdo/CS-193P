//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by abdelrahman mohamed on 1/18/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import Foundation


class CalculatorBrain {
    
    private enum Op: CustomStringConvertible{
        case operand(Double)
        case constantValue(String, Double)
        case unaryOperation(String, (Double) ->Double)
        case binaryOperation(String, (Double, Double) ->Double)
        
        var description: String {
            get{
                switch self {
                case .operand(let operand):
                    return "\(operand)"
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
    
    private var opStack = [Op]()
    
    private var knownOps = Dictionary<String, Op>()
    
    var properities: AnyObject {
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
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]){

        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case .operand(let operand):
                return (operand, remainingOps)
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
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        print("\(opStack)  = \(result) with \(remainder) leftover")
        
        return result
    }

    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}