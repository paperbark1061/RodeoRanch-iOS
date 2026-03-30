import SwiftUI

struct NotificationsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var notifications = MockData.notifications

    var body: some View {
        NavigationStack {
            List {
                ForEach(notifications) { notif in
                    NotificationRow(notification: notif)
                        .onTapGesture {
                            markRead(id: notif.id)
                        }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Mark all read") { markAllRead() }
                        .font(.rrBodySm)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }

    private func markRead(id: String) {
        if let idx = notifications.firstIndex(where: { $0.id == id }) {
            notifications[idx].isRead = true
        }
    }

    private func markAllRead() {
        notifications = notifications.map { var n = $0; n.isRead = true; return n }
    }
}

struct NotificationRow: View {
    let notification: AppNotification

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.12))
                    .frame(width: 38, height: 38)
                Image(systemName: iconName)
                    .foregroundColor(iconColor)
                    .font(.system(size: 16))
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(notification.title)
                        .font(.rrTitle3)
                        .foregroundColor(notification.isRead ? .secondary : .primary)
                    Spacer()
                    if !notification.isRead {
                        Circle().fill(Color.rrInfo).frame(width: 8, height: 8)
                    }
                }
                Text(notification.body)
                    .font(.rrBodySm)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                Text(notification.createdAt, style: .relative)
                    .font(.rrCaption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
        .listRowBackground(notification.isRead ? Color.clear : Color.rrInfo.opacity(0.05))
    }

    private var iconName: String {
        switch notification.type {
        case .drawReleased:    return "list.number"
        case .runUpNext:       return "bell.badge.fill"
        case .resultsPosted:   return "flag.checkered"
        case .entryConfirmed:  return "checkmark.circle.fill"
        case .eventReminder:   return "calendar.badge.clock"
        case .general:         return "megaphone.fill"
        }
    }

    private var iconColor: Color {
        switch notification.type {
        case .runUpNext: return .rrWarning
        case .resultsPosted, .entryConfirmed: return .rrSuccess
        default: return .rrInfo
        }
    }
}
