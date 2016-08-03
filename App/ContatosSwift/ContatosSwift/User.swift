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
}

struct Address {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?
}

struct Company {
    var name: String?
    var catchPhrase: String?
    var bs: String?
}

class User: NSObject {
    
    var identifier: Int?
    var name: String?
    var username: String?
    var email: String?
    
    var address: Address?
    
    var phone: String?
    var website: String?
    
    var company: Company?
}
