//
//  ViewController.swift
//  Pickup
//
//  Created by 高本直矢 on 2022/06/08.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct ItemJson: Codable {
        let id: Int?
        let name: String?
        let category_id: Int?
        let quantity: Int?
        let order_point: Int?
        let store: String?
        let location: String?
        let unit: String?
        let remarks: String?
    }
    
    struct ResultJson: Codable {
        let data:[ItemJson]?
    }
    
    let env = ProcessInfo.processInfo.environment
    
    
    @IBSegueAction func swiftUISegueButton(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView())
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var itemList : [(id: Int, name: String, quantity: Int)] = [] {
            didSet{
                tableView.reloadData()
            }
    }
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getTable()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
    }
    
    
    func getTable(){
        guard let req_url = URL(string: "https://pickup-37875.herokuapp.com/api/v1/items_api") else {
            return
        }
        
        let apiUsername = env["BASIC_AUTH_USER"]
        let apiPassword = env["BASIC_AUTH_PASS"]
        
        let authString = String(format: "%@:%@", apiUsername!, apiPassword!)
        let authData = authString.data(using: String.Encoding.utf8)!
        let authBase64 = authData.base64EncodedString()
        
        
        var req = URLRequest(url: req_url)
        
        req.setValue("Basic \(authBase64)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: req, completionHandler: {
            (data , response , error) in
            session.finishTasksAndInvalidate()
            
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                if let items = json.data {
                    for item in items {
                        if let id = item.id, let name = item.name, let quantity = item.quantity {
                            let bihin = (id, name, quantity)
                            self.itemList.append(bihin)
                        }
                    }
                   
                   
                    
                }
            } catch {
                print("エラーが出ました")
            }
        })
        
        task.resume()
    }
    
  
    
    //Cellの総数を返すdatasourceメソッド、必ず記述する必要がある。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    //Cellに値を設定するdatasourceメソッド、必ず記述する必要がある。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for:indexPath)
        cell.textLabel?.text = "\(String(describing: itemList[indexPath.row].id) )  \(itemList[indexPath.row].name)            \(itemList[indexPath.row].quantity)"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSague" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let destination = segue.destination as? DetailViewController else {
                    fatalError("Failed to prepare DetailViewController")
                }
                print(itemList[indexPath.row])
                destination.item = itemList[indexPath.row]
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow{
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }


}

