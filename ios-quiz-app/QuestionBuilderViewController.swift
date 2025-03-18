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

    @IBOutlet weak var questionText: UITextField!
    
    @IBOutlet weak var correctAnswer: UITextField!
    @IBOutlet weak var firstIncorrectAnswer: UITextField!
    @IBOutlet weak var secondIncorrectAnswer: UITextField!
    @IBOutlet weak var thirdIncorrectAnswer: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quiz = ((UIApplication.shared.delegate) as! AppDelegate).myModel
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addQuestionButton(_ sender: Any) {
        
        if let goodQuestion = questionText.text, let goodCorrectAnswer = correctAnswer.text, let goodFirstIncorrect = firstIncorrectAnswer.text, let goodSecondIncorrect = secondIncorrectAnswer.text, let goodThirdIncorrect = thirdIncorrectAnswer.text {
           
            let newQuestion = Question(
                question: goodQuestion,
                answers: [
                    Answer(answer: goodCorrectAnswer, isCorrectChoice: true),
                    Answer(answer: goodFirstIncorrect, isCorrectChoice: false),
                    Answer(answer: goodSecondIncorrect, isCorrectChoice: false),
                    Answer(answer: goodThirdIncorrect, isCorrectChoice: false)
                ]
            )
            delegate?.addingNewQuestionDidFinishWithResult(newQuestion: newQuestion)
            dismiss(animated: true, completion:nil)
            print((quiz?.questions.count)!)
        }
        
        
        
        
    }
    

}
