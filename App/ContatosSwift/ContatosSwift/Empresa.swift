//
//  Empresa.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 23/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import Foundation
import CoreData


class Empresa: NSManagedObject {


    func preencherComCompany(company: Company) {
        self.name = company.name
        self.catchPhrase = company.catchPhrase
        self.bs = company.bs
    }
    

}
