//
//  TriviaViewController.swift
//  projectDesign
//
//  Created by Erick González on 08/05/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

class TriviaViewController: UIViewController {

    var usuario : Usuario!
    var isCorrect: Bool!
    
    var delegadoPrimeraVista: protocoloUsuario!
    
    @IBOutlet weak var btContinuar: UIButton!
    @IBOutlet weak var lbAvance: UILabel!
    @IBOutlet weak var tfRespuesta: UITextField!
    @IBOutlet weak var lbPregunta: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Style
        usuario = delegadoPrimeraVista.getUser()
        btContinuar.layer.cornerRadius = 10
        btContinuar.clipsToBounds = true
        
        //Initialize is Correct
        isCorrect = false
        lbAvance.text = "\(usuario.quiz.currentQuestion+1)/\(usuario.quiz.questions.count)"
        let index = usuario.quiz.currentQuestion
        lbPregunta.text = usuario.quiz.questions[index].question
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        usuario = delegadoPrimeraVista.getUser()
        isCorrect = false
        tfRespuesta.text = ""
        lbAvance.text = "\(usuario.quiz.currentQuestion+1)/\(usuario.quiz.questions.count)"
        let index = usuario.quiz.currentQuestion
        
        if index >= usuario.quiz.questions.count{
            lbPregunta.text = ""
        } else {
            let q = usuario.quiz.questions[index].question
            let subs = getSuperscript(compund: q!)
            lbPregunta.setAttributedTextWithSubscripts(text: q!, indicesOfSubscripts: subs)
        }
        
        
        
        
        
    }
    
    
    @IBAction func terminarEdicion(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "verificar"{
         let vistaVerificar = segue.destination as! VerificarViewController
        vistaVerificar.usuario = delegadoPrimeraVista.getUser()
            vistaVerificar.isCorrect = isCorrect
            vistaVerificar.delegadoPrimeraVista = delegadoPrimeraVista
        }
        
    }
    //Metodo que hace las respuestas del usuario sin acentos o con acentos erroneos validas. Esto lo hace al reemplazar todas las instancias de vocales con acentos tanto en la respuesta como en la pregunta con vocales sin acento.
    func accentCheck(answer: String, input : String) -> Bool{
            
        let newAnswer = answer.replacingOccurrences(of: "á", with: "a").replacingOccurrences(of: "é", with: "e").replacingOccurrences(of: "í", with: "i").replacingOccurrences(of: "ó", with: "o").replacingOccurrences(of: "ú", with: "u")
        
        let newInput = input.replacingOccurrences(of: "á", with: "a").replacingOccurrences(of: "é", with: "e").replacingOccurrences(of: "í", with: "i").replacingOccurrences(of: "ó", with: "o").replacingOccurrences(of: "ú", with: "u")
     
        return newAnswer == newInput
    }
    
    //Metodo que checa si la respuesta del usuario es correcta
    func verify(index: Int, input: String) -> Bool{
        let isCorrect = accentCheck(answer: usuario.quiz.questions[index].answer.lowercased(), input: input.lowercased())
        
        //si es correcta, se le suma a su total de aciertos.
        //si no, a su total de preguntas falladas.
        if isCorrect {
            usuario.quiz.correctCount += 1;
            usuario.totalAciertos += 1;
        } else {
            usuario.quiz.incorrectCount += 1;
        }
        usuario.totalPreguntas += 1;
        delegadoPrimeraVista.update(user: usuario)
        return isCorrect
    }
    //metodo de verificacion antes de continuar por el segue del boton de continuar.
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        //si no hay respuesta, muestra un error.
        if tfRespuesta.text == "" {
            let alert = UIAlertController(title: "Error", message: "Añadir un valor al campo.", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(accion)
            present(alert,animated: true,completion: nil)
            return false
        } else{
            //verifica la respuesta
        isCorrect = verify(index: usuario.quiz.currentQuestion, input: tfRespuesta.text!)
        delegadoPrimeraVista.update(user: usuario)
            return true
    }
        
    }
    
    func getSuperscript(compund: String) -> [Int]{
        var subs = [Int]()
        
        for (n,c) in compund.enumerated() {
            if(c.isASCII && c.isNumber){
                subs.append(n)
            }
        }
        print(subs)
        return subs
    }

}
