//
//  QuizTableSection.swift
//  CovidApp
//
//  Created by Shane Lawson on 5/1/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import Foundation

struct QuizTableSection: Codable {
   let question: String
   let correctIndex: Int
   let choices: [String]
   
   enum CodingKeys: String, CodingKey {
      case question = "Question"
      case correctIndex = "correct answer"
      case choices
   }
}
