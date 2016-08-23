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
    
    init() {
    }
    
    init(lat: Double, lng: Double) throws {
        guard (lat < 90 && lat > -90) else {
            throw GeoInitError.InvalidLatitude
        }
        self.lat = lat
        
        guard (lng < 180 && lng > -180) else {
            throw GeoInitError.InvalidLongitude
        }
        self.lng = lng
    }
    
    init(dict: [String: AnyObject]) throws {
        self.init()
        
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
    
    init() {
    }
    
    init(street: String, suite: String, city: String, zipcode: String, geo: Geo) throws {
        guard street.characters.count > 0 else {
            throw AddressInitError.MissingStreet
        }
        self.street = street;
        
        guard suite.characters.count > 0 else {
            throw AddressInitError.MissingSuite
        }
        self.suite = suite
        
        guard city.characters.count > 0 else {
            throw AddressInitError.MissingCity
        }
        self.city = city
        
        guard zipcode.characters.count > 0 else {
            throw AddressInitError.MissingZipcode
        }
        self.zipcode = zipcode
        
        self.geo = geo
    }
    
    init(dict: [String: AnyObject]) throws {
        self.init()
        
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
    
    init() {
    }
    
    init(name: String, catchPhrase: String, bs: String) throws {
        guard name.characters.count > 0 else {
            throw CompanyInitError.MissingName
        }
        self.name = name
        
        guard catchPhrase.characters.count > 0 else {
            throw CompanyInitError.MissingCatchPhrase
        }
        self.catchPhrase = catchPhrase
        
        guard bs.characters.count > 0 else {
            throw CompanyInitError.MissingBs
        }
        self.bs = bs
    }
    
    init(dict: [String: AnyObject]) throws {
        self.init()
        
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
        self.identifier = Int(arc4random() % UInt32.max)
    }
    
    init(name: String, username: String, email: String, address: Address,
                       phone: String, website: String, company: Company) throws {
        
        self.identifier = Int(arc4random() % UInt32.max)
        
        guard name.characters.count > 0 else {
            throw UserInitError.NameIsRequired
        }
        self.name = name
        
        guard email.characters.count > 0 else {
            throw UserInitError.EmailIsRequired
        }
        guard email.isValidEmail() else {
            throw UserInitError.EmailIsInvalid
        }
        self.email = email
        
        guard phone.characters.count > 0 else {
            throw UserInitError.PhoneIsRequired
        }
        self.phone = phone
        
        guard website.characters.count > 0 else {
            throw UserInitError.WebsiteIsRequired
        }
        guard let site = NSURL(string: website) else {
            throw UserInitError.WebsiteIsInvalid
        }
        self.website = site.absoluteString
        
        self.address = address
        self.company = company
    }
    
    
    
    convenience init(dict: [String: AnyObject]) throws {
        self.init()
        
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