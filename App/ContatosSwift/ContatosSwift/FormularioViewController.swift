//
//  FormularioViewController.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 16/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import UIKit
import CoreData

class FormularioViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var campoNome: UITextField!
    @IBOutlet weak var campoLogin: UITextField!
    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var campoTelefone: UITextField!
    @IBOutlet weak var campoSite: UITextField!
    
    @IBOutlet weak var campoCidade: UITextField!
    @IBOutlet weak var campoLogradouro: UITextField!
    @IBOutlet weak var campoNumero: UITextField!
    @IBOutlet weak var campoCep: UITextField!
    
    @IBOutlet weak var campoLat: UITextField!
    @IBOutlet weak var campoLng: UITextField!
    
    @IBOutlet weak var campoEmpresa: UITextField!
    @IBOutlet weak var campoSlogan: UITextField!
    @IBOutlet weak var campoBs: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let campos = [campoNome, campoLogin, campoEmail, campoTelefone,
                      campoSite, campoCidade, campoLogradouro,
                      campoCep, campoLat, campoLng, campoEmpresa,
                      campoSlogan, campoBs, campoNumero]
        
        for campo in campos {
            campo.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: - UITextfieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == campoNome {
            campoLogin.becomeFirstResponder()
        }
        
        if textField == campoLogin {
            campoEmail.becomeFirstResponder()
        }
        
        if textField == campoEmail {
            campoTelefone.becomeFirstResponder()
        }
        
        if textField == campoTelefone {
            campoSite.becomeFirstResponder()
        }
        
        if textField == campoSite {
            campoCidade.becomeFirstResponder()
        }
        
        if textField == campoCidade {
            campoLogradouro.becomeFirstResponder()
        }
        
        if textField == campoLogradouro {
            campoNumero.becomeFirstResponder()
        }
        
        if textField == campoNumero {
            campoCep.becomeFirstResponder()
        }
        
        if textField == campoCep {
            campoLat.becomeFirstResponder()
        }
        
        if textField == campoLat {
            campoLng.becomeFirstResponder()
        }
        
        if textField == campoLng {
            campoEmpresa.becomeFirstResponder()
        }
        
        if textField == campoEmpresa {
            campoSlogan.becomeFirstResponder()
        }
        
        if textField == campoSlogan {
            campoBs.becomeFirstResponder()
        }
        
        return true
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string == "") {
            return true
        }
        
        if (textField == campoTelefone) {
            return string.isNumber()
        }
        
        if (textField == campoLat || textField == campoLng) {
            if (textField.text == "") {
                return string == "-" || string == "+"
            }
            if (textField == campoLat && textField.text?.characters.count == 3) { //latitude varia entre +90 e -90
                return string == "."
            }
            if (textField == campoLng && textField.text?.characters.count == 4) { //longitude varia entre +180 e -180
                return string == "."
            }
            return string.isNumber()
        }
        return true
    }
    
    
    @IBAction func onSave(sender: UIBarButtonItem) {
        do {
            var posicao: Geo?
            var endereco: Address?
            var empresa: Company?
            var user: User?
            
            if let lat = campoLat.text {
                if let lng = campoLng.text {
                    
                    if let latitude = Double(lat) {
                        if let longitude = Double(lng) {
                            posicao = try Geo(lat: latitude, lng: longitude)
                        }
                    }
                }
            }
            
            if let street = campoLogradouro.text {
                if let suite = campoNumero.text {
                    if let city = campoCidade.text {
                        if let zip = campoCep.text {
                            if let geo = posicao {
                                endereco = try Address(street: street, suite: suite, city: city, zipcode: zip, geo: geo)
                            }
                        }
                    }
                }
            }
            
            if let nomeEmpresa = campoEmpresa.text {
                if let frase = campoSlogan.text {
                    if let bs = campoBs.text {
                        empresa = try Company(name: nomeEmpresa, catchPhrase: frase, bs: bs)
                    }
                }
            }
            
            if let nome = campoNome.text {
                if let login = campoLogin.text {
                    if let email = campoEmail.text {
                        if let phone = campoTelefone.text {
                            if let site = campoSite.text {
                                if let address = endereco {
                                    if let company = empresa {
                                        user = try User(name: nome, username: login, email: email, address: address, phone: phone, website: site, company: company)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            if let usuario = user {
                print(usuario.asDictionary())
                
                if let ctx = AppDelegate.currentPersistenceController().managedObjectContext {
                    let usuarioPersistente = NSEntityDescription.insertNewObjectForEntityForName("Usuario", inManagedObjectContext: ctx) as! Usuario
                    usuarioPersistente.preencherComUser(usuario)
                    AppDelegate.currentPersistenceController().salvar()
                }
                enviarUsuario(usuario)
            }else {
                print("Faltando algum campo!");
            }
            
        }catch let error {
            print(error)
            
            let ac = UIAlertController(title: "Erro", message: String(error), preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            self.presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    private func enviarUsuario(usr: User) {
        let url = NSURL(string: "http://jsonplaceholder.typicode.com/users")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(usr.asDictionary(), options: .PrettyPrinted)
            request.HTTPBody = data
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler:
                { (let data:NSData?, let response:NSURLResponse?,
                    let error:NSError?) in
                
                    if let resp = response as? NSHTTPURLResponse {
                        if (resp.statusCode == 201) { //http://www.w3.org/Protocols/HTTP/HTRESP.html
                            print("Deu Certo")
                        }else {
                            print("Falhou com status: \(resp.statusCode)")
                        }
                    }
                    
            })
            task.resume()
        }catch let error {
            print("Erro ao converter JSON: \(error)")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
