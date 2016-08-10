//
//  ContatoCell.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 09/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import UIKit

class ContatoCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layer = self.cardView.layer
        layer.cornerRadius = 2
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSizeMake(0, 1)
        layer.shadowOpacity = 0.35
        layer.shadowRadius = 1.5
        
        profilePictureImageView.layer.cornerRadius =
            profilePictureImageView.frame.size.width / 2
        profilePictureImageView.layer.masksToBounds = true
        
    }
    
    func configurar(user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        
        let dpi = UIScreen.mainScreen().scale
        let tamanho = profilePictureImageView.frame.size.width * dpi
        
        let urlString = "http://lorempixel.com/\(Int(tamanho))/\(Int(tamanho))/people/"
        
        let url = NSURL(string: urlString)
        let imgData = NSData(contentsOfURL: url!)
        let img = UIImage(data: imgData!)
        
        profilePictureImageView.image = img
        
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
