//
//  Contact.swift
//  
//
//  Created by Igor Malyarov on 29.03.2023.
//

import Contacts
import Foundation

public struct Contact {
    
    typealias ID = String // better would be Tagged<Self, String>
    
    public var id: String { phone }
    public let phone: String
    public let firstName: String?
    public let middleName: String?
    public let lastName: String?
    public let avatar: ImageData?
    
    public init(phone: String, firstName: String?, middleName: String?, lastName: String?, avatar: ImageData?) {
        self.phone = phone
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.avatar = avatar
    }
}

public extension Contact {
    
    enum SortOrder {
        
        /// No sorting order.
        case none
        
        /// The user’s default sorting order.
        case userDefault
        
        /// Sorting contacts by given name.
        case givenName
        
        /// Sorting contacts by family name.
        case familyName
    }
}

public extension Contact.SortOrder {
    
    var cnContactSortOrder: CNContactSortOrder {
        
        switch self {
            
        case .none:        return .none
        case .userDefault: return .userDefault
        case .givenName:   return .givenName
        case .familyName:  return .familyName
        }
    }
}

public extension Contact {
    
    init?(with cnContact: CNContact) {
        
        guard
            let phoneNumberData = cnContact.phoneNumbers.first?.value as? CNPhoneNumber,
            let phoneNumber = phoneNumberData.value(forKey: "digits") as? String
        else {
            return nil
        }
        
        self.init(
            phone: phoneNumber,
            firstName: cnContact.givenName,
            middleName: cnContact.middleName,
            lastName: cnContact.familyName,
            avatar: Self.avatar(for: cnContact)
        )
    }
    
    private static func avatar(for cnContact: CNContact) -> ImageData? {
        
        guard let thumbnailImageData = cnContact.thumbnailImageData
        else { return nil }
        
        return ImageData(data: thumbnailImageData)
        
    }
}

public struct ImageData: Codable, Equatable {
    
    public let data: Data
}
