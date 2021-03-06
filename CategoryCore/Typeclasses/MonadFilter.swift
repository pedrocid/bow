//
//  MonadFilter.swift
//  CategoryCore
//
//  Created by Tomás Ruiz López on 29/9/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import Foundation

public protocol MonadFilter : Monad, FunctorFilter {
    func empty<A>() -> HK<F, A>
}

public extension MonadFilter {
    public func mapFilter<A, B>(_ fa : HK<F, A>, _ f : @escaping (A) -> Maybe<B>) -> HK<F, B>{
        return flatMap(fa, { a in
            f(a).fold(self.empty, self.pure)
        })
    }
}
