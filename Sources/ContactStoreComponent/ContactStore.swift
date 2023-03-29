//
//  ContactStore.swift
//  
//
//  Created by Igor Malyarov on 29.03.2023.
//

import Contacts

/// A `CNContactStore` wrapper.
public final class ContactStore {
    
    private let store: CNContactStore
    
    public init(store: CNContactStore = .init()) {
        
        self.store = store
    }
    
    func fetchIdentifiers(
        sortOrder: CNContactSortOrder = .familyName
    ) throws -> [Identifier] {
        
        let keysToFetch = [
            CNContactPhoneNumbersKey,
            CNContactIdentifierKey
        ] as [CNKeyDescriptor]
        
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        request.sortOrder = sortOrder
        
        var identifiers = [Identifier]()
        
        try store.enumerateContacts(with: request) { contact, stop in
            
            identifiers.append(.init(id: contact.identifier))
        }
        
        return identifiers
    }
    
    public func grantAccess(completion: @escaping (Result<Bool, Error>) -> Void) {
        
        store.requestAccess(for: .contacts) { bool, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(bool))
        }
    }
    
    public func fetch(
        withKeys keysToFetch: [CNKeyDescriptor],
        sortOrder: CNContactSortOrder = .familyName
    ) throws -> [CNContact] {
        
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        request.sortOrder = sortOrder
        
        var contacts = [CNContact]()
        
        try store.enumerateContacts(with: request) { contact, stop in
            
            contacts.append(contact)
        }
        
        return contacts
    }
    
    func fetch(identifiers: [Identifier]) throws -> [Contact] {
        
        let keys = [CNContactPhoneNumbersKey,
                    CNContactGivenNameKey,
                    CNContactMiddleNameKey,
                    CNContactFamilyNameKey,
                    CNContactImageDataAvailableKey,
                    CNContactThumbnailImageDataKey
        ] as [CNKeyDescriptor]
        
        let request = CNContactFetchRequest(keysToFetch: keys)
        request.predicate = CNContact.predicateForContacts(withIdentifiers: identifiers.map(\.id))
        
        var contacts = [Contact]()
        
        try store.enumerateContacts(with: request) { contact, stop in
            
            if let contact = Contact(with: contact) {
                contacts.append(contact)
            }
        }
        
        return contacts
    }
    
    struct Identifier {
        
        let id: String
    }
}
