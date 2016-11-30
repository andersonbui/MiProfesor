import UIKit

class Asignatura {
    
    //MARK: - Properties
    
    var id: String
    var nombre:String
    var descripcion: String?
    var semestre:Int
    var foto:UIImage?
    
    // MARK: Types
    
    init?( nombre: String, descripcion: String?, semestre: Int,foto: UIImage?) {
        //Initialize stored properties.
        
        self.id = ""
        self.nombre = nombre
        self.descripcion = descripcion
        self.semestre = semestre
        self.foto = foto
        
        //Initialization should fail if there is no name or if rating is negative.
        
        if nombre.isEmpty   {
            return nil
        }
        
    }
}

