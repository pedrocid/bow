//
//  MonadFilterLaws.swift
//  CategoryCoreTests
//
//  Created by Tomás Ruiz López on 24/11/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import Foundation
import SwiftCheck
@testable import CategoryCore

class MonadFilterLaws<F> {
    
    static func check<MonFil, EqF>(monadFilter : MonFil, generator : @escaping (Int) -> HK<F, Int>, eq : EqF) where MonFil : MonadFilter, MonFil.F == F, EqF : Eq, EqF.A == HK<F, Int> {
        leftEmpty(monadFilter, generator, eq)
        rightEmpty(monadFilter, generator, eq)
        consistency(monadFilter, generator, eq)
    }
    
    private static func leftEmpty<MonFil, EqF>(_ monadFilter : MonFil, _ generator : @escaping (Int) -> HK<F, Int>, _ eq : EqF) where MonFil : MonadFilter, MonFil.F == F, EqF : Eq, EqF.A == HK<F, Int> {
        property("Left empty") <- forAll { (_ : Int) in
            return eq.eqv(monadFilter.flatMap(monadFilter.empty(), generator),
                          monadFilter.empty())
        }
    }
    
    private static func rightEmpty<MonFil, EqF>(_ monadFilter : MonFil, _ generator : @escaping (Int) -> HK<F, Int>, _ eq : EqF) where MonFil : MonadFilter, MonFil.F == F, EqF : Eq, EqF.A == HK<F, Int> {
        property("Right empty") <- forAll { (a : Int) in
            let fa = generator(a)
            return eq.eqv(monadFilter.flatMap(fa, constF(monadFilter.empty())),
                          monadFilter.empty())
        }
    }
    
    private static func consistency<MonFil, EqF>(_ monadFilter : MonFil, _ generator : @escaping (Int) -> HK<F, Int>, _ eq : EqF) where MonFil : MonadFilter, MonFil.F == F, EqF : Eq, EqF.A == HK<F, Int> {
        property("Consistency") <- forAll { (a : Int, b : Bool) in
            let f = { (_ : Int) in b }
            let fa = generator(a)
            return eq.eqv(monadFilter.filter(fa, f),
                          monadFilter.flatMap(fa, { a in f(a) ? monadFilter.pure(a) : monadFilter.empty() }))
        }
    }
}
