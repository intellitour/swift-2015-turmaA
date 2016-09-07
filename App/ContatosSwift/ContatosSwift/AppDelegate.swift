//
//  AppDelegate.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 02/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var persistenceController: PersistenceController!
    
    class func currentPersistenceController() -> PersistenceController {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return delegate.persistenceController
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.persistenceController = PersistenceController(callback: { 
            //terminar a inicialização aqui
        })
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        self.persistenceController.salvar()
    }

    func applicationDidEnterBackground(application: UIApplication) {
        self.persistenceController.salvar()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        self.persistenceController.salvar()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        self.persistenceController.salvar()
    }

    func applicationWillTerminate(application: UIApplication) {
        self.persistenceController.salvar()
    }
}

