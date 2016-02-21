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
        case unaryOperation(String, (Double) ->Double, (Double -> String?)?)
        case binaryOperation(String, (Double, Double) ->Double, ((Double) -> String?)?)
        
        var description: String {
            get{
                switch self {
                case .operand(let operand):
                    return "\(operand)"
                case .variable(let symbol):
                    return "\(symbol)"
                case .constantValue(let symbol, _):
                    return "\(symbol)"
                case .unaryOperation(let symbol, _, _):
                    return "\(symbol)"
                case .binaryOperation(let symbol, _, _):
                    return "\(symbol)"
                
                }
            }
        }
        
        var precedence: Int {
            get{
                switch self{
                case .binaryOperation(let symbol, _, _):
                    switch symbol{
                        case "×", "%", "÷":
                        return 2
                        case "+", "-":
                        return 1
                    default: return Int.max
                    }
                default:
                    return Int.max
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
    
    
    /// String to save error if there's one.
    private var error: String?

    
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
                    }else{
                        newOpStack.append(.variable(opSymbol))
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
        
        learnOps(Op.constantValue("π", M_PI))
        learnOps(Op.binaryOperation("+", +, nil))
        learnOps(Op.binaryOperation("−", { $1 - $0}, nil))
        learnOps(Op.binaryOperation("×", *, nil))
        learnOps(Op.binaryOperation("%", { $1 % $0},
            { $0 == 0.0 ? "Division by zero" : nil }))
        learnOps(Op.binaryOperation("÷", { $1 / $0},
            { $0 == 0.0 ? "Division by zero" : nil }))
        learnOps(Op.unaryOperation("√", sqrt, {$0 < 0 ? "square root zero": nil}))
        learnOps(Op.unaryOperation("sin", sin, nil))
        learnOps(Op.unaryOperation("cos", cos, nil))
        learnOps(Op.unaryOperation("tan", tan, nil))
        learnOps(Op.unaryOperation("+/-", { -$0 }, nil))
        learnOps(Op.unaryOperation("x²", { $0 * $0 }, nil))
        learnOps(Op.variable("M"))
        
    }
    
    /// Evaluation function. It works recursivly through the array.
    /// - Parameter ops: Array of Op enum special type defined earlier.
    /// - Returns: a list contains result and the rest of the input array.
    /// Error test handling has been added to the function as a closure.
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
                error = "Variable Not Set"
                return (nil, remainingOps)
                
            case .constantValue(_, let operand):
                return (operand, remainingOps)
                
            case .unaryOperation(_, let operation, let errorTest):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    // checking error test closure
                    if let errorMessage = errorTest?(operand) {
                        error = errorMessage
                        return (nil, operandEvaluation.remainingOps)
                    }
                    return (operation(operand), operandEvaluation.remainingOps)
                }
                
            case .binaryOperation(_, let operation, let errorTest):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    // checking error test closure
                    if let errorMessage = errorTest?(operand1) {
                        error = errorMessage
                        return (nil, op1Evaluation.remainingOps)
                    }
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
            if error == nil {
                error = "Not Enough Operands"
            }
        }
        
        return (nil, ops)
        
    }
    /// Evalute second function, calls insider function with same name in order to get the results.
    /// - Returns: nil or Double, depends if there's error in calculating what's inside the Op stack.
    func evaluate() -> Double? {
        error = nil
        let (result, _) = evaluate(opStack)
//        print("\(opStack)  = \(result) with \(remainder) leftover")
        
        return result
    }
    
    
    // evaluateAndReportErrors()
    func evaluateAndReportErrors() -> AnyObject? {
        let (result, _) = evaluate(opStack)
        return result != nil ? result : error
    }
    

    
    /// description of what's inside the stack without evaluation, works recursively as evaluate function.
    /// - Parameter ops : operation stack
    /// - returns: results as a string, plus remaining operations and presedence of the rest.
    private func description (ops: [Op]) -> (result: String?, remainingOps: [Op], precedence: Int?){
    
        if !ops.isEmpty{
            
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case.operand(let operand):
                return (String(format: "%g", operand), remainingOps, op.precedence)
            case .variable(let symbol):
                return ("\(symbol)", remainingOps, op.precedence)
            case .constantValue(let symbol, _):
                return ("\(symbol)", remainingOps, op.precedence)
            case .unaryOperation(let symbol, _, _):
                let operandEvaluation = description(remainingOps)
                if var operand = operandEvaluation.result {
                    if op.precedence > operandEvaluation.precedence {
                        operand = "(\(operand))"
                    }
                    return ("\(symbol)\(operand)", operandEvaluation.remainingOps, op.precedence)
                }
            case .binaryOperation(let symbol, _, _):
                let op1Evaluation = description(remainingOps)
                if var operand1 = op1Evaluation.result {
                    if op.precedence > op1Evaluation.precedence {
                        operand1 = "(\(operand1))"
                    }
                    let op2Evaluation = description(op1Evaluation.remainingOps)
                    if var operand2 = op2Evaluation.result {
                        if op.precedence > op2Evaluation.precedence {
                            operand2 = "(\(operand2))"
                        }
                        return ("\(operand2) \(symbol) \(operand1)",
                            op2Evaluation.remainingOps, op.precedence)
                    }
                }
            }
        }
    
        return("?", ops, Int.max)
    }
    
    /// calling description function through this var.
    var discription: String {
        get{
            var (result, ops) = ("", opStack)
            repeat {
                var current: String?
                (current, ops, _) = description(ops)
                // result adds up if no operations added to the stack and sepreated by comma ,.
                result = result == "" ? current! : "\(current!), \(result)"
            } while ops.count > 0
            
            return result
        
        }
    }
    
    /// private method to get the last operand in the stack into vars dic
    /// i guess there's simple ways, but this one looks appealing now
    private func addVarValue(ops: [Op]){
        if !ops.isEmpty{
            
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case.operand(let operand):
                variableValues["M"] = operand
            default:
                break
            }
        }
    }
    
    /// public version of previous func.
    func addOperandValueM() -> Bool{
        addVarValue(opStack)
        return popOperand()
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
    
    func popOperand() -> Bool{
        if !opStack.isEmpty{
            opStack.popLast()
            return true
        }
        return false
    }
}