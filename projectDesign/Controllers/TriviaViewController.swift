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
    var isCorrect: Bool
    @IBOutlet weak var btContinuar: UIButton!
    @IBOutlet weak var lbAvance: UILabel!
    @IBOutlet weak var tfRespuesta: UITextField!
    @IBOutlet weak var lbPregunta: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Style
        btContinuar.layer.cornerRadius = 10
        btContinuar.clipsToBounds = true
        //Initialize is Correct
        isCorrect = false
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "verificar"{
         let vistaVerificar = segue.destination as! TriviaViewController
            vistaVerificar.usuario = usuario
        vistaVerificar.isCorrect = isCorrect
        }
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tfRespuesta.text == "" {
            let alert = UIAlertController(title: "Error", message: "Añadir un nombre de usuario.", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(accion)
            present(alert,animated: true,completion: nil)
            return false
        } else{
        isCorrect = usuario.quiz.verify(index: usuario.quiz.currentQuestion, input: tfRespuesta.text!)
            return true
    }
    }
    

}
