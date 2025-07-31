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

    init(title: String, content: String, date: Date) {
        self.title = title
        self.content = content
        self.date = date
    }
}
