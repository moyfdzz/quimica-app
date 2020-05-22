//
//  VerificarViewController.swift
//  projectDesign
//
//  Created by Erick González on 08/05/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

class VerificarViewController: UIViewController {
    
    var usuario : Usuario!
    var isCorrect : Bool!
    var delegadoPrimeraVista : protocoloUsuario!
    
    @IBOutlet weak var lbAvanceFijo: UILabel!
    @IBOutlet weak var lbRetro: UILabel!
    @IBOutlet weak var lbCorregir: UILabel!
    @IBOutlet weak var lbCorreccion: UILabel!
    @IBOutlet weak var btContinuar: UIButton!
    @IBOutlet weak var lbAvance: UILabel!
    @IBOutlet weak var lbCorrecto: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styles
        btContinuar.layer.cornerRadius = 10
        btContinuar.clipsToBounds = true
        
        if (usuario.quiz.currentQuestion + 1) == usuario.quiz.questions.count{
            btContinuar.setTitle("Finalizar", for: .normal)
        } else {
            btContinuar.setTitle("Continuar", for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        usuario = delegadoPrimeraVista.getUser()
        
         if isCorrect {
                   lbCorregir.alpha = 0
                   lbCorreccion.alpha = 0
                   lbAvanceFijo.alpha = 1
                   lbAvanceFijo.text = "Avance"
                   lbRetro.text = "Correcto"
                   lbRetro.textColor = UIColor.green
               } else {
                   lbCorregir.alpha = 1
                   lbCorreccion.alpha = 1
                   lbAvanceFijo.alpha = 1
                   lbAvanceFijo.text = "Avance"
                   lbCorregir.text = "La respuesta correcta era: "
                   lbRetro.text = "Incorrecto"
                   lbRetro.textColor = UIColor.red
                   let index = usuario.quiz.currentQuestion
                   let a = usuario.quiz.questions[index].answer
                   let subs = getSuperscript(compund: a!)
                   lbCorreccion.setAttributedTextWithSubscripts(text: a!, indicesOfSubscripts: subs)
               }
               lbAvance.text = "\(usuario.quiz.currentQuestion+1)/\(usuario.quiz.questions.count)"
        lbCorrecto.text = String(Float (Double (usuario.quiz.correctCount) / Double ((usuario.quiz.currentQuestion+1))*100)) + "%"
    }
        
    @IBAction func regresarQuiz(_ sender: Any) {
        
        if usuario.quiz.currentQuestion == usuario.quiz.questions.count {
        } else {
            usuario.quiz.currentQuestion += 1;
            delegadoPrimeraVista.update(user: usuario)
            if usuario.quiz.currentQuestion == usuario.quiz.questions.count{
                delegadoPrimeraVista.update(user: usuario)
                presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            } else {
            dismiss(animated: true, completion: nil)
            }
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

 
