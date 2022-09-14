//
//  ViewController.swift
//  Exitek iOS Task
//
//  Created by Илья Синицын on 02.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var imeiTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var mobiles: [Mobile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        
        mobiles = Array(CoreDataManager.shared.getAll())
    }

    @IBAction func saveButton(_ sender: Any) {
        guard let modelText = modelTextField.text, let imeiText = imeiTextField.text, modelText != "", imeiText != "" else { return }
        let mobile = CoreDataManager.shared.createMobile(model: modelText, imei: imeiText)
        
        print("Mobile-\(mobile.imei)")
        guard let _ = try? CoreDataManager.shared.save(mobile) else { return }
        
        mobiles = Array(CoreDataManager.shared.getAll())
        tableView.reloadData()
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        //CoreDataManager.shared.delete(<#T##product: Mobile##Mobile#>)
    }
    
    @IBAction func findButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Search mobile by imei", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter imei"
            textField.textAlignment = .center
        }
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = alertController.textFields?.first?.text, text != "" else { return }
            CoreDataManager.shared.findByImei(text)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mobiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         
        let mobile = mobiles[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.text = "Model: \(mobile.model ?? ""), imei: \(mobile.imei ?? "")"
         
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, complete) in
            self?.mobiles.remove(at: indexPath.row)
            //CoreDataManager.shared.delete(<#T##product: Mobile##Mobile#>)
            self?.tableView.reloadData()
            complete(true)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeActions.performsFirstActionWithFullSwipe = false
        
        return swipeActions
    }
}

