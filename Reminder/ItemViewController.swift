//
//  ItemViewController.swift
//  Reminder
//
//  Created by bb on 2021/10/16.
//

import UIKit

protocol AddItemDelegate {
    func addItem(item : ReminderItem)
}

protocol EditItemDelegate{
    func editItem(newItem: ReminderItem, itemIndex: Int)
}

class ItemViewController: UIViewController {

    
    @IBOutlet weak var DoneButton: UIButton!
    @IBOutlet weak var TitleInput: UITextField!
    @IBOutlet weak var isChecked: UISwitch!
    
    var addItemDelegate: AddItemDelegate?
    var editItemDelegate: EditItemDelegate?
    var itemToEdit: ReminderItem?
    var itemIndex: Int = 0
    
    func addBackground(){
        // Create an UIImage object variable.
       let screenSize: CGRect = UIScreen.main.bounds
       let screenWidth = Int(screenSize.width)
       let screenHeight = Int(screenSize.height)
       let uiImage = UIImage(named: "itemViewBackground")
       let imageFrame: CGRect = CGRect(x:0, y:0, width:(screenWidth), height:Int(screenHeight))
       // Create a UIView object which use above CGRect object.
       let imageView = UIImageView(frame: imageFrame)
       // Create a UIColor object which use above UIImage object.
       // Set above image as UIView's background.
       imageView.image = uiImage
       imageView.contentMode = UIView.ContentMode.scaleToFill
       // Add above UIView object as the main view's subview.
       self.view.addSubview(imageView)
       self.view.sendSubviewToBack(imageView)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        DoneButton.isEnabled = false
        
        if itemToEdit != nil{
            DoneButton.isEnabled = true
            self.TitleInput.text! = itemToEdit!.title
            self.isChecked.isOn = itemToEdit!.isChecked
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func done(_ sender: Any) {
        if itemToEdit == nil{
            self.addItemDelegate?.addItem(item: ReminderItem(title: TitleInput.text!, isChecked: isChecked.isOn))
        }else{
            self.editItemDelegate?.editItem(newItem: ReminderItem(title: TitleInput.text!, isChecked: isChecked.isOn), itemIndex: self.itemIndex)
        }
    
        self.dismiss(animated: true, completion: nil)
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

extension ItemViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range,in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        DoneButton.isEnabled = !newText.isEmpty
        return true
    }
}
