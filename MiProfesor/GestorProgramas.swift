//
//  GestorProgramas.swift
//  miProfe
//
//  Created by capitan on 29/11/16.
//  Copyright © 2016 capitan. All rights reserved.


import UIKit

class GestorProgramas {
    
    
    var callback:Any?
    
    init() {
        self.callback = nil
    }
    
    func processProgramas(data:Data?){
        
        var programas:[Programa] = [Programa]()
        //primera forma
        var programa:Programa?
        
        do{
            
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String: Any]]
            
            for  i in 0..<json.count  {
                let id = String(json[i]["idPrograma"] as! Int)
                let nombre = json[i]["nombrePrograma"] as! String
                let descripcion = json[i]["descripcionPrograma"] as! String
                let foto = json[i]["fotoPrograma"] as! String
                let idU = json[i]["programa_idPrograma"] as! Int
                programa = Programa(id: id, nombre: nombre, descripcion: descripcion,foto:nil , idU:String(idU) )
                if let progra = programa {
                    
                    programas.append(progra)
                    
                }
            }
            let callb = self.callback as! (_ programas:[Programa])->Void
            callb(programas)
            
        }catch{}
        
        
        
        func agregarPrograma(){
            
            //primera forma
            var programa:Programa?
            
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
        
        
        
        func obtenerProgramas(callback:@escaping (_ programas:[Programa])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.get(url: "http://192.168.0.90:8081/programa", callback: processProgramas(data: <#T##Data?#>)
            )
        }
        
        func EliminarPrograma(callback:@escaping (_ programas:[Programa])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.delete(url: <#T##String#>, callback: <#T##(Data?) -> Void#>)(url: "http://192.168.0.90:8081/programa", callback: processProgramas(data: <#T##Data?#>))
        }
        
        func agregarEstudiante(callback:@escaping (_ estudiantes:[Estudiante])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.post(url: "http://192.168.0.90:8081/estudiante", json:json, callback:agregarPrograma())
        }
        
        
        func editarEstudiante(callback:@escaping (_ estudiantes:[Estudiante])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.post(url: "http://192.168.0.90:8081/estudiante", json:json, callback:agregarEstudiantes)
        }
        
        
        
        
        
}
