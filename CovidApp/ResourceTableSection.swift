//
//  ResourcesTableSection.swift
//  CovidApp
//
//  Created by Shane Lawson on 4/27/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import Foundation

struct ResourceTableSection: Codable {
   let title: String
   let items: [TableCellData]
   
   enum CodingKeys: String, CodingKey {
      case title = "Title"
      case items
   }
}
