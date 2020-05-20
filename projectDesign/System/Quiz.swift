//
//  Quiz.swift
//  projectDesign
//
//  Created by Erick González on 22/04/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

class Quiz: NSObject,Codable, NSCoding {
    var questions : [Question]
    var currentQuestion : Int
    var correctCount : Int
    var incorrectCount : Int
    
    override init(){
        self.questions = [Question]()
        self.currentQuestion = 0
        self.correctCount = 0
        self.incorrectCount = 0
    }
    
    init(questions: [Question],currentQuestion: Int,correctCount: Int,incorrectCount: Int) {
        self.questions  = questions
        self.currentQuestion = currentQuestion
        self.correctCount = 0
        self.incorrectCount = 0
    }
    
    func appendQuestion(question: Question){
        self.questions.append(question)
    }
    

    required convenience init(coder aDecoder: NSCoder) {
        let questions = aDecoder.decodeObject(forKey: "questions") as! [Question]
        let currentQuestion = aDecoder.decodeInteger(forKey: "current")
        let correctCount = aDecoder.decodeInteger(forKey: "correcto")
        let incorrectCount = aDecoder.decodeInteger(forKey: "incorrecto")
        self.init(questions: questions,currentQuestion: currentQuestion,correctCount: correctCount,incorrectCount: incorrectCount)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(questions,forKey: "questions")
        coder.encode(currentQuestion,forKey: "current")
        coder.encode(correctCount,forKey: "correcto")
        coder.encode(incorrectCount,forKey: "incorrecto")
    }
    
    
}
