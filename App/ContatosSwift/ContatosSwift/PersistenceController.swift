//
//  PersistenceController.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 23/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import CoreData


public class PersistenceController {
    
    public var managedObjectContext: NSManagedObjectContext?
    private var privateContext: NSManagedObjectContext?
    private var initCallback: () -> Void
    
    init(callback: (() -> Void)) {
        self.initCallback = callback
        iniciarCoreData()
    }
    
    
    private func iniciarCoreData() {
        if self.managedObjectContext != nil {
            return
        }
        
        autoreleasepool({
            if let url = NSBundle.mainBundle().URLForResource("ContatosSwift", withExtension: "momd") {
                if let mom = NSManagedObjectModel(contentsOfURL: url) {
                   
                    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: mom)
                    let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
                    let privateContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
                    privateContext.persistentStoreCoordinator = coordinator;
                    managedObjectContext.parentContext = privateContext
                    
                    self.managedObjectContext = managedObjectContext
                    self.privateContext = privateContext
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { 
                        autoreleasepool({
                            if let poc = self.privateContext {
                                if let psc = poc.persistentStoreCoordinator {
                                    var options = [String: AnyObject]()
                                    options[NSMigratePersistentStoresAutomaticallyOption] = true
                                    options[NSInferMappingModelAutomaticallyOption] = true
                                    options[NSSQLitePragmasOption] = ["journal_mode":"DELETE"]
                                    
                                    let fileManager = NSFileManager.defaultManager()
                                    if let documentsURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last {
                                        let storeURL = documentsURL.URLByAppendingPathComponent("ContatosSwiftDataModel.sqlite")
                                        do {
                                            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options)
                                            
                                            self.initCallback()
                                            return
                                        }catch let error {
                                            print("Erro ao iniciar Persistent Store: \n \(error)")
                                        }
                                    }
                                }
                            }
                        })
                    })
                }
            }
        })
        
    }
    
    public func salvar() {
        guard let privateContext = self.privateContext else {
            return
        }
        guard let managedObjectContext = self.managedObjectContext else {
            return
        }
        
        if !privateContext.hasChanges && !managedObjectContext.hasChanges {
            return
        }
        
        managedObjectContext.performBlockAndWait({
            do {
                try managedObjectContext.save()
                privateContext.performBlockAndWait({
                    do {
                        try privateContext.save()
                    }catch let erroPrivate {
                        print("Erro ao salvar contexto privado: \(erroPrivate)")
                    }
                })
                
            }catch let erro {
                print("Erro ao salvar contexto principal: \(erro)")
            }
        })
    }
    
}

