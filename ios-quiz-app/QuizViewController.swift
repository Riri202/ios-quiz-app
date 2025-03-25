//
//  QuizViewController.swift
//  ios-quiz-app
//
//  Created by Rita-Maria Oladokun on 2025-03-25.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet var answerButtons: [UIButton]!
    
    var quiz: Quiz?
    var currentQuestionIndex = 0
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        quiz = ((UIApplication.shared.delegate) as! AppDelegate).myModel
        // Do any additional setup after loading the view.
        
        updateUI()
    }
    
    func updateUI() {
        guard currentQuestionIndex < (quiz?.questions.count)! else {
            showCompletionAlert()
            return
        }
        
        let currentQuestion = quiz?.questions[currentQuestionIndex]
        questionLabel.text = currentQuestion?.question
        
        if let currentQuestion = currentQuestion {
            for (index, button) in answerButtons.enumerated() {
                if index < currentQuestion.answers.count {
                    button.setTitle(currentQuestion.answers[index].answer, for: .normal)
                    button.tag = index
                }
            }
        }

        progressBar.progress = Float(currentQuestionIndex + 1) / Float((quiz?.questions.count)!)
    }
    
    func showCompletionAlert() {
        let totalQuestions = (quiz?.questions.count)!
        let alert = UIAlertController(title: "Quiz Completed", message: "You scored \(score) out of \(totalQuestions) question(s)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.currentQuestionIndex = 0
            self.updateUI()
        })
        present(alert, animated: true)
    }
    
    
    @IBAction func answerSelected(_ sender: UIButton) {
        
        let currentQuestion = quiz?.questions[currentQuestionIndex]
        let selectedAnswer = currentQuestion?.answers[sender.tag]
        if let goodAnswer = selectedAnswer {
            if goodAnswer.isCorrectChoice {
                score += 1
                print("correct answer")
            } else {
                print("wrong answer")
            }
        }
        
        if currentQuestionIndex < (quiz?.questions.count)! - 1 {
            currentQuestionIndex += 1
            updateUI()
        } else {
            showCompletionAlert()
            score = 0
        }
    }
    
    
    
    
    
    
    
    
}












/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

