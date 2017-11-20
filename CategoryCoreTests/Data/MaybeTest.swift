//
//  MaybeTest.swift
//  CategoryCoreTests
//
//  Created by Tomás Ruiz López on 20/11/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import XCTest
@testable import CategoryCore

class MaybeTest: XCTestCase {
    
    var generator : (Int) -> HK<MaybeF, Int> {
        return { a in Maybe.pure(a) }
    }
    
    func testFunctorLaws() {
        FunctorLaws<MaybeF>.check(functor: Maybe<Int>.functor(), generator: self.generator, eq: Maybe<Int>.eq(Int.order))
    }
    
}
