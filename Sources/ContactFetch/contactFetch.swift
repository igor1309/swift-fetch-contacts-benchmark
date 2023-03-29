//
//  contactFetch.swift
//  
//
//  Created by Igor Malyarov on 29.03.2023.
//

import Benchmark
import Contacts
import ContactStoreComponent

let contactFetch = BenchmarkSuite(name: "Contact Fetch") {
    
    let store = ContactStore()
    
    do {
        
        try store.grantAccess()
        
        $0.benchmark("identifiers") {
            
            store.tryFetch(withKeys: .identifiers)
        }
        
        $0.benchmark("identifiers and phone numbers") {
            
            store.tryFetch(withKeys: .identifiersAndNumbers)
        }
        
        $0.benchmark("many fields") {
            
            store.tryFetch(withKeys: .manyFields)
        }
        
    } catch {
        print(error.localizedDescription)
    }
}

private extension ContactStore {
    
    func tryFetch(
        withKeys keysToFetch: [CNKeyDescriptor],
        sortOrder: CNContactSortOrder = .familyName
    ) {
        _ = try? fetch(withKeys: keysToFetch, sortOrder: sortOrder)
    }
}

private extension Array where Element == CNKeyDescriptor {
    
    static let identifiers = [
        CNContactIdentifierKey,
    ] as [CNKeyDescriptor]
    
    static let identifiersAndNumbers = [
        CNContactIdentifierKey,
        CNContactPhoneNumbersKey,
    ] as [CNKeyDescriptor]
    
    static let manyFields = [
        CNContactPhoneNumbersKey,
        CNContactGivenNameKey,
        CNContactMiddleNameKey,
        CNContactFamilyNameKey,
        CNContactImageDataAvailableKey,
        CNContactThumbnailImageDataKey
    ] as [CNKeyDescriptor]
}
