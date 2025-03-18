//
//  QuestionModel.swift
//  ios-quiz-app
//
//  Created by Rita-Maria Oladokun on 2025-03-18.
//

import Foundation

class Question {
    var id: UUID
    var question: String
    var answers: [Answer]
    
    init(question: String, answers: [Answer]) {
        self.id = UUID()
        self.question = question
        self.answers = answers
    }
}

class Answer {
    var answer: String = ""
    var isCorrectChoice: Bool = false
    
    init(answer: String, isCorrectChoice: Bool) {
        self.answer = answer
        self.isCorrectChoice = isCorrectChoice
    }
}


var firstQuestion = Question(
    question: "What is my name?",
    answers: [
        Answer(answer: "Rita-Maria", isCorrectChoice: true),
        Answer(answer: "John", isCorrectChoice: false),
        Answer(answer: "Sarah", isCorrectChoice: false),
        Answer(answer: "Michael", isCorrectChoice: false)
    ]
)

class Quiz {

    var questions: [Question] = [firstQuestion]
    
    func addQuestion (question: Question ) {
        questions.append( question  )
    }
}
