//
//  GestorProfesor.swift
//  miProfe
//
//  Created by capitan on 29/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//
//
//  gestorUniversidad.swift
//  miProfe
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//
import UIKit

class GestorProfesores {
    
    
    var callback:Any?
    
    init() {
        self.callback = nil
    }
    
    func processProfesores(data:Data?){
        
        var profesores:[Profesor] = [Profesor]()
        //primera forma
        var profesor:Profesor?
        
        do{
            
            
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String: Any]]
            
            
            var idProfesor: String
            var nombreProfesor:String
            var referenciaProfesor: String?
            var fotoProfesor: String?
            var calificacionProfesor: String?
            var idAsignatura:String
            
            for  i in 0..<json.count  {
                let id = String(json[i]["idProfesor"] as! Int)
                let nombre = json[i]["nombreProfesor"] as! String
                let referencia = json[i]["referenciaProfesor"] as! String
                let foto = json[i]["fotoProfesor"] as! String
                let calificacion = json[i]["calificacionProfesor"] as! String
                let idAsignatura = json[i]["idAsignatura"] as! String
                profesor = Profesor(id: id, nombre: nombre, referencia: referencia, calificacion: calificacion, foto:nil , idAsignatura:String (idAsignatura))
                if let profe = profesor {
                    
                    
                    profesores.append(profe)
                    
                }
            }
            let callb = self.callback as! (_ profesores:[Profesor])->Void
            callb(profesores)
            
        }catch{}
        
    }
        func processNada(_ :Data?){}
        
        func obtenerProfesores(callback:@escaping (_ universidades:[Universidad])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.get(url: "http://192.168.0.90:8081/universidad", callback: processProfesores)
        }
        
        func EliminarProfesor(id:String){
            let client:HttpClient = HttpClient()           
            client.delete(url: "http://192.168.0.90:8081/universidad"+id, callback: processNada)
        }
        
        func agregarProfesor(profre:Profesor, callback:@escaping (_ universidades:[Universidad])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.post(url: "http://192.168.0.90:8081/universidad", json:profe?, callback:processNada)
        }
        
        
        func editarUniversidad(profre:Profesor, callback:@escaping (_ universidades:[Universidad])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.put(url: "http://192.168.0.90:8081/universidad", json:profe?, callback:processNada)
        }
        
        
        
}

