//
//  ReminderItem.swift
//  Reminder
//
//  Created by bb on 2021/10/15.
//

import UIKit

class ReminderItem: NSObject,Encodable,Decodable{
    var title:String
    var isChecked:Bool
    
    init(title:String,isChecked:Bool){
        self.title = title
        self.isChecked = isChecked
    }
}
