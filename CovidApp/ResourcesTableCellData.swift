//
//  ResourcesTableCellData.swift
//  CovidApp
//
//  Created by Shane Lawson on 4/27/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import Foundation

struct ResourcesTableCellData: Codable {
   let title: String
   let url: String
   
   enum CodingKeys: String, CodingKey {
      case title = "Title"
      case url = "URL"
   }
}
