//
//  Extensions.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 10/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import UIKit


extension String {
    func isValidEmail() -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailPattern).evaluateWithObject(self)
    }
    
    func isNumber() -> Bool {
        let numberCharacters = NSCharacterSet.decimalDigitCharacterSet().invertedSet
        return !self.isEmpty && self.rangeOfCharacterFromSet(numberCharacters) == nil
    }
}

extension UIImageView {
    func carregarAssincrono(url: NSURL) {
        self.image = UIImage(named: "placeholderFoto")
        
        let loader = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        loader.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loader)
        
        let cX = loader.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor)
        let cY = loader.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor)
        self.addConstraints([cX, cY])
        
        loader.startAnimating()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { 
            let request = NSURLRequest(URL: url, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30)
            let session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
            let downloadTask = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?,
                                                                                          response: NSURLResponse?,
                                                                                          error: NSError?) in
                if let imgData = data {
                    let img = UIImage(data: imgData)
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.image = img
                    })
                }
                
                if let erro = error {
                    print("Erro ao baixar imagem: \(erro)")
                }
                
                dispatch_async(dispatch_get_main_queue(), { 
                    loader.stopAnimating()
                    loader.removeFromSuperview()
                })
                
            })
            downloadTask.resume()
        }
    }
}