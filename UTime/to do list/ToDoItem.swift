//
//  ToDoItem.swift
//  UTime
//
//  Created by maegan on 7/29/25.
//


import Foundation
import SwiftData

@Model

class ToDoItem{
    var title: String
    var isImportant: Bool
    
    init(title: String, isImportant: Bool){
        self.title = title
        self.isImportant = isImportant
    }
}

