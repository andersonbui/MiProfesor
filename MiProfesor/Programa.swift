import UIKit

class Programa {
    
    //MARK: - Properties
    
    var id: String
    var nombre:String
    var descripcion: String?
    var idUniversidad:String
    var foto:UIImage?
    
    // MARK: Types
    
    init?(nombre: String, descripcion: String?, idUniversidad: String,foto: UIImage?) {
        //Initialize stored properties.
        
        self.id = ""
        self.nombre = nombre
        self.descripcion = descripcion
        self.idUniversidad = idUniversidad
        self.foto = foto
        
        //Initialization should fail if there is no name or if rating is negative.
        
        if nombre.isEmpty ||  idUniversidad.isEmpty {
            return nil
        }
        
    }
}

