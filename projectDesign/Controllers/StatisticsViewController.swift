//
//  StatisticsViewController.swift
//  projectDesign
//
//  Created by Erick González on 22/04/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {


    
    @IBOutlet weak var pvNivel: UIProgressView!
    @IBOutlet weak var lbNivel: UILabel!
    @IBOutlet weak var lbAciertos: UILabel!
    @IBOutlet weak var lbTotalPreguntas: UILabel!
    @IBOutlet weak var lbUsuario: UILabel!
    @IBOutlet weak var btMenu: UIButton!
    
    
    var usuario : Usuario!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Carga los estilos
        btMenu.layer.cornerRadius = 10
        btMenu.clipsToBounds = true
        //Carga los datos a mostrar en Estadísticas
        lbAciertos.text = String(usuario.totalAciertos)
        lbTotalPreguntas.text = String(usuario.totalPreguntas)
        lbNivel.text = String(usuario.nivel)
        pvNivel.progress = Float(Double(usuario.nivel)/100.0)
        lbUsuario.text = usuario.nombre
    }
    

}
