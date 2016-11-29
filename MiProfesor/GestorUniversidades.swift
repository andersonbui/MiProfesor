//
//  GestorUniversidades.swift
//  MiProfesor
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
        //primera forma
        
        var universidades:[Universidad] = [Universidad]()
        /*var universidad:Universidad?
        do{
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String: Any]]
            
            
            let id = String(json[0]["idUniversidad"] as! Int)
            let nombre = json[0]["nombreUniversidad"] as! String
            let descripcion = json[0]["descripcionUniversidad"] as! String
            let foto = json[0]["fotoUniversidad"] as! String
            universidad = Universidad(id: id, nombre: nombre, descripcion: descripcion, foto: foto)
            if let uni = universidad {
                print("id: "+uni.id)
                print("nombre: "+uni.nombre)
                print("descripcion: "+uni.descripcion)
                if (uni.foto != nil) {
                    print("foto: "+uni.foto!)
                }
                let callb = self.callback as! (_ universidades:[Universidad])->Void
                callb([uni])
            }
        }catch{}
        */
        
        // emulacion
        let foto1 = UIImage(named: "ImageDefault")
        let univ1 = Universidad( nombre: "unicauca", descripcion: "universidad del cauca", foto: foto1)!
        universidades.append(univ1)
        
        let foto2 = UIImage(named: "ImageDefault")
        let univ2 = Universidad( nombre: "univalle", descripcion: "universidad del valle", foto: foto2)!
        universidades.append(univ2)
        
        let foto3 = UIImage(named: "ImageDefault")
        let univ3 = Universidad(nombre: "cooperativa de colombia", descripcion: "cooperativa de colombia", foto: foto3)!
        universidades.append(univ3)
        
        let foto4 = UIImage(named: "ImageDefault")
        let univ4 = Universidad(nombre: "unicanfacauca", descripcion: "unicanfacauca", foto: foto4)!
        universidades.append(univ4)
        
        let callb = self.callback as! (_ universidades:[Universidad])->Void
        callb(universidades)
        
    }
    
    func obtenruniversidades(callback:@escaping (_ universidades:[Universidad])->Void){
        
        let client:HttpClient = HttpClient()

        self.callback = callback
        client.get(url: "http://192.168.0.90:8081/universidad", callback: processUniversidades )
    }
}
