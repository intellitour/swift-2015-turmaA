//
//  Usuario.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 23/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import Foundation
import CoreData


class Usuario: NSManagedObject {


    func preencherComUser(user: User) {
        
        guard let ctx = self.managedObjectContext else {
            return
        }
        
        self.identifier = "\(user.identifier)"
        self.name = user.name
        self.username = user.username
        self.email = user.email
        self.phone = user.phone
        self.website = user.website
        
        if let address = user.address {
            let end = NSEntityDescription.insertNewObjectForEntityForName("Endereco", inManagedObjectContext: ctx) as! Endereco
            end.preencherComAddress(address)
            self.address = end
        }
        
        if let company = user.company {
            let empresa = NSEntityDescription.insertNewObjectForEntityForName("Empresa", inManagedObjectContext: ctx) as! Empresa
            empresa.preencherComCompany(company)
            self.company = empresa
        }
        
    }
    

}
