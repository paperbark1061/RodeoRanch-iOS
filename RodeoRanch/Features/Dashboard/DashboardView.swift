import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var authState: AuthState
    @EnvironmentObject var router: AppRouter
    @State private var showNotifications = false

    var user: User? { authState.currentUser }
    var liveEvents: [Event] { MockData.events.filter { $0.status == .live } }
    var upcomingRuns: [Run]  { MockData.myRuns.filter { $0.status == .upcoming } }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Greeting
                    VStack(alignment: .leading, spacing: 4) {
                        Text("G'day, \(user?.firstName ?? "Rider")")
                            .font(.rrTitle)
                            .foregroundColor(.rrTextPrimary)
                        Text(user?.clubName ?? "")
                            .font(.rrBodySm)
                            .foregroundColor(.rrTextSecondary)
                    }
                    .padding(.horizontal)

                    // Next run card
                    if let nextRun = upcomingRuns.first {
                        NextRunCard(run: nextRun).padding(.horizontal)
                    }

                    // Live events
                    if !liveEvents.isEmpty {
                        SectionHeader(title: "Live now", icon: "dot.radiowaves.left.and.right")
                            .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(liveEvents) { LiveEventCard(event: $0) }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Quick actions
                    SectionHeader(title: "Quick actions", icon: "bolt.fill")
                        .padding(.horizontal)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        QuickActionTile(title: "Enter event", icon: "plus.circle.fill",  color: .rrNavy)  { router.navigate(to: .events) }
                        QuickActionTile(title: "My runs",    icon: "timer",              color: .discGold) { router.navigate(to: .myRuns) }
                        QuickActionTile(title: "Standings",  icon: "list.number",        color: .discBlue) { router.navigate(to: .standings) }
                        if authState.currentUser?.isJudge == true {
                            QuickActionTile(title: "Judge mode", icon: "stopwatch.fill", color: .discTeal) { router.navigate(to: .judge) }
                        }
                    }
                    .padding(.horizontal)

                    Spacer(minLength: 32)
                }
                .padding(.top, 8)
            }
            .background(Color.rrBg2)
            .navigationTitle("RodeoRanch")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { showNotifications = true } label: {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.rrNavy)
                            let unread = MockData.notifications.filter { !$0.isRead }.count
                            if unread > 0 {
                                Circle().fill(Color.rrDanger)
                                    .frame(width: 8, height: 8)
                                    .offset(x: 4, y: -2)
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showNotifications) { NotificationsView() }
        }
    }
}

// MARK: - Sub-components

struct NextRunCard: View {
    let run: Run
    var body: some View {
        RRCard {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    DisciplineBadge(discipline: run.discipline)
                    Text(run.eventName).font(.rrLabel).foregroundColor(.rrTextSecondary)
                    Spacer()
                    EventStatusBadge(status: .live)
                }
                Text("You're run #\(run.drawPosition ?? 0)")
                    .font(.rrTitle2)
                    .foregroundColor(.rrTextPrimary)
                Text("\(run.horseName) · \(run.division ?? "Open")")
                    .font(.rrBodySm)
                    .foregroundColor(.rrTextSecondary)
                if let team = run.teamMembers {
                    Text(team.joined(separator: " · "))
                        .font(.rrCaption)
                        .foregroundColor(.rrTextSecondary)
                }
            }
        }
    }
}

struct LiveEventCard: View {
    let event: Event
    var body: some View {
        RRCard(padding: 14) {
            VStack(alignment: .leading, spacing: 8) {
                DisciplineBadge(discipline: event.discipline, size: .small)
                Text(event.name).font(.rrTitle3).foregroundColor(.rrTextPrimary).lineLimit(2)
                Text(event.venue).font(.rrCaption).foregroundColor(.rrTextSecondary).lineLimit(1)
                EventStatusBadge(status: event.status)
            }
            .frame(width: 180)
        }
    }
}

struct QuickActionTile: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 26))
                    .foregroundColor(.white)
                Text(title)
                    .font(.rrLabel)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct SectionHeader: View {
    let title: String
    let icon: String
    var body: some View {
        Label(title, systemImage: icon)
            .font(.rrTitle3)
            .foregroundColor(.rrTextPrimary)
    }
}
