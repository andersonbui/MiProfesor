import UIKit

class Profesor {
    
    //MARK: - Properties
    
    var id: String
    var nombre:String
    var referencia: String?
    var calificacion: Int?
    var idAsignatura:String
    var foto:UIImage?
    
    // MARK: Types
    
    init?(nombre: String, referencia: String?,calificacion: Int?, idAsignatura: String,foto: UIImage?) {
        //Initialize stored properties.
        
        self.id = ""
        self.nombre = nombre
        self.referencia = referencia
        self.calificacion = calificacion
        self.idAsignatura = idAsignatura
        self.foto = foto
        
        //Initialization should fail if there is no name or if rating is negative.
        
        if nombre.isEmpty || idAsignatura.isEmpty {
            return nil
        }
        
    }
}

