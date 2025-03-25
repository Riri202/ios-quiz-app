//
//  QuestionBankViewController.swift
//  ios-quiz-app
//
//  Created by Rita-Maria Oladokun on 2025-03-18.
//

import UIKit

protocol AddingNewQuestionDelegate {
    func addingNewQuestionDidFinishWithResult(newQuestion: Question)
    func addingNewQuestionDidCancel()
    
    func editingQuestionDidFinish()
}

class QuestionBankViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, AddingNewQuestionDelegate {
   
    
    
    var quiz: Quiz?;
    @IBOutlet weak var questionsTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        quiz = ((UIApplication.shared.delegate) as! AppDelegate).myModel
        questionsTable.dataSource = self
        questionsTable.delegate = self
        // Do any additional setup after loading the view.
    }
    
// custom delegate
    
    func addingNewQuestionDidFinishWithResult(newQuestion:Question) {
        quiz?.addQuestion(question: newQuestion)

        DispatchQueue.main.async {
            self.questionsTable.reloadData()
        }
    }
    
    func addingNewQuestionDidCancel() {
        print("User cancelled adding a new question.")

    }
    
    func editingQuestionDidFinish() {
        DispatchQueue.main.async {
            self.questionsTable.reloadData()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return (quiz?.questions.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        
        if let goodQuestion = quiz?.questions[indexPath.row] {
            cell.textLabel?.text = "\(goodQuestion.question)"
            
            let answersText = goodQuestion.answers.map {
                answer in let prefix = answer.isCorrectChoice ? "Correct: " : "Incorrect: "
                return "\(prefix) \(answer.answer)"
            }.joined(separator: "\n");
            
            cell.detailTextLabel?.text = answersText
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.lineBreakMode = .byWordWrapping
            return cell
        }
        return UITableViewCell()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "questionBuilder",
           let addQuestionVC = segue.destination as? QuestionBuilderViewController {
            addQuestionVC.delegate = self

            // Check if sender is a table cell (meaning the user selected a question to edit)
            if let cell = sender as? UITableViewCell,
               let indexPath = questionsTable.indexPath(for: cell) {
                // Editing a question
                addQuestionVC.editingQuestion = quiz?.questions[indexPath.row]
                addQuestionVC.editingIndex = indexPath.row
            } else {
                // Adding a new question, Ensure the form is empty
                addQuestionVC.editingQuestion = nil
                addQuestionVC.editingIndex = nil
            }
        }
    }


    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "questionBuilder", sender: cell)
    }

    
    
}
