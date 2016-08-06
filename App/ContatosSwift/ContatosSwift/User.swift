//
//  User.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 02/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import UIKit

struct Geo {
    var lat: Double?
    var lng: Double?
    
    init(dict: [String: AnyObject]) {
        if let lat = dict["lat"] as? String {
            self.lat = Double(lat)
        }
        
        if let lng = dict["lng"] as? String {
            self.lng = Double(lng)
        }
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
    
    init(dict: [String: AnyObject]) {
        if let street = dict["street"] as? String {
            self.street = street
        }
        
        if let suite = dict["suite"] as? String {
            self.suite = suite
        }
        
        if let city = dict["city"] as? String {
            self.city = city
        }
        
        if let zip = dict["zipcode"] as? String {
            self.zipcode = zip
        }
        
        if let geo = dict["geo"] as? [String: AnyObject] {
            self.geo = Geo(dict: geo)
        }
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
    
    init(dict: [String: AnyObject]) {
        
        if let name = dict["name"] as? String {
            self.name = name
        }
        
        if let catchPhrase = dict["catchPhrase"] as? String {
            self.catchPhrase = catchPhrase
        }
        
        if let bs = dict["bs"] as? String {
            self.bs = bs
        }
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
    
    init(dict: [String: AnyObject]) {
        
        if let identifier = dict["id"] as? Int {
            self.identifier = identifier
        }
        
        if let name = dict["name"] as? String {
            self.name = name
        }
        
        if let username = dict["username"] as? String {
            self.username = username
        }
        
        if let email = dict["email"] as? String {
            self.email = email
        }
        
        if let address = dict["address"] as? [String: AnyObject] {
            self.address = Address(dict: address)
        }
        
        if let phone = dict["phone"] as? String {
            self.phone = phone
        }
        
        if let website = dict["website"] as? String {
            self.website = website
        }
        
        if let company = dict["company"] as? [String: AnyObject] {
            self.company = Company(dict: company)
        }
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
