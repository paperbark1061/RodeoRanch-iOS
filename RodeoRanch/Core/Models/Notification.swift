import Foundation

struct AppNotification: Identifiable, Codable {
    let id: String
    var type: NotificationType
    var title: String
    var body: String
    var eventId: String?
    var runId: String?
    var isRead: Bool
    var createdAt: Date
}

enum NotificationType: String, Codable {
    case drawReleased = "draw_released"
    case runUpNext = "run_up_next"
    case resultsPosted = "results_posted"
    case entryConfirmed = "entry_confirmed"
    case eventReminder = "event_reminder"
    case general
}
