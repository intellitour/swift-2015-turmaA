//
//  Endereco.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 23/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import Foundation
import CoreData


class Endereco: NSManagedObject {


    func preencherComAddress(address: Address) {
        guard let ctx = self.managedObjectContext else {
            return
        }
        
        self.street = address.street
        self.suite = address.suite
        self.city = address.city
        self.zipcode = address.zipcode
        
        if let geo = address.geo {
            let ponto = NSEntityDescription.insertNewObjectForEntityForName("Geolocalizacao", inManagedObjectContext: ctx) as! Geolocalizacao
            ponto.preencherComGeo(geo)
            self.geo = ponto
        }
    }
}
