//
//  FormularioViewController.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 16/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import UIKit

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
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func onSave(sender: UIBarButtonItem) {
        let user = User()
        
        user.name = campoNome.text
        
        
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
