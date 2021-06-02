//
//  ResultTableViewControllerDataSource.swift
//  Quiz
//
//  Created by Rushabh Singh on 01/06/21.
//

import UIKit

extension ResultTableViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.questions.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.questions.count > section{
            return  self.questions[section].questionText
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.questions.count > section{
            return  self.questions[section].options.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: RESULT_TABLE_VIEW_CELL_IDENTIFIER)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: RESULT_TABLE_VIEW_CELL_IDENTIFIER)
        }
        if indexPath.section < self.questions.count{
            let option = self.questions[indexPath.section].options[indexPath.row]
            cell?.textLabel!.text = option.text
            cell?.textLabel!.font = UIFont.boldSystemFont(ofSize: 14)
            cell?.textLabel?.textColor = UIColor.gray
            cell?.textLabel?.numberOfLines = 0
            let userAnswers = self.questions[indexPath.section].userAnswers
            let correctAnswers = self.questions[indexPath.section].correctAnswerIds
            if userAnswers.contains(option.id) {
                if correctAnswers.contains(option.id) {
                    cell?.textLabel?.textColor = UIColor.green
                }else{
                    cell?.textLabel?.textColor = UIColor.red
                }
            }
        }
        return cell!
    }
    
}

