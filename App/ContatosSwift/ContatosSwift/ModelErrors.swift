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
    case InvalidLatitude, InvalidLongitude
}
extension GeoInitError : CustomStringConvertible {
    var description: String {
        switch self {
            case .MissingLatitude:
                return "O campo [ lat ] é obrigatório!"
            case.MissingLongitude:
                return "O campo [ lng ] é obrigatório!"
            case .InvalidLatitude:
                return "O campo [ lat ] deve estar entre -90 e +90!"
            case .InvalidLongitude:
                return "O campo [ lng ] deve estar entre -180 e +180!"
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
    
    case NameIsRequired, EmailIsRequired, EmailIsInvalid,
        PhoneIsRequired, WebsiteIsRequired, WebsiteIsInvalid
}
extension UserInitError : CustomStringConvertible {
    var description: String {
        switch self {
            case .MissingIdentifier:
                return "O campo [ identifier ] é obrigatório!"
            case .MissingName, .NameIsRequired:
                return "O campo [ name ] é obrigatório!"
            case .MissingUsername:
                return "O campo [ username ] é obrigatório!"
            case .MissingEmail, .EmailIsRequired:
                return "O campo [ email ] é obrigatório!"
            case .MissingAddress:
                return "O campo [ address ] é obrigatório!"
            case .MissingPhone, .PhoneIsRequired:
                return "O campo [ phone ] é obrigatório!"
            case .MissingWebsite, .WebsiteIsRequired:
                return "O campo [ website ] é obrigatório!"
            case .MissingCompany:
                return "O campo [ company ] é obrigatório!"
            case .EmailIsInvalid:
                return "O e-mail informado é inválido!"
            case .WebsiteIsInvalid:
                return "O website informado é inválido!"
        }
    }
}