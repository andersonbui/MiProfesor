//
//  UniversidadTableViewCell.swift
//  MiProfesor
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//

import UIKit

class UniversidadTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var fotoUIImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
