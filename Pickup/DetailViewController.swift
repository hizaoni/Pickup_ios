//
//  DetailViewController.swift
//  Pickup
//
//  Created by 高本直矢 on 2022/06/09.
//

import UIKit

class DetailViewController: UIViewController {
    
    struct itemDetail {
        var id: Int
        var name: String
        var quantity: Int
        
        init(id: Int, name: String, quantity: Int){
            self.id = id
            self.name = name
            self.quantity = quantity
        }
    }
    
    var item: (id: Int, name: String, quantity: Int) = (id : 0, name: "", quantity: 0)
    
    

    @IBOutlet weak var itemId: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemId.text = "\(String(describing: item.id))"
        itemName.text = item.name
        itemQuantity.text = "\(String(describing: item.quantity))"

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
