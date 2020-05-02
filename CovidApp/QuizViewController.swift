//
//  QuizViewController.swift
//  CovidApp
//
//  Created by Shane Lawson on 4/27/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import UIKit

class QuizViewController: UITableViewController {
   
   var tableSections: [QuizTableSection]!
   
   @IBOutlet var quizTableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let path = Bundle.main.path(forResource: "Quiz", ofType: "plist")!
      let data = FileManager.default.contents(atPath: path)!
      tableSections = try! PropertyListDecoder().decode([QuizTableSection].self, from: data)
   }
   
   // MARK: - UITableViewDataSource
   
   override func numberOfSections(in tableView: UITableView) -> Int {
      return tableSections.count
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tableSections[section].choices.count + 1
   }
   
   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return "Question \(section+1)"
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let tableCellData = tableSections[indexPath.section]
      var cell: UITableViewCell
      if indexPath.row == 0 {
         cell = tableView.dequeueReusableCell(withIdentifier: "quizQuestionCell")!
         cell.textLabel?.numberOfLines = 0
         cell.textLabel?.font = .systemFont(ofSize: UIFont.systemFontSize * 1.3)
         cell.textLabel?.text = tableCellData.question
      } else {
         cell = tableView.dequeueReusableCell(withIdentifier: "quizQuestionChoiceCell")!
         cell.textLabel?.numberOfLines = 0
         cell.textLabel?.attributedText = NSMutableAttributedString(string: tableCellData.choices[indexPath.row - 1])
         cell.imageView?.image = UIImage(systemName: "circle")
         cell.imageView?.tintColor = .darkText
      }
      return cell
   }
   
   // MARK: - UITableViewDelegate
   
   override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
      if indexPath.row == 0 {
         return nil
      } else {
         return indexPath
      }
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      if let cell = tableView.cellForRow(at: indexPath) {
         let cellData = tableSections[indexPath.section]
         if cellData.correctIndex == indexPath.row - 1 {
            //correct
            cell.imageView?.image = UIImage(systemName: "checkmark.circle.fill")
            cell.imageView?.tintColor = .systemGreen
            let attrString = cell.textLabel?.attributedText
            cell.textLabel?.attributedText = NSAttributedString(string: attrString!.string, attributes: [
               .foregroundColor: UIColor.systemGreen,
            ])
            //select all other options to mark them incorrect
            for i in 1...cellData.choices.count {
               let indPath = IndexPath(row: i, section: indexPath.section)
               if indPath != indexPath {
                  quizTableView.delegate?.tableView?(tableView, didSelectRowAt: indPath)
               }
            }
         } else {
            //incorrect
            cell.imageView?.image = UIImage(systemName: "xmark.circle.fill")
            cell.imageView?.tintColor = .systemRed
            let attrString = cell.textLabel?.attributedText
            cell.textLabel?.attributedText = NSAttributedString(string: attrString!.string, attributes: [
               .foregroundColor: UIColor.systemRed,
               .strikethroughStyle: 1
            ])
         }
      }
   }
}

