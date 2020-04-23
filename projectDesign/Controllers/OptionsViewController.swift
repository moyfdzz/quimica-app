//
//  OptionsViewController.swift
//  projectDesign
//
//  Created by Erick González on 22/04/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var tiposPreguntas = ["Metales","Acidos"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchMusic(_ sender: Any) {
    }

    @IBOutlet weak var pvTipo: UIPickerView!
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vistaInicial = segue.destination as! FrontPageViewController
        let index = pvTipo.selectedRow(inComponent: 0)
        vistaInicial.tipoPreguntas = tiposPreguntas[index]
    }
    
    
    // MARK: -UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        tiposPreguntas.count
    }
    // MARK: -UIPickerViewDelegate
     func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(_ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int) -> String? {

            // Return a string from the array for this row.
            return tiposPreguntas[row]
    }
}
