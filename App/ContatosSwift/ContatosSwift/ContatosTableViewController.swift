//
//  ContatosTableViewController.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 02/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import UIKit

class ContatosTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        obterDados()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func obterDados() {
        let url = NSURL(string: "http://jsonplaceholder.typicode.com/users")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 30
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!) { (let data:NSData?,
                                                    let response:NSURLResponse?,
                                                    let error:NSError?) in
            if data != nil {
                do {
                    let usuarios = try NSJSONSerialization
                        .JSONObjectWithData(data!,
                            options: NSJSONReadingOptions.AllowFragments)
                    
                    if (usuarios.isKindOfClass(NSArray)) {
                        let arUsr:NSArray = usuarios as! NSArray
                        
                        var users = [User]()
                        
                        for usr in arUsr {
                            let usrDict:NSDictionary = usr as! NSDictionary
                            let user = User()
                            user.identifier = usrDict["id"] as! Int!
                            user.name = usrDict["name"] as! String!
                            user.username = usrDict["username"] as! String!
                            user.email = usrDict["email"] as! String!
                            user.phone = usrDict["phone"] as! String!
                            user.website = usrDict["website"] as! String!
                            
                            let adr = usrDict["address"]!
                            let geo = adr["geo"] as! NSDictionary
                            
                            
                            let latitude = Double(geo["lat"] as! String!)!
                            let longitude = Double(geo["lng"] as! String!)!
                            
                            user.address = Address(street: adr["street"] as! String!,
                                                   suite: adr["suite"] as! String!,
                                                   city: adr["city"] as! String!,
                                                   zipcode: adr["zipcode"] as! String!,
                                                   geo: Geo(lat: latitude,
                                                    lng: longitude))
                            
                            let cmp = usrDict["company"]!
                            
                            
                            user.company = Company(name: cmp["name"] as! String!,
                                                   catchPhrase: cmp["catchPhrase"] as! String!,
                                                   bs: cmp["bs"] as! String!)
                            
                            users.append(user)
                        }
                        print("Recebi usuários: \(users)")
                    }
                }catch {
                    print("Erro ao converter o JSON")
                }
                
            }else {
                print("Deu erro: \(error)")
            }
        }
        
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
