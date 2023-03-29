//
//  Publisher+asResult.swift
//  
//
//  Created by Igor Malyarov on 20.09.2022.
//

import Combine

extension Publisher {
    
    func asResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        
        self.map(Result.success)
            .catch { Just(.failure($0)) }
            .eraseToAnyPublisher()
    }
}
