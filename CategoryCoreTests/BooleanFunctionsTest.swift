//
//  BooleanFunctionsTest.swift
//  CategoryCoreTests
//
//  Created by Tomás Ruiz López on 20/11/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import XCTest
import SwiftCheck
@testable import CategoryCore

class BooleanFunctionsTest: XCTestCase {
    
    func testDeMorganLaws() {
        property("¬(a ^ b) == ¬a v ¬b") <- forAll() { (a : Bool, b : Bool) in
            not(and(a, b)) == or(not(a), not(b))
        }
        
        property("¬(a v b) == ¬a ^ ¬b") <- forAll() { (a : Bool, b : Bool) in
            not(or(a, b)) == and(not(a), not(b))
        }
    }
    
    func testXor() {
        property("xor(a, b) == (¬a ^ b) v (a ^ ¬b)") <- forAll() { (a : Bool, b : Bool) in
            xor(a, b) == or(and(not(a), b), and(a, not(b)))
        }
    }
    
}
