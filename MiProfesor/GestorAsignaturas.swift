//
//  gestorAsignatura.swift
//  miProfe
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//
import UIKit

class GestorAsignaturas {
    
    var callback:Any?
    
    init() {
        self.callback = nil
    }
    
    func processAsignaturas(data:Data?){
        
        var asignaturas:[Asignatura] = [Asignatura]()
        //primera forma
        var asignatura:Asignatura?
        
        do{
            
            
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String: Any]]
            
            var idAsignatura: String
            var nombreAsignatura:String
            var descripcionAsignatura: String?
            var fotoAsignatura: String?
            var semestreAsignatura:String
            
            for  i in 0..<json.count  {
                let id = String(json[i]["idAsignatura"] as! Int)
                let nombre = json[i]["nombreAsignatura"] as! String
                let descripcion = json[i]["descripcionAsignatura"] as! String
                let foto = json[i]["fotoAsignatura"] as! String
                let semestre = json[i]["semestreAsignatura"] as! String
                asignatura = Asignatura(id: id, nombre: nombre, descripcion: descripcion, foto: foto, semestre : semestre)
                if let asig = asignatura {
                    
                    
                    asignaturas.append(asig)
                    
                }
            }
            let callb = self.callback as! (_ asignaturas:[Asignatura])->Void
            callb(asignaturas)
            
        }catch{}
    }
    
        
        func agregarAsignaturas(){
            
            //primera forma
            var asignatura:Asignatura?
            
            
            let callb = self.callback as! (_ asignatura:Asignatura?)->Void
            callb(asignatura)
        }
        
        
        
        func obtenerAsignatura(callback:@escaping (_ asignaturas:[Asignatura])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.get(url: "http://192.168.0.90:8081/asignatura", callback: processAsignaturas)
        }
        
        func EliminarAsignatura(callback:@escaping (_ asignaturas:[Asignatura])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.delete(url: "http://192.168.0.90:8081/asignatura", callback: processAsignaturas)
        }
        
        func agregarAsignatura(callback:@escaping (_ asignaturas:[Asignatura])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.post(url: "http://192.168.0.90:8081/asignatura", json:String?, callback:agregarAsignaturas)
        }
        
        
        func editarAsignatura(callback:@escaping (_ asignaturas:[Asignatura])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.put(url: "http://192.168.0.90:8081/asignatura", json:string?, callback:agregarAsignaturas)
        }
        
        
        
}

