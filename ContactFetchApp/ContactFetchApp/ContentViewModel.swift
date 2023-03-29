//
//  ContentViewModel.swift
//  ContactFetchApp
//
//  Created by Igor Malyarov on 29.03.2023.
//

import Combine
import ContactStoreComponent
import Foundation

final class ContentViewModel: ObservableObject {
    
    @Published private(set) var result: Result<TimeInterval, Error>?
    @Published var keys: ContactKeys = .identifiers
    
    private let keysSubject = PassthroughSubject<ContactKeys, Never>()
    
    init(store: ContactStore = .init()) {
        
        $keys
            .map { _ in Result<TimeInterval, Error>?.none }
            .receive(on: DispatchQueue.main)
            .assign(to: &$result)
        
        keysSubject
        // fetch contacts should not be called on Main thread
            .receive(on: DispatchQueue.global())
            .flatMap { [store] keys in Self.fetchKeys(keys: keys, from: store) }
            .asResult()
            .map(Optional.some)
            .receive(on: DispatchQueue.main)
            .assign(to: &$result)
    }
    
    func fetchContactsButtonTapped() {
        
        self.result = nil
        self.keysSubject.send(keys)
    }
    
    private static func fetchKeys(
        keys: ContactKeys,
        from store: ContactStore
    ) -> AnyPublisher<TimeInterval, Error> {
        
        Deferred {
            Future { promise in
                store.grantAccess { result in
                    
                    switch result {
                    case let .success(bool) where bool:
                        
                        let start = Date()
                        _ = try? store.fetch(withKeys: keys.cnKeyDescriptors)
                        let duration = start.distance(to: .now)
                        promise(.success(duration))
                        
                    default:
                        let error = NSError(domain: "Not authorized", code: 0)
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
