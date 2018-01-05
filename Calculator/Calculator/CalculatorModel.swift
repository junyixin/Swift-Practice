//
//  CalculatorModel.swift
//  Calculator
//
//  Created by junyixin on 04/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import Foundation

struct CalcultorModel {
    
    private var accmulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
        case clearOperation
    }
    
    private var operations: Dictionary<String, Operation> = [
        "𝛑": Operation.constant(Double.pi),
        "℮": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "±": Operation.unaryOperation({ -$0 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "-": Operation.binaryOperation({ $0 - $1 }),
        "×": Operation.binaryOperation({ $0 * $1 }),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "=": Operation.equals,
        "C": Operation.clearOperation
    ]
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perfrom(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    mutating func perfromOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accmulator = value
            case .unaryOperation(let handle):
                if accmulator != nil {
                    accmulator = handle(accmulator!)
                }
            case .binaryOperation(let function):
                if accmulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accmulator!)
                    accmulator = nil
                }
            case .equals:
                perfromPendingBinaryOperation()
            case .clearOperation:
                accmulator = 0
            }
        }
    }
    
    private mutating func perfromPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accmulator != nil {
            accmulator = pendingBinaryOperation!.perfrom(with: accmulator!)
            pendingBinaryOperation = nil
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accmulator = operand
    }
    
    var result: Double? {
        get {
            return accmulator
        }
    }
}
