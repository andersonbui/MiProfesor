//
//  ProfesorTableViewCell.swift
//  MiProfesor
//
//  Created by capitan on 29/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//

import UIKit

class ProfesorTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var referenciaLabel: UILabel!
    @IBOutlet weak var fotoImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
