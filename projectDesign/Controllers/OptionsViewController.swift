//
//  OptionsViewController.swift
//  projectDesign
//
//  Created by Erick González on 22/04/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

protocol prococoloModificarUsuario {
    func modificar(name: String) -> Void
    func tipo(tipo: String) ->Void
}

class OptionsViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var sliderVolumen: UISlider!
    @IBOutlet weak var swMusica: UISwitch!
    @IBOutlet weak var tfUsuario: UITextField!
    @IBOutlet weak var pvPickerView: UIPickerView!
    @IBOutlet weak var pvTipo: UIPickerView!
    @IBOutlet weak var btMenu: UIButton!
    var tiposPreguntas = ["Metales","Ácidos","Compuestos Ionicos","Compuestos Moleculares"]
    var usuario : Usuario!
    var delegado : prococoloModificarUsuario!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load Style
        btMenu.layer.cornerRadius = 10
        btMenu.clipsToBounds = true
        
        //Load User defaults
        let defaults = UserDefaults.standard
        tfUsuario.text = usuario.nombre
        sliderVolumen.value = defaults.float(forKey: "volumen")
        swMusica.isOn = defaults.bool(forKey: "musica")
        let index = defaults.integer(forKey: "tipo")
        pvPickerView.selectRow(index, inComponent: 0, animated: true)
    }
    
    
    @IBAction func switchMusic(_ sender: Any) {
        //Stop or reproduce Player
        if swMusica.isOn {
            MusicPlayer.shared.startBackgroundMusic()
        }
        else {
            MusicPlayer.shared.stopBackgroundMusic()
        }
        
        UserDefaults.standard.set(swMusica.isOn, forKey: "musica")
    }
    
    @IBAction func setVolume(_ sender: UISlider) {
        MusicPlayer.shared.audioPlayer?.volume = sliderVolumen.value
        UserDefaults.standard.set(sliderVolumen.value, forKey: "volumen")
    }

    @IBAction func quitaTeclado(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tfUsuario.text == "" {
            let alert = UIAlertController(title: "Error", message: "Añadir un nombre de usuario.", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(accion)
            present(alert,animated: true,completion: nil)
            return false
        } else{
            delegado.modificar(name: tfUsuario.text!)
            return true
    }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let defaults = UserDefaults.standard
        
        defaults.set(sliderVolumen.value,forKey:"volumen")
        defaults.set(swMusica.isOn,forKey: "musica")
        defaults.set(tfUsuario.text,forKey:"nombre")
        defaults.set(pvPickerView.selectedRow(inComponent: 0) ,forKey:"tipo")
        let vistaInicial = segue.destination as! FrontPageViewController
        let index = pvTipo.selectedRow(inComponent: 0)
        delegado.tipo(tipo: tiposPreguntas[index])
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
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        label.font = UIFont (name: "Helvetica Neue", size: 20)
        label.text =  tiposPreguntas[row]
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.80)
        return label
    }
}
