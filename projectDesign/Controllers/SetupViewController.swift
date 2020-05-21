//
//  SetupViewController.swift
//  projectDesign
//
//  Created by Erick González on 08/05/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit
protocol protocoloUsuario {
    func update(user: Usuario)->Void
    func getUser() -> Usuario
}

class SetupViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    var options : [Int]!

    @IBOutlet weak var btEmpezar: UIButton!
    @IBOutlet weak var pvPickerView: UIPickerView!
    @IBOutlet weak var scSegment: UISegmentedControl!
    var usuario : Usuario!
    var delegadoPrimeraVista : protocoloUsuario!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usuario = delegadoPrimeraVista.getUser()
        // Do any additional setup after loading the view.
        btEmpezar.layer.cornerRadius = 10
        btEmpezar.clipsToBounds = true
        options = Array(1...20)
        numberQuestions = 0
    }

    // MARK: -UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        options.count
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
        label.text =  String(options[row])
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.80)
        return label
    }
    
    // Sacar una pregunta
    var askedQuestions: Set<Question> = []
    var question: Question!
    var numberQuestions: Int!

    func getQuestion(questions: [Question]) -> Question {
        repeat {
            question = questions.randomElement()!
        } while askedQuestions.contains(question)

        askedQuestions.insert(question)
        
        return question
    }
    
    func castToArrray(questions: [NSDictionary]) -> [Question] {
        var questionsArray: [Question]! = []
        
        for i in questions {
            questionsArray.append(Question(question: i["Nombre"] as! String, answer: i["Formula"] as! String))
        }
        
        return questionsArray
    }
    
    // Extracciòn de datos de archivo JSON
    func extractData(category: String) -> Question {
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try? JSONSerialization.jsonObject(with: data)
                if let jsonResult = jsonResult as? [String: Any] {
                    if let questions = jsonResult[category] {
                        let questionsArray: [Question]! = castToArrray(questions: questions as! [NSDictionary])
                        question = getQuestion(questions: questionsArray)
                    }
                }
            } catch {
                print("Unexpected error: \(error).")
            }
        }
        
        if question != nil {
            return question
        }
        else {
            return Question(question: "", answer: "")
        }
    }
    @IBAction func empezarCuestionario(_ sender: Any) {
        let index = pvPickerView.selectedRow(inComponent: 0)
        numberQuestions = options[index] - 1
        usuario.quiz.questions = []
        usuario.quiz.correctCount = 0
        usuario.quiz.incorrectCount = 0
        
        if scSegment.titleForSegment(at: scSegment.selectedSegmentIndex) == "Nombre" {
            for _ in 0...numberQuestions {
                let q : Question! = extractData(category: usuario.tipo)
                usuario.quiz.appendQuestion(question: Question(question: q.question, answer: q.answer))
            }
        } else {
            for _ in 0...numberQuestions {
                let q : Question! = extractData(category: usuario.tipo)
                usuario.quiz.appendQuestion(question: Question(question: q.answer, answer: q.question))
            }
        }
        
        numberQuestions = 0
        usuario.quiz.currentQuestion = 0
        delegadoPrimeraVista.update(user: usuario)
    }
    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trivia"{
         let vistaTrivia = segue.destination as! TriviaViewController
            vistaTrivia.usuario = usuario
            vistaTrivia.delegadoPrimeraVista = delegadoPrimeraVista
        }
    }

}
