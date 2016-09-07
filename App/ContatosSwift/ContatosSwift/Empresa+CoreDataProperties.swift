//
//  Empresa+CoreDataProperties.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 23/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Empresa {

    @NSManaged var name: String?
    @NSManaged var catchPhrase: String?
    @NSManaged var bs: String?

}
