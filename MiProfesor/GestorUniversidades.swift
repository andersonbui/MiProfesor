//
//  gestorUniversidad.swift
//  miProfe
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//
import UIKit

class GestorUniversidades {
    
    
    var callback:Any?
    
    init() {
        self.callback = nil
    }
    
    func processUniversidades(data:Data?){
        
        var universidades:[Universidad] = [Universidad]()
        //primera forma
        var universidad:Universidad?
        
        do{
            
            
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String: Any]]
            
            for  i in 0..<json.count  {
                let id = String(json[i]["idUniversidad"] as! Int)
                let nombre = json[i]["nombreUniversidad"] as! String
                let descripcion = json[i]["descripcionUniversidad"] as! String
                let foto = json[i]["fotoUniversidad"] as! String
                universidad = Universidad(id: id, nombre: nombre, descripcion: descripcion, foto: UIImage(named:foto))
                if let uni = universidad {
                    
                    
                    universidades.append(uni)
                    
                }
            }
            let callb = self.callback as! (_ universidades:[Universidad])->Void
            callb(universidades)
            
        }catch{}
        
    }
    
        func agregarUniversidades(){
            
            //primera forma
            var u:Universidad?
      
            let callb = self.callback as! (_ universidad:Universidad?)->Void
            callb(u)
        
        }
        
        
        
        func obtenerUniversidades(callback:@escaping (_ universidades:[Universidad])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.get(url: "http://192.168.0.90:8081/universidad", callback: processUniversidades)
        }
        
        
        func processNada(_ :Data?){}
        
        func EliminarUniversidad(id:String){
            let client:HttpClient = HttpClient()
            
            client.delete(url: "http://192.168.0.90:8081/universidad/"+id,callback: processNada)
        }
        
        
        func agregarUniversidad(univ:Universidad,callback:@escaping (_ universidades:[Universidad])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            
            client.post(url: "http://192.168.0.90:8081/universidad", json:univ?, callback:processNada)
        }
        
        
        
        func editarUniversidad(univ:Universidad, callback:@escaping (_ universidades:[Universidad])->Void){
            let client:HttpClient = HttpClient()
            self.callback = callback
            client.put(url: "http://192.168.0.90:8081/universidad", json:univ?, callback:agregarUniversidades)
        }
        
        
}

