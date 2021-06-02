//
//  ResultTableViewController.swift
//  Quiz
//
//  Created by Rushabh Singh on 30/05/21.
//

import UIKit

class ResultTableViewController: UIViewController {
    
    let RESULT_TITLE = "Result"
    let RESULT_TABLE_VIEW_CELL_IDENTIFIER = "ResultTableViewCellIdentifier"
    var questions = [QuestionsDataModel]()
    
    @IBOutlet weak var resultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItem()
        self.setUpTableView()
    }
    
    private func setUpNavigationItem(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Restart", style: .done, target: self, action: #selector(RestartQuiz))
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = RESULT_TITLE
    }
    
    @objc func RestartQuiz(sender: UIBarButtonItem) {
        DispatchQueue.main.async {
            if let questionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuestionViewControllerIdentifier") as? QuestionViewController {
                self.navigationController?.pushViewController(questionVC, animated: true)
                self.navigationController?.viewControllers.remove(at: 0)
            }
        }
    }
    
    private func setUpTableView() {
        resultTableView.dataSource = self
    }
    
}
