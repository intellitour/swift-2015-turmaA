//
//  ViewController.swift
//  ExemploMigracao
//
//  Created by Pedro Henrique on 30/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        
        if let entity = NSEntityDescription.entityForName("Pessoa", inManagedObjectContext: context) {
            let pessoa = Pessoa(entity: entity, insertIntoManagedObjectContext: context)
            
            pessoa.nome = "Pessoa \(NSDate())"
            pessoa.documento = "\(NSDate()))"
            pessoa.telefone = "23456789"
            
            do {
                try context.save()
            }catch let error {
                print("Erro ao salvar o contexto: \(error)")
            }
        
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

