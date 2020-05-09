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
    var delegado : protocoloUsuario!
    
    @IBOutlet weak var lbRetro: UILabel!
    @IBOutlet weak var lbCorregir: UILabel!
    @IBOutlet weak var lbCorreccion: UILabel!
    @IBOutlet weak var btContinuar: UIButton!
    @IBOutlet weak var lbAvance: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isCorrect {
            lbCorregir.alpha = 0
            lbCorreccion.alpha = 0
            lbRetro.text = "Correcto"
            lbRetro.textColor = UIColor.green
        } else {
            lbCorregir.alpha = 1
            lbCorreccion.alpha = 1
            lbRetro.text = "Incorrecto"
            lbRetro.textColor = UIColor.red
            let index = usuario.quiz.currentQuestion
            lbCorreccion.text = usuario.quiz.questions[index].answer
        }
        
        lbAvance.text = "\(usuario.quiz.currentQuestion+1)/\(usuario.quiz.questions.count)"
        //Styles
        btContinuar.layer.cornerRadius = 10
        btContinuar.clipsToBounds = true
        delegado = FrontPageViewController.self as? protocoloUsuario
    }
    


    @IBAction func regresarQuiz(_ sender: Any) {
        usuario.quiz.currentQuestion += 1;
        delegado.update(user: usuario)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        delegado.update(user: usuario)
    }
    

}
