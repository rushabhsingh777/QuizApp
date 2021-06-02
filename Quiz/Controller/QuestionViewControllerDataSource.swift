//
//  QuestionViewControllerDataSource.swift
//  Quiz
//
//  Created by Rushabh Singh on 30/05/21.
//

import UIKit

extension QuestionViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.questions.count > currentIndex{
            return  self.questions[currentIndex].options.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: QUESTION_TABLE_VIEW_CELL_IDENTIFIER)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: QUESTION_TABLE_VIEW_CELL_IDENTIFIER)
        }
        if currentIndex < self.questions.count {
            let option = self.questions[currentIndex].options[indexPath.row].text
            cell?.textLabel!.text = option
        }
        cell!.accessoryType = .none
        cell?.textLabel?.numberOfLines = 0
        
        return cell!
    }
    
}
