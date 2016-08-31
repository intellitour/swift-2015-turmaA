//
//  Pessoa+CoreDataProperties.swift
//  ExemploMigracao
//
//  Created by Pedro Henrique on 30/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Pessoa {

    @NSManaged var documento: String?
    @NSManaged var nome: String?
    @NSManaged var telefone: String?

}
