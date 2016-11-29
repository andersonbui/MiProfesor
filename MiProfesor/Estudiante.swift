//
//  Estudiante.swift
//  miProfe
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//

import UIKit

class Estudiante {
  
    //MARK: - Properties
    
    var codigo: String
    var nombre:String
    var celular: String?
    var email: String?
    var semestre: String?
    var foto:UIImage?
    var usr: String
    var pass: String
    var idPrograma:String
    
    // MARK: Types
    
    init?(codigo: String,nombre: String, celular: String?,email: String?, semestre: String?,foto: UIImage?,usr: String,pass: String,idP: String) {
        //Initialize stored properties.
    
        self.codigo = codigo
        self.nombre = nombre
        self.celular = celular
        self.email = email
        self.semestre = semestre
        self.foto = foto
        self.usr = usr
        self.pass = pass
        self.idPrograma = idP
        
        //Initialization should fail if there is no name or if rating is negative.
        
        if nombre.isEmpty || codigo.isEmpty || usr.isEmpty || pass.isEmpty || idP.isEmpty {
            return nil
        }
        
    }
}

