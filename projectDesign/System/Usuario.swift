//
//  Usuario.swift
//  projectDesign
//
//  Created by Erick González on 22/04/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

class Usuario: NSObject {
    var nombre : String
    var totalAciertos : Int
    var totalPreguntas : Int
    var nivel : Int
    var tipo : String = ""
    
    init(nombre: String, totalAciertos: Int, totalPreguntas: Int, nivel: Int, tipo: String) {
        self.nombre = nombre
        self.totalAciertos = totalAciertos
        self.totalPreguntas = totalPreguntas
        self.nivel = nivel
        self.tipo = tipo
    }
    func update(newUser: Usuario)->Void{
        self.nombre = newUser.nombre
        self.totalAciertos = newUser.totalAciertos
        self.totalPreguntas = newUser.totalPreguntas
        self.tipo = newUser.tipo
        if(Int(Double(newUser.totalAciertos)/10.0) <= 100){
            self.nivel = Int(Double(newUser.totalAciertos)/10.0)
        } else {
            self.nivel = 100
        }
    }
}
