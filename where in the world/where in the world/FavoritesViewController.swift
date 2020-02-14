//
//  FavoritesViewController.swift
//  where in the world
//
//  Created by Li Zhang on 2020-02-13.
//  Copyright © 2020 Li Zhang. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var favTable: UITableView!
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var favPlaces = UserDefaults.standard.object(forKey: "favPlaces") as! [String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTable.dataSource = self
        favTable.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = favPlaces[indexPath.row]
        return cell
    }
    

}
