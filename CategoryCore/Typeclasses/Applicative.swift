//
//  Applicative.swift
//  CategoryCore
//
//  Created by Tomás Ruiz López on 28/9/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import Foundation

public protocol Applicative : Functor {
    func pure<A>(_ a : A) -> HK<F, A>
    func ap<A, B>(_ fa : HK<F, A>, _ ff : HK<F, (A) -> B>) -> HK<F, B>
}

public extension Applicative {
    public func map<A, B>(_ fa: HK<F, A>, _ f: @escaping (A) -> B) -> HK<F, B> {
        return ap(fa, pure(f))
    }
    
    public func product<A, B>(_ fa : HK<F, A>, _ fb : HK<F, B>) -> HK<F, (A, B)> {
        return self.ap(fb, self.map(fa, { (a : A) in { (b : B) in (a, b) }}))
    }
    
    public func product<A, B, Z>(_ fa : HK<F, (A, B)>, _ fz : HK<F, Z>) -> HK<F, (A, B, Z)> {
        return self.map(self.product(fa, fz), { a, b in (a.0, a.1, b) })
    }
    
    public func product<A, B, C, Z>(_ fa : HK<F, (A, B, C)>, _ fz : HK<F, Z>) -> HK<F, (A, B, C, Z)> {
        return self.map(self.product(fa, fz), { a, b in (a.0, a.1, a.2, b) })
    }
    
    public func product<A, B, C, D, Z>(_ fa : HK<F, (A, B, C, D)>, _ fz : HK<F, Z>) -> HK<F, (A, B, C, D, Z)> {
        return self.map(self.product(fa, fz), { a, b in (a.0, a.1, a.2, a.3, b) })
    }
    
    public func product<A, B, C, D, E, Z>(_ fa : HK<F, (A, B, C, D, E)>, _ fz : HK<F, Z>) -> HK<F, (A, B, C, D, E, Z)> {
        return self.map(self.product(fa, fz), { a, b in (a.0, a.1, a.2, a.3, a.4, b) })
    }
    
    public func product<A, B, C, D, E, G, Z>(_ fa : HK<F, (A, B, C, D, E, G)>, _ fz : HK<F, Z>) -> HK<F, (A, B, C, D, E, G, Z)> {
        return self.map(self.product(fa, fz), { a, b in (a.0, a.1, a.2, a.3, a.4, a.5, b) })
    }
    
    public func product<A, B, C, D, E, G, H, Z>(_ fa : HK<F, (A, B, C, D, E, G, H)>, _ fz : HK<F, Z>) -> HK<F, (A, B, C, D, E, G, H, Z)> {
        return self.map(self.product(fa, fz), { a, b in (a.0, a.1, a.2, a.3, a.4, a.5, a.6, b) })
    }
    
    public func product<A, B, C, D, E, G, H, I, Z>(_ fa : HK<F, (A, B, C, D, E, G, H, I)>, _ fz : HK<F, Z>) -> HK<F, (A, B, C, D, E, G, H, I, Z)> {
        return self.map(self.product(fa, fz), { a, b in (a.0, a.1, a.2, a.3, a.4, a.5, a.6, a.7, b) })
    }
    
    public func map2<A, B, Z>(_ fa : HK<F, A>, _ fb : HK<F, B>, _ f : @escaping (A, B) -> Z) -> HK<F, Z> {
        return map(product(fa, fb), f)
    }
    
    public func map2Eval<A, B, Z>(_ fa : HK<F, A>, _ fb : Eval<HK<F, B>>, _ f : @escaping (A, B) -> Z) -> Eval<HK<F, Z>> {
        return fb.map{ fc in self.map2(fa, fc, f) }
    }
    
    public func tupled<A, B>(_ a : HK<F, A>,
                             _ b : HK<F, B>) -> HK<F, (A, B)> {
        return product(a, b)
    }
    
    public func tupled<A, B, C>(_ a : HK<F, A>,
                                _ b : HK<F, B>,
                                _ c : HK<F, C>) -> HK<F, (A, B, C)> {
        return product(product(a, b), c)
    }
    
    public func tupled<A, B, C, D>(_ a : HK<F, A>,
                                   _ b : HK<F, B>,
                                   _ c : HK<F, C>,
                                   _ d : HK<F, D>) -> HK<F, (A, B, C, D)> {
        return product(product(product(a, b), c), d)
    }
    
    public func tupled<A, B, C, D, E>(_ a : HK<F, A>,
                                      _ b : HK<F, B>,
                                      _ c : HK<F, C>,
                                      _ d : HK<F, D>,
                                      _ e : HK<F, E>) -> HK<F, (A, B, C, D, E)> {
        return product(product(product(product(a, b), c), d), e)
    }
    
    public func tupled<A, B, C, D, E, G>(_ a : HK<F, A>,
                                         _ b : HK<F, B>,
                                         _ c : HK<F, C>,
                                         _ d : HK<F, D>,
                                         _ e : HK<F, E>,
                                         _ g : HK<F, G>) -> HK<F, (A, B, C, D, E, G)> {
        return product(product(product(product(product(a, b), c), d), e), g)
    }
    
