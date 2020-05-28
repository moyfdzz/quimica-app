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
        actualizaInterfaz()
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
            //questions = [Question(question: "CH3COOH", answer: "Acetic acid"), Question(question: "HCl", answer: "Hydrochloric acid")]
            questions = []
            quiz = Quiz(questions: questions, currentQuestion: 1, correctCount: 0, incorrectCount: 0)
            usuario = Usuario(nombre: "-", totalAciertos: 0, totalPreguntas: 0, nivel: 1, tipo: "Metales", quiz: quiz)
        }
    }
    
    func modificar(name: String) {
        self.usuario.nombre = name
    }
    func tipo(tipo: String) {
        self.usuario.tipo = tipo
        print(self.usuario.tipo)
    }
    func update(user: Usuario) {
        self.usuario = user
    }
    func getUser() -> Usuario {
        return self.usuario
    }
    
    //metodo para obtener el URL de un archivo de texto llamado Usuario.
    func dataFileUrl()-> URL {
           let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
           let pathArchivo = url.appendingPathComponent("Usuario.plist")
           return pathArchivo
    }
    
    //metodo para guardar la informacion en un archivo de texto
    @IBAction func guardarInfo(){
        do {
            let data = try PropertyListEncoder().encode(usuario)
            try data.write(to: dataFileUrl())
        }
        catch{
            print("Error al guardar los datos")
        }
    }
    
    //almacena en la variable usuario los contenidos del archivo de almacenamiento
    //o un error si no puede hacerlo.
    func obtenerInfo(){
            do {
                let data = try Data.init(contentsOf: dataFileUrl())
                usuario = try PropertyListDecoder().decode(Usuario.self, from: data)
            }
            catch{
                print("Error al cargar los datos")
                
            }
    }
    //actualiza las opciones de la aplicacion de acuerdo a las
    //configuraciones del usuario.
    func actualizaInterfaz() {
        let defaults = UserDefaults.standard
        
        MusicPlayer.shared.audioPlayer?.volume = UserDefaults.standard.value(forKey: "volumen") as! Float
        
        if defaults.bool(forKey: "musica") {
            MusicPlayer.shared.startBackgroundMusic()
        }
        /*
        if let user = UserDefaults.standard.data(forKey: "usuario"),
            let newUser = try? JSONDecoder().decode(Usuario.self, from: user) {
            usuario = newUser
        }
         */
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
            vistaSetup.delegadoPrimeraVista = self
        }
    }
    
    
    


}
