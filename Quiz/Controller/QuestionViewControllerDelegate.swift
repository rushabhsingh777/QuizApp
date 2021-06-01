//
//  QuestionViewControllerDelegate.swift
//  Quiz
//
//  Created by Rushabh Singh on 30/05/21.
//

import UIKit

extension QuestionViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let answerId = self.questions[currentIndex].options[indexPath.row].id
        var userAnswers : [Int] = self.questions[currentIndex].userAnswers
        let cell = tableView.cellForRow(at: indexPath)
        if (userAnswers.contains(answerId)){
            cell!.accessoryType = .none
            for (index,optionId) in userAnswers.enumerated(){
                if optionId == answerId{
                    userAnswers.remove(at: index)
                }
            }
        }else{
            cell!.accessoryType = .checkmark
            userAnswers.append(answerId)
        }
        self.questions[currentIndex].userAnswers = userAnswers
    }
    
    
}
