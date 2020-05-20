//
//  Usuario.swift
//  projectDesign
//
//  Created by Erick González on 22/04/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

class Usuario: NSObject,Codable,NSCoding {
    var nombre : String
    var totalAciertos : Int
    var totalPreguntas : Int
    var nivel : Int
    var tipo : String = ""
    var quiz : Quiz
    
    init(nombre: String, totalAciertos: Int, totalPreguntas: Int, nivel: Int, tipo: String, quiz: Quiz) {
        self.nombre = nombre
        self.totalAciertos = totalAciertos
        self.totalPreguntas = totalPreguntas
        self.nivel = nivel
        self.tipo = tipo
        self.quiz = quiz
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
        self.quiz = newUser.quiz
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let nombre = aDecoder.decodeObject(forKey: "nombre") as! String
        let totalAciertos = aDecoder.decodeInteger(forKey: "aciertos")
        let totalPreguntas = aDecoder.decodeInteger(forKey: "preguntas")
        let nivel = aDecoder.decodeInteger(forKey: "nivel")
        let tipo = aDecoder.decodeObject(forKey: "tipo") as! String
        let quiz = aDecoder.decodeObject(forKey: "quiz") as! Quiz
        
        self.init(nombre: nombre, totalAciertos: totalAciertos, totalPreguntas: totalPreguntas, nivel: nivel, tipo: tipo, quiz: quiz)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(nombre,forKey: "nombre")
        coder.encode(totalAciertos,forKey: "aciertos")
        coder.encode(totalAciertos,forKey: "preguntas")
        coder.encode(nivel,forKey: "nivel")
        coder.encode(tipo,forKey: "tipo")
        coder.encode(quiz,forKey: "quiz")
    }
    
    
}
