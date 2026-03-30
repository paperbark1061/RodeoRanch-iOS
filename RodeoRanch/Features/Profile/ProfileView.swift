import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authState: AuthState
    @State private var showEditProfile = false

    var user: User? { authState.currentUser }

    var body: some View {
        NavigationStack {
            List {
                // Avatar + name header
                Section {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle().fill(Color.rrNavy)
                            Text(initials).font(.rrTitle2).foregroundColor(.white)
                        }
                        .frame(width: 64, height: 64)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(user?.fullName ?? "").font(.rrTitle2)
                            Text(user?.email ?? "").font(.rrBodySm).foregroundColor(.secondary)
                            if let club = user?.clubName {
                                Text(club).font(.rrCaption).foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }

                // Membership
                Section("Membership") {
                    if let mem = user?.membershipNumber {
                        LabeledContent("Member #", value: mem)
                    }
                    LabeledContent("Region", value: user?.region.displayName ?? "")
                    if let phone = user?.phone {
                        LabeledContent("Phone", value: phone)
                    }
                }

                // Roles
                Section("Roles") {
                    ForEach(user?.roles ?? [], id: \.rawValue) { role in
                        HStack {
                            Image(systemName: roleIcon(role))
                                .foregroundColor(.rrNavy)
                                .frame(width: 24)
                            Text(role.rawValue.replacingOccurrences(of: "_", with: " ").capitalized)
                        }
                    }
                }

                // Settings
                Section("Settings") {
                    Button { showEditProfile = true } label: {
                        Label("Edit profile", systemImage: "pencil")
                    }
                    NavigationLink {
                        NotificationSettingsView()
                    } label: {
                        Label("Notification settings", systemImage: "bell")
                    }
                }

                // Sign out
                Section {
                    Button(role: .destructive) {
                        authState.logout()
                    } label: {
                        Label("Sign out", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Profile")
            .sheet(isPresented: $showEditProfile) {
                EditProfileView()
            }
        }
    }

    private var initials: String {
        guard let u = user else { return "?" }
        return "\(u.firstName.prefix(1))\(u.lastName.prefix(1))"
    }

    private func roleIcon(_ role: UserRole) -> String {
        switch role {
        case .rider:       return "person.fill"
        case .judge:       return "stopwatch.fill"
        case .clubAdmin:   return "building.2.fill"
        case .eventAdmin:  return "calendar.badge.gear"
        case .superAdmin:  return "shield.fill"
        }
    }
}

struct NotificationSettingsView: View {
    @State private var drawReleased = true
    @State private var runUpNext = true
    @State private var results = true
    @State private var general = false

    var body: some View {
        Form {
            Section("Push notifications") {
                Toggle("Draw released",    isOn: $drawReleased)
                Toggle("You\'re up next",  isOn: $runUpNext)
                Toggle("Results posted",   isOn: $results)
                Toggle("General updates",  isOn: $general)
            }
        }
        .navigationTitle("Notifications")
    }
}

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authState: AuthState
    @State private var firstName = MockData.currentUser.firstName
    @State private var lastName  = MockData.currentUser.lastName
    @State private var phone     = MockData.currentUser.phone ?? ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Personal details") {
                    TextField("First name", text: $firstName)
                    TextField("Last name",  text: $lastName)
                    TextField("Phone",      text: $phone).keyboardType(.phonePad)
                }
                Section {
                    RRButton(title: "Save changes") {
                        // TODO: PATCH /api/auth/me
                        dismiss()
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            .navigationTitle("Edit profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
