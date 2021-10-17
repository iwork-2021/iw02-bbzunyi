//
//  TableViewController.swift
//  Reminder
//
//  Created by bb on 2021/10/15.
//

import UIKit

class TableViewController: UITableViewController {

    var items:[ReminderItem] = [ ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 20)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        //UINavigationBar.appearance().titleTextAttributes = attributes
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "background.png"))
        

    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadItem()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    let bgColors = [UIColor.yellow, UIColor.systemGreen,UIColor.systemBlue,UIColor.systemOrange]
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as! TableViewCell
        let item = items[indexPath.row]
        let bgColor = UIColor(red: 0.12, green: 0.39, blue: 0.806, alpha: 0.3)
        cell.backgroundColor = bgColor
        // Configure the cell...
        cell.title.text! = item.title
        if item.isChecked{
            cell.status.text!="✅"
        } else{
            cell.status.text!=" "
        }
        return cell
    }
    
    private func handleDelete(row: Int) {
        self.items.remove(at: row)
        self.tableView.reloadData()
        print("Delete")
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt
                            indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive,
                                       title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.handleDelete(row: indexPath.row)
                                        completionHandler(true)
        }
        delete.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    override func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "additem"{
            let addItemViewController = segue.destination as! ItemViewController
            addItemViewController.addItemDelegate = self
        }else if segue.identifier == "edititem" {
            let EditItemViewController = segue.destination as! ItemViewController
            let cell = sender as! TableViewCell
            var isChecked: Bool = false
            if cell.status.text! == "✅"{
                isChecked = true
            }
            let item = ReminderItem(title: cell.title.text!, isChecked: isChecked)
            EditItemViewController.itemToEdit = item
            EditItemViewController.itemIndex = tableView.indexPath(for: cell)!.row
            EditItemViewController.editItemDelegate = self
        }
    }
    

}

extension TableViewController: AddItemDelegate{
    func addItem(item: ReminderItem) {
        self.items.append(item)
        self.tableView.reloadData()
    }
}
extension TableViewController: EditItemDelegate{
    func editItem(newItem: ReminderItem, itemIndex: Int) {
        self.items[itemIndex] = newItem
        self.tableView.reloadData()
    }
}
extension TableViewController{
    func dataFilePath()->URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return path!.appendingPathComponent("TodoItems.json")
    }
    
    func saveAllItems(){
        do{
            let data = try JSONEncoder().encode(items)
            try data.write(to: dataFilePath(),options: .atomic)
        }catch{
            print("Can not save: \(error.localizedDescription)")
        }
    }
    
    func loadItem(){
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path){
            do{
                items = try JSONDecoder().decode([ReminderItem].self, from: data)
            } catch{
                print("Error decoding list:\(error.localizedDescription)")
            }
        }
    }
}
