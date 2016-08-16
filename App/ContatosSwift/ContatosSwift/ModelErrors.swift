//
//  Erros.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 10/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import Foundation

enum GeoInitError: ErrorType {
    case MissingLatitude, MissingLongitude
}
extension GeoInitError : CustomStringConvertible {
    var description: String {
        switch self {
            case .MissingLatitude:
                return "O campo [ lat ] é obrigatório!"
            case.MissingLongitude:
                return "O campo [ lng ] é obrigatório!"
        }
    }
}

enum AddressInitError: ErrorType {
    case MissingStreet, MissingSuite, MissingCity,
        MissingZipcode, MissingGeo
}
extension AddressInitError : CustomStringConvertible {
    var description: String {
        switch self {
            case .MissingStreet:
                return "O campo [ street ] é obrigatório!"
            case .MissingSuite:
                return "O campo [ suite ] é obrigatório!"
            case .MissingCity:
                return "O campo [ city ] é obrigatório!"
            case .MissingZipcode:
                return "O campo [ zipcode ] é obrigatório!"
            case .MissingGeo:
                return "O campo [ geo ] é obrigatório!"
        }
    }
}


enum CompanyInitError : ErrorType {
    case MissingName, MissingCatchPhrase, MissingBs
}
extension CompanyInitError : CustomStringConvertible {
    var description: String {
        switch self {
            case .MissingName:
                return "O campo [ name ] é obrigatório!"
            case .MissingCatchPhrase:
                return "O campo [ catchPhrase ] é obrigatório!"
            case .MissingBs:
                return "O campo [ bs ] é obrigatório!"
        }
    }
}

enum UserInitError : ErrorType {
    case MissingIdentifier, MissingName, MissingUsername,
    MissingEmail, MissingAddress, MissingPhone,
    MissingWebsite, MissingCompany
}
extension UserInitError : CustomStringConvertible {
    var description: String {
        switch self {
            case .MissingIdentifier:
                return "O campo [ identifier ] é obrigatório!"
            case .MissingName:
                return "O campo [ name ] é obrigatório!"
            case .MissingUsername:
                return "O campo [ username ] é obrigatório!"
            case .MissingEmail:
                return "O campo [ email ] é obrigatório!"
            case .MissingAddress:
                return "O campo [ address ] é obrigatório!"
            case .MissingPhone:
                return "O campo [ phone ] é obrigatório!"
            case .MissingWebsite:
                return "O campo [ website ] é obrigatório!"
            case .MissingCompany:
                return "O campo [ company ] é obrigatório!"
        }
    }
}