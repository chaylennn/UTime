//
//
//  UTime
//
//  Created by chaylen on 7/29/25.
//

import Foundation
import SwiftData

@Model
class JournalEntry: Identifiable {
    var title: String
    var content: String
    var date: Date
    var mood: String?

    init(title: String, content: String, date: Date, mood: String? = nil) {
        self.title = title
        self.content = content
        self.date = date
        self.mood = mood
    }
}
