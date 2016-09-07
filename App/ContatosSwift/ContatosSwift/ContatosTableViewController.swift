//
//  ContatosTableViewController.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 02/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class ContatosTableViewController: UITableViewController {
    
    private var users: [User]?
    private var usuarios : [Usuario]?
    private var isRemoto: Bool!
    
    private var fetchedResultsController: NSFetchedResultsController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.separatorStyle = .None
        
        
//        obterDados()
        obterDadosRemoto()
        
        let nib = UINib(nibName: "ContatoCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(nib, forCellReuseIdentifier: "celulaCustom")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func obterDados() {
        if let ctx = AppDelegate.currentPersistenceController().managedObjectContext {
            let fetchRequest = NSFetchRequest(entityName: "Usuario")
            fetchRequest.resultType = .CountResultType
            
            do {
                if let resultado = try ctx.executeFetchRequest(fetchRequest).first {
                    print("Resultado: \(resultado)")
                }
                
            }catch let error {
                print("Erro ao obter quantidade de registros do banco local: \(error)")
            }
            
        }
    }
    
    private func obterDadosRemoto() {
        let url = NSURL(string: "http://jsonplaceholder.typicode.com/users")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 30
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!) { (let data:NSData?,
                                                    let response:NSURLResponse?,
                                                    let error:NSError?) in
            
            var json: Array<[String: AnyObject]>!
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? Array
            }catch {
                print("Erro ao converter o JSON.")
            }
            var users = [User]()
            for item in json {
                do {
                    let user = try User(dict: item)
                    users.append(user)
                }catch let error as UserInitError {
                    print(error)
                }catch let error as GeoInitError {
                    print(error)
                }catch let error as AddressInitError {
                    print(error)
                }catch let error as CompanyInitError {
                    print(error)
                }catch {
                    print("Erro inesperado")
                }
            }
            self.users = users
            print("Recebidos os usuários: \(self.users)")
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.tableView.reloadData()
            })
        }
        task.resume()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let usuarios = self.users {
            return usuarios.count
        }else {
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celulaCustom", forIndexPath: indexPath) as! ContatoCell
        
        let user = self.users![indexPath.row]
        
        cell.configurar(user)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user = self.users![indexPath.row]
        performSegueWithIdentifier("mapaSegue", sender: user);
    }

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mapaSegue" {
            let destino = segue.destinationViewController as! MapaViewController
            destino.user = sender as? User
        }
    }

}
