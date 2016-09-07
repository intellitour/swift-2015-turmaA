//
//  Geolocalizacao.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 23/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import Foundation
import CoreData


class Geolocalizacao: NSManagedObject {


    func preencherComGeo(geo: Geo) {
        guard let lat = geo.lat else {
            return
        }
        guard let lng = geo.lng else {
            return
        }
        
        self.lat = lat
        self.lng = lng
    }
    

}
