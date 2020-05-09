//
//  FrontPageViewController.swift
//  projectDesign
//
//  Created by Erick González on 22/04/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

class FrontPageViewController: UIViewController,prococoloModificarUsuario,protocoloUsuario {
    
    @IBOutlet weak var btComenzar: UIButton!
    @IBOutlet weak var btEstadisticas: UIButton!
    @IBOutlet weak var btOpciones: UIButton!
    
    
    var usuario : Usuario!
    var quiz : Quiz!
    var questions : [Question]!
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Styles
        btComenzar.layer.cornerRadius = 10
        btComenzar.clipsToBounds = true
        
        btEstadisticas.layer.cornerRadius = 10

        btEstadisticas.clipsToBounds = true
        
        btOpciones.layer.cornerRadius = 10
        btOpciones.clipsToBounds = true
        
        //Verificar app
        let app = UIApplication.shared
         NotificationCenter.default.addObserver(self, selector: #selector(guardarInfo), name: UIApplication.didEnterBackgroundNotification, object: app)
        if FileManager.default.fileExists(atPath: dataFileUrl().path){
            obtenerInfo()
        } else {
            questions = [Question(question: "CH3COOH", answer: "Acetic acid"), Question(question: "HCl", answer: "Hydrochloric acid")]
            quiz = Quiz(questions: questions, currentQuestion: 1, correctCount: 0, incorrectCount: 0)
            usuario = Usuario(nombre: "-", totalAciertos: 0, totalPreguntas: 0, nivel: 1, tipo: "Metal", quiz: quiz)
        }
    }
    
    func modificar(name: String) {
        usuario.nombre = name
    }
    func update(user: Usuario) {
        usuario = user
    }
    
    
    func dataFileUrl()-> URL {
           let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
           let pathArchivo = url.appendingPathComponent("Usuario.plist")
           return pathArchivo
    }
    
    @IBAction func guardarInfo(){
        do {
            let data = try PropertyListEncoder().encode(usuario)
            try data.write(to: dataFileUrl())
        }
        catch{
            print("Error al guardar los datos")
        }
    }
    
    func obtenerInfo(){
            do {
                let data = try Data.init(contentsOf: dataFileUrl())
                usuario = try PropertyListDecoder().decode(Usuario.self, from: data)
            }
            catch{
                print("Error al cargar los datos")
                
            }
    }
    
    
        // Mark:- Navigation
    
    @IBAction func unwind (unwindSegue: UIStoryboardSegue) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "estadistica"{
         let vistaEstadisticas = segue.destination as! StatisticsViewController
            vistaEstadisticas.usuario = usuario
        } else if segue.identifier == "opciones" {
            let vistaOpciones = segue.destination as! OptionsViewController
            vistaOpciones.usuario = usuario
            vistaOpciones.delegado = self
        } else if segue.identifier == "setup"{
            let vistaSetup = segue.destination as! SetupViewController
            vistaSetup.usuario = usuario
            vistaSetup.delegado = self
        }
    }
    
    
    


}
