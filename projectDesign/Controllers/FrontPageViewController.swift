//
//  FrontPageViewController.swift
//  projectDesign
//
//  Created by Erick González on 22/04/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

class FrontPageViewController: UIViewController {
    var usuario : Usuario!
    var timer = Timer()
    var tipoPreguntas : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwind (unwindSegue: UIStoryboardSegue) {
    }


}
