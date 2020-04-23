//
//  Question.swift
//  projectDesign
//
//  Created by Erick González on 22/04/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

class Question: NSObject {
    
    var question : String!
    var answer : String!
    
    override init(){
        self.question = "Not Given"
        self.answer = "Not Given"
    }
    
    init(question: String, answer: String){
        self.question = question
        self.answer = answer
    }
    
    func checkAnswer(input: String)->Bool{
        if ( input == self.answer){
            return true
        } else {
            return false
        }
    }
}
