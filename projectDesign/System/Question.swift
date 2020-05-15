//
//  Question.swift
//  projectDesign
//
//  Created by Erick González on 22/04/20.
//  Copyright © 2020 Tecnologico de Monterrey. All rights reserved.
//

import UIKit

class Question: NSObject,Codable,NSCoding {
    
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
    
    required convenience init(coder aDecoder: NSCoder) {
        let question = aDecoder.decodeObject(forKey: "question") as! String
        let answer = aDecoder.decodeObject(forKey: "answer") as! String
        self.init(question: question, answer: answer)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.question,forKey: "question")
        coder.encode(self.answer,forKey: "answer")
    }
    
    
}
