//
//  ResourcesViewController.swift
//  CovidApp
//
//  Created by Shane Lawson on 4/27/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import UIKit
import SafariServices

class ResourcesViewController: UITableViewController {

   var tableSections: [TableSection]!
   
   override func viewDidLoad() {
      super.viewDidLoad()

      let path = Bundle.main.path(forResource: "Resources", ofType: "plist")!
      let data = FileManager.default.contents(atPath: path)!
      tableSections = try! PropertyListDecoder().decode([TableSection].self, from: data)
   }
   
   // MARK: - UITableViewDataSource
   
   override func numberOfSections(in tableView: UITableView) -> Int {
      return tableSections.count
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tableSections[section].items.count
   }
   
   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return tableSections[section].title
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let tableCellData = tableSections[indexPath.section].items[indexPath.row]
      let cell = tableView.dequeueReusableCell(withIdentifier: "resourceCell")!
      cell.textLabel?.text = tableCellData.title
      cell.detailTextLabel?.text = URL(string: tableCellData.url)?.host
      cell.detailTextLabel?.textColor = .systemGray
      return cell
   }
   
   // MARK: - UITableViewDelegate
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let tableCellData = tableSections[indexPath.section].items[indexPath.row]
      let url = URL(string: tableCellData.url)!
      let safariVC = SFSafariViewController(url: url)
      safariVC.dismissButtonStyle = .close
      present(safariVC, animated: true, completion: { [unowned self] in
         self.tableView.deselectRow(at: indexPath, animated: true)
      })
   }
}
