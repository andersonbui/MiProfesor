//
//  GestorEstudiantes.swift
//  miProfe
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//

import UIKit

class GestorEstudintes {
    
    
    var callback:Any?
    
    init() {
        self.callback = nil
    }
    
    func processEstudiantes(data:Data?){
        
        var estudiantes:[Estudiante] = [Estudiante]()
        //primera forma
        var estudiante:Estudiante?
        
        do{
            
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String: Any]]
            
            for  i in 0..<json.count  {
                let codigo = String(json[i]["codigoEstudiante"] as! Int)
                let nombre = json[i]["nombreEstudiante"] as! String
                let celular = json[i]["celularEstudiante"] as! String
                let email = json[i]["emailEstudiante"] as! String
                let foto = json[i]["fotoEstudiante"] as! String
                let semestre = json[i]["semestreEstudiante"] as! Int
                let usr = json[i]["usrEstudiante"] as! String
                let pass = json[i]["passEstudiante"] as! String
                let idP = json[i]["programa_idPrograma"] as! Int
                estudiante = Estudiante(codigo: codigo, nombre: nombre, celular: celular,  email :email, semestre: String(semestre),foto:nil , usr:usr, pass:pass, idP:String(idP) )
                if let est = estudiante {
                    
                    estudiantes.append(est)
                    
                }
            }
            let callb = self.callback as! (_ estudiantes:[Estudiante])->Void
            callb(estudiantes)
            
        }catch{}
    }
    
        
        func agregarEstudiantes(){
            
            //primera forma
            var estudiante:Estudiante?
            
            //    estudiante?.codigoEstudiante="999";
            //  estudiante?.nombreEstudiantee="UNIpepe";
            //  estudiante?.celularEstudiante="CHIMBA";
            //  estudiante?.emailEstudiante="direccion";
            // estudiante?.usrEstudiante="pepe";
            // estudiante?.passEstudiante="pepe";
            // estudiante?.programa_idPrograma="123";
            
            //  let callb = self.callback as! (_ estudiantes:Estudiante?)->Void
            // callb(estudiantes)
        }
        
        
        
        func obtenerEstudiantes(callback:@escaping (_ estudiantes:[Estudiante])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.get(url: "http://192.168.0.90:8081/estudiante", callback: processEstudiantes
            )
        }
        
        func processNada(_ :Data?){}
        
        func EliminarEstudiante(id:String){
            let client:HttpClient = HttpClient()
            client.delete(url: "http://192.168.0.90:8081/estudiante", callback: processNada)
        }
        
        
        func agregarEstudiante(callback:@escaping (_ estudiantes:[Estudiante])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.post(url: "http://192.168.0.90:8081/estudiante", json:json, callback:agregarEstudiantes)
        }
        
        
        func editarEstudiante(callback:@escaping (_ estudiantes:[Estudiante])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.post(url: "http://192.168.0.90:8081/estudiante", json:json, callback:agregarEstudiantes)
        }
        
        
        
        
        
}
