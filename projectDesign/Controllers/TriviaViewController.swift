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
        lbAvance.text = "\(usuario.quiz.currentQuestion+1)/\(usuario.quiz.questions.count)"
        let index = usuario.quiz.currentQuestion
        
        if index >= usuario.quiz.questions.count{
            lbPregunta.text = ""
        } else {
        lbPregunta.text = usuario.quiz.questions[index].question
        }
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
    func verify(index: Int, input: String) -> Bool{
        let isCorrect = usuario.quiz.questions[index].answer.lowercased() == input.lowercased()
        
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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if tfRespuesta.text == "" {
            let alert = UIAlertController(title: "Error", message: "Añadir un valor al campo.", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(accion)
            present(alert,animated: true,completion: nil)
            return false
        } else{
        isCorrect = verify(index: usuario.quiz.currentQuestion, input: tfRespuesta.text!)
        delegadoPrimeraVista.update(user: usuario)
            return true
    }
        
    }
    

}
