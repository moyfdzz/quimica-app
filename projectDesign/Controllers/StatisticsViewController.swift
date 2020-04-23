//
//  StatisticsViewController.swift
//  projectDesign
//
//  Created by Erick González on 22/04/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {


    
    @IBOutlet weak var tfNombreUsuario: UITextField!
    @IBOutlet weak var pvNivel: UIProgressView!
    @IBOutlet weak var lbNivel: UILabel!
    @IBOutlet weak var lbAciertos: UILabel!
    @IBOutlet weak var lbTotalPreguntas: UILabel!

    
    
    
    @IBAction func quitaTeclado(_ sender: Any) {
        view.endEditing(true)
    }
    
    var usuario : Usuario!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Carga los datos a mostrar en Estadísticas
        tfNombreUsuario.text = usuario.nombre
        lbAciertos.text = String(usuario.totalAciertos)
        lbTotalPreguntas.text = String(usuario.totalPreguntas)
        pvNivel.progress = Float(Double(usuario.nivel)/100.0)
    }
    
     
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tfNombreUsuario.text == nil {
            let alert = UIAlertController(title: "Error", message: "Añadir un nombre de usuario.", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(accion)
            present(alert,animated: true,completion: nil)
            return false
        } else{
            return true
    }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vistaInicial = segue.destination as! FrontPageViewController
        vistaInicial.usuario = usuario
    }

}
