//
//  User.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 02/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import Foundation

struct Geo {
    var lat: Double?
    var lng: Double?
    
    init(dict: [String: AnyObject]) throws {
        guard let lat = dict["lat"] as? String else {
            throw GeoInitError.MissingLatitude
        }
        self.lat = Double(lat)
        
        guard let lng = dict["lng"] as? String else {
            throw GeoInitError.MissingLongitude
        }
        self.lng = Double(lng)
    }
    
    func asDictionary() -> [String: AnyObject] {
        var dict = [String: AnyObject]()
        
        dict["lat"] = self.lat
        dict["lng"] = self.lng
        
        return dict
    }
}

struct Address {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?
    
    init(dict: [String: AnyObject]) throws {
        guard let street = dict["street"] as? String else {
            throw AddressInitError.MissingStreet
        }
        self.street = street
        
        guard let suite = dict["suite"] as? String else {
            throw AddressInitError.MissingSuite
        }
        self.suite = suite
        
        guard let city = dict["city"] as? String else {
            throw AddressInitError.MissingCity
        }
        self.city = city
        
        guard let zip = dict["zipcode"] as? String else {
            throw AddressInitError.MissingZipcode
        }
        self.zipcode = zip
        
        guard let geo = dict["geo"] as? [String: AnyObject] else {
            throw AddressInitError.MissingGeo
        }
        self.geo = try Geo(dict: geo)
    }
    
    func asDictionary() -> [String: AnyObject] {
        var dict = [String: AnyObject]()
        
        dict["street"] = self.street
        dict["suite"] = self.suite
        dict["city"] = self.city
        dict["zipcode"] = self.zipcode
        dict["geo"] = self.geo?.asDictionary()
        
        return dict
    }
}

struct Company {
    var name: String?
    var catchPhrase: String?
    var bs: String?
    
    init(dict: [String: AnyObject]) throws {
        
        guard let name = dict["name"] as? String else {
            throw CompanyInitError.MissingName
        }
        self.name = name
        
        guard let catchPhrase = dict["catchPhrase"] as? String else {
            throw CompanyInitError.MissingCatchPhrase
        }
        self.catchPhrase = catchPhrase
        
        guard let bs = dict["bs"] as? String else {
            throw CompanyInitError.MissingBs
        }
        self.bs = bs
    }
    
    func asDictionary() -> [String: AnyObject] {
        var dict = [String: AnyObject]()
        
        dict["name"] = self.name
        dict["catchPhrase"] = self.catchPhrase
        dict["bs"] = self.bs
        
        return dict
    }
}

class User {
    
    var identifier: Int?
    var name: String?
    var username: String?
    var email: String?
    
    var address: Address?
    
    var phone: String?
    var website: String?
    
    var company: Company?
    
    init() {
        
    }
    
    init(dict: [String: AnyObject]) throws {
        
        guard let identifier = dict["id"] as? Int else {
            throw UserInitError.MissingIdentifier
        }
        self.identifier = identifier
        
        guard let name = dict["name"] as? String else {
            throw UserInitError.MissingName
        }
        self.name = name
        
        guard let username = dict["username"] as? String else {
            throw UserInitError.MissingUsername
        }
        self.username = username
        
        guard let email = dict["email"] as? String else {
            throw UserInitError.MissingEmail
        }
        self.email = email
        
        guard let address = dict["address"] as? [String: AnyObject] else {
            throw UserInitError.MissingAddress
        }
        self.address = try Address(dict: address)
        
        guard let phone = dict["phone"] as? String else {
            throw UserInitError.MissingPhone
        }
        self.phone = phone
        
        guard let website = dict["website"] as? String else {
            throw UserInitError.MissingWebsite
        }
        self.website = website
        
        guard let company = dict["company"] as? [String: AnyObject] else {
            throw UserInitError.MissingCompany
        }
        self.company = try Company(dict: company)
     }
    
    func asDictionary() -> [String: AnyObject] {
        var dict = [String: AnyObject]()
        
        dict["id"] = self.identifier
        dict["name"] = self.name
        dict["username"] = self.username
        dict["email"] = self.email
        dict["address"] = self.address?.asDictionary()
        dict["phone"] = self.phone
        dict["website"] = self.website
        dict["company"] = self.company?.asDictionary()
        
        return dict
    }
    
}