    public func tupled<A, B, C, D, E, G, H>(_ a : HK<F, A>,
                                            _ b : HK<F, B>,
                                            _ c : HK<F, C>,
                                            _ d : HK<F, D>,
                                            _ e : HK<F, E>,
                                            _ g : HK<F, G>,
                                            _ h : HK<F, H>) -> HK<F, (A, B, C, D, E, G, H)> {
        return product(product(product(product(product(product(a, b), c), d), e), g), h)
    }
    
    public func tupled<A, B, C, D, E, G, H, I>(_ a : HK<F, A>,
                                               _ b : HK<F, B>,
                                               _ c : HK<F, C>,
                                               _ d : HK<F, D>,
                                               _ e : HK<F, E>,
                                               _ g : HK<F, G>,
                                               _ h : HK<F, H>,
                                               _ i : HK<F, I>) -> HK<F, (A, B, C, D, E, G, H, I)> {
        return product(product(product(product(product(product(product(a, b), c), d), e), g), h), i)
    }
    
    public func tupled<A, B, C, D, E, G, H, I, J>(_ a : HK<F, A>,
                                                  _ b : HK<F, B>,
                                                  _ c : HK<F, C>,
                                                  _ d : HK<F, D>,
                                                  _ e : HK<F, E>,
                                                  _ g : HK<F, G>,
                                                  _ h : HK<F, H>,
                                                  _ i : HK<F, I>,
                                                  _ j : HK<F, J>) -> HK<F, (A, B, C, D, E, G, H, I, J)> {
        return product(product(product(product(product(product(product(product(a, b), c), d), e), g), h), i), j)
    }
    
    func map<A, B, Z>(_ a : HK<F, A>,
                      _ b : HK<F, B>,
                      _ f : @escaping (A, B) -> Z) -> HK<F, Z> {
        return map(tupled(a, b), f)
    }
    
    func map<A, B, C, Z>(_ a : HK<F, A>,
                         _ b : HK<F, B>,
                         _ c : HK<F, C>,
                         _ f : @escaping (A, B, C) -> Z) -> HK<F, Z> {
        return map(tupled(a, b, c), f)
    }
    
    func map<A, B, C, D, Z>(_ a : HK<F, A>,
                            _ b : HK<F, B>,
                            _ c : HK<F, C>,
                            _ d : HK<F, D>,
                            _ f : @escaping (A, B, C, D) -> Z) -> HK<F, Z> {
        return map(tupled(a, b, c, d), f)
    }
    
    func map<A, B, C, D, E, Z>(_ a : HK<F, A>,
                               _ b : HK<F, B>,
                               _ c : HK<F, C>,
                               _ d : HK<F, D>,
                               _ e : HK<F, E>,
                               _ f : @escaping (A, B, C, D, E) -> Z) -> HK<F, Z> {
        return map(tupled(a, b, c, d, e), f)
    }
    
    func map<A, B, C, D, E, G, Z>(_ a : HK<F, A>,
                                  _ b : HK<F, B>,
                                  _ c : HK<F, C>,
                                  _ d : HK<F, D>,
                                  _ e : HK<F, E>,
                                  _ g : HK<F, G>,
                                  _ f : @escaping (A, B, C, D, E, G) -> Z) -> HK<F, Z> {
        return map(tupled(a, b, c, d, e, g), f)
    }
    
    func map<A, B, C, D, E, G, H, Z>(_ a : HK<F, A>,
                                     _ b : HK<F, B>,
                                     _ c : HK<F, C>,
                                     _ d : HK<F, D>,
                                     _ e : HK<F, E>,
                                     _ g : HK<F, G>,
                                     _ h : HK<F, H>,
                                     _ f : @escaping (A, B, C, D, E, G, H) -> Z) -> HK<F, Z> {
        return map(tupled(a, b, c, d, e, g, h), f)
    }
    
    func map<A, B, C, D, E, G, H, I, Z>(_ a : HK<F, A>,
                                        _ b : HK<F, B>,
                                        _ c : HK<F, C>,
                                        _ d : HK<F, D>,
                                        _ e : HK<F, E>,
                                        _ g : HK<F, G>,
                                        _ h : HK<F, H>,
                                        _ i : HK<F, I>,
                                        _ f : @escaping (A, B, C, D, E, G, H, I) -> Z) -> HK<F, Z> {
        return map(tupled(a, b, c, d, e, g, h, i), f)
    }
    
    func map<A, B, C, D, E, G, H, I, J, Z>(_ a : HK<F, A>,
                                           _ b : HK<F, B>,
                                           _ c : HK<F, C>,
                                           _ d : HK<F, D>,
                                           _ e : HK<F, E>,
                                           _ g : HK<F, G>,
                                           _ h : HK<F, H>,
                                           _ i : HK<F, I>,
                                           _ j : HK<F, J>,
                                           _ f : @escaping (A, B, C, D, E, G, H, I, J) -> Z) -> HK<F, Z> {
        return map(tupled(a, b, c, d, e, g, h, i, j), f)
    }
}

