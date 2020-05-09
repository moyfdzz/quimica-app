//
//  Quiz.swift
//  projectDesign
//
//  Created by Erick González on 22/04/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

class Quiz: NSObject,Codable {
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
    
    func verify(index: Int, input: String) -> Bool{
        let isCorrect = questions[index].answer == input
        
        if isCorrect {
            self.correctCount += 1;
        } else {
            self.incorrectCount += 1;
        }
        return isCorrect
    }
    
}
