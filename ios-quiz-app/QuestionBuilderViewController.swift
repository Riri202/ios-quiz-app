//
//  QuestionBuilderViewController.swift
//  ios-quiz-app
//
//  Created by Rita-Maria Oladokun on 2025-03-18.
//

import UIKit

class QuestionBuilderViewController: UIViewController {
    var delegate: AddingNewQuestionDelegate?
    
    var quiz: Quiz?
    var editingQuestion: Question?  // If set, we are editing an existing question
    var editingIndex: Int?          // Track index of question being edited
    
    @IBOutlet weak var questionText: UITextField!
    @IBOutlet weak var correctAnswer: UITextField!
    @IBOutlet weak var firstIncorrectAnswer: UITextField!
    @IBOutlet weak var secondIncorrectAnswer: UITextField!
    @IBOutlet weak var thirdIncorrectAnswer: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quiz = ((UIApplication.shared.delegate) as! AppDelegate).myModel
        
        // Pre-fill fields if editing a question
        if let questionToEdit = editingQuestion {
            questionText.text = questionToEdit.question
            
            let answers = questionToEdit.answers
            if answers.count >= 4 {
                correctAnswer.text = answers[0].answer
                firstIncorrectAnswer.text = answers[1].answer
                secondIncorrectAnswer.text = answers[2].answer
                thirdIncorrectAnswer.text = answers[3].answer
            }
        }
    }
    
    @IBAction func addQuestionButton(_ sender: Any) {
        guard let goodQuestion = questionText.text, !goodQuestion.isEmpty,
              let goodCorrectAnswer = correctAnswer.text, !goodCorrectAnswer.isEmpty,
              let goodFirstIncorrect = firstIncorrectAnswer.text, !goodFirstIncorrect.isEmpty,
              let goodSecondIncorrect = secondIncorrectAnswer.text, !goodSecondIncorrect.isEmpty,
              let goodThirdIncorrect = thirdIncorrectAnswer.text, !goodThirdIncorrect.isEmpty else {
            print("Error: All fields must be filled.")
            return
        }
        
        let newQuestion = Question(
            question: goodQuestion,
            answers: [
                Answer(answer: goodCorrectAnswer, isCorrectChoice: true),
                Answer(answer: goodFirstIncorrect, isCorrectChoice: false),
                Answer(answer: goodSecondIncorrect, isCorrectChoice: false),
                Answer(answer: goodThirdIncorrect, isCorrectChoice: false)
            ]
        )
        
        if let index = editingIndex {
            // Editing existing question
            quiz?.questions[index] = newQuestion
            delegate?.editingQuestionDidFinish()
        } else {
            // Adding new question
            delegate?.addingNewQuestionDidFinishWithResult(newQuestion: newQuestion)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    
}